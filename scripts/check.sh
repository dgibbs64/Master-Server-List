#!/usr/bin/env bash
set -euo pipefail

file="${1:-servers.json}"
today="$(date -u +%F)"
here="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
reply="$(mktemp)"
trap 'rm -f "${reply}"' EXIT

resolves() {
	local addr
	addr="$(getent ahostsv4 "$1" | awk 'NR==1 {print $1}')" || true
	[[ -n "${addr}" && "${addr}" != "0.0.0.0" ]]
}

udp_query() {
	printf '%b' "$3" | timeout 8 nc -u -w 3 "$1" "$2" >"${reply}" 2>/dev/null || true
	[[ -s "${reply}" ]]
}

reply_bytes() {
	od -An -v -tu1 "${reply}" | tr -s ' \n' '\n' | sed '/^$/d'
}

int32le() {
	printf '\\x%02x\\x%02x\\x%02x\\x%02x' $(($1 & 255)) $((($1 >> 8) & 255)) $((($1 >> 16) & 255)) $((($1 >> 24) & 255))
}

count_getservers() {
	reply_bytes | awk '{ b[NR] = $1 } END {
		c = 0
		for (i = 1; i <= NR; i++) {
			if (b[i] != 92) continue
			if (b[i + 1] == 69 && b[i + 2] == 79 && (b[i + 3] == 84 || b[i + 3] == 70)) { i += 3; continue }
			if (i + 6 <= NR) { c++; i += 6 }
		}
		print c
	}'
}

count_packed() {
	reply_bytes | awk -v hlen="$1" '{ b[NR] = $1 } END {
		headers = 0
		for (i = 1; i + 3 <= NR; i++) if (b[i] == 255 && b[i + 1] == 255 && b[i + 2] == 255 && b[i + 3] == 255) { headers++; i += 3 }
		if (headers == 0) headers = 1
		print int((NR - headers * hlen) / 6)
	}'
}

count_zandronum() {
	reply_bytes | awk '{ b[NR] = $1 } END {
		c = 0; i = 1
		while (i <= NR) {
			if (b[i] == 255 && b[i + 1] == 6 && b[i + 2] == 0 && b[i + 3] == 0 && b[i + 4] == 0 && b[i + 6] == 8) {
				i += 7
				while (i <= NR && b[i] != 0) { n = b[i]; c += n; i += 1 + 4 + n * 2 }
			}
			i++
		}
		print c
	}'
}

count_odamex() {
	reply_bytes | awk 'NR == 5 { lo = $1 } NR == 6 { hi = $1 } END { print lo + hi * 256 }'
}

count_chocolatedoom() {
	reply_bytes | awk 'NR > 2 && $1 == 0 { c++ } END { print c + 0 }'
}

probe_once() {
	local host="$1" type="$2" port="$3" game="$4" protocol="$5" gamename="$6" key="$7" url="$8" jqexpr="$9" pattern="${10}" count
	case "${type}" in
		tcp)
			timeout 5 bash -c "exec 3<>/dev/tcp/${host}/${port}" 2>/dev/null && echo "online|"
			;;
		cube2)
			{
				printf 'list\n'
				sleep 3
			} | timeout 8 nc "${host}" "${port}" >"${reply}" 2>/dev/null || true
			[[ -s "${reply}" ]] && echo "online|$(grep -c '^addserver' "${reply}" || true)"
			;;
		http)
			if curl -fsSL --max-time 25 -A "Master-Server-List checker" -o "${reply}" "${url}" 2>/dev/null; then
				count=""
				if [[ -n "${jqexpr}" ]]; then
					count="$(jq -r "${jqexpr}" "${reply}" 2>/dev/null)" || count=""
				elif [[ -n "${pattern}" ]]; then
					count="$({ grep -aoE "${pattern}" "${reply}" || true; } | wc -l)"
				fi
				[[ "${count}" =~ ^[0-9]+$ ]] || count=""
				echo "online|${count}"
			fi
			;;
		gamespy)
			if count="$(timeout 20 "${here}/gamespy-list.sh" "${host}" "${port}" "${gamename}" "${key}" 2>/dev/null)"; then
				echo "online|${count}"
			fi
			;;
		getservers)
			udp_query "${host}" "${port}" "\xff\xff\xff\xffgetservers ${game:+${game} }${protocol} full empty" && echo "online|$(count_getservers)"
			;;
		q2query)
			udp_query "${host}" "${port}" "query" && echo "online|$(count_packed 12)"
			;;
		qwquery)
			udp_query "${host}" "${port}" "c\n" && echo "online|$(count_packed 6)"
			;;
		idtech4)
			udp_query "${host}" "${port}" "\xff\xffgetServers\x00$(int32le "${protocol}")\x00\x00\x00\x00" && echo "online|$(count_packed 10)"
			;;
		zandronum)
			udp_query "${host}" "${port}" "\xff\x7c\x5d\x56\x00\x02\x00" && echo "online|$(count_zandronum)"
			;;
		odamex)
			udp_query "${host}" "${port}" "\xa3\xdb\x0b\x00" && echo "online|$(count_odamex)"
			;;
		chocolatedoom)
			udp_query "${host}" "${port}" "\x00\x02" && echo "online|$(count_chocolatedoom)"
			;;
	esac
	return 0
}

probe() {
	local host="$1" type="$2" result attempt
	if ! resolves "${host}"; then
		echo "no-dns|"
		return
	fi
	if [[ "${type}" == "dns" ]]; then
		echo "dns-only|"
		return
	fi
	for attempt in 1 2 3; do
		result="$(probe_once "$@")"
		if [[ -n "${result}" ]]; then
			echo "${result}"
			return
		fi
		[[ "${attempt}" -lt 3 ]] && sleep $((attempt * 3))
	done
	echo "no-response|"
}

results='{}'
while IFS= read -r entry; do
	mapfile -t fields < <(jq -r '.[0], (.[1] | .type, .port, .game, .protocol, .gamename, .key, .url, .jq, .pattern) | . // "" | tostring' <<<"${entry}")
	IFS='|' read -r status servers < <(probe "${fields[@]}")
	printf '%-12s %6s  %s\n' "${status}" "${servers}" "${fields[0]} ${fields[1]} ${fields[2]} ${fields[3]}${fields[5]} ${fields[4]}" >&2
	results="$(jq --arg k "${entry}" --arg s "${status}" --arg n "${servers}" '. + {($k): {status: $s, servers: (if $n == "" then null else ($n | tonumber) end)}}' <<<"${results}")"
done < <(jq -c '[.games[].masters[] | [.host, .probe]] | unique[]' "${file}")

jq --argjson results "${results}" --arg today "${today}" '
	.checked = $today
	| .games[].masters[] |= (
		$results[[.host, .probe] | tojson] as $r
		| .status = $r.status
		| .servers = (if .probe.count == false then null else $r.servers end)
		| .last_seen = (if .status == "online" then $today else (.last_seen // null) end)
	)' "${file}" >"${file}.tmp"
mv "${file}.tmp" "${file}"
