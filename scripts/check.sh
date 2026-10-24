#!/usr/bin/env bash
set -euo pipefail

file="${1:-servers.json}"
today="$(date -u +%F)"
here="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
min_interval="${MASTER_MIN_INTERVAL:-30}"
retry_delay="${MASTER_RETRY_DELAY:-30}"
for value in "${min_interval}" "${retry_delay}"; do
	[[ "${value}" =~ ^[0-9]+$ && ${#value} -le 5 ]] || {
		echo "Probe intervals must be non-negative integer seconds" >&2
		exit 1
	}
done
min_interval=$((10#${min_interval}))
retry_delay=$((10#${retry_delay}))
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

addresses_getservers() {
	reply_bytes | awk '
		function hex(c) { return (c >= 48 && c <= 57) || (c >= 65 && c <= 70) || (c >= 97 && c <= 102) }
		function val(c) { return c <= 57 ? c - 48 : (c <= 70 ? c - 55 : c - 87) }
		{ b[NR] = $1 }
		END {
			for (i = 1; i <= NR; i++) {
				if (b[i] != 92) continue
				if (b[i + 1] == 69 && b[i + 2] == 79 && (b[i + 3] == 84 || b[i + 3] == 70)) { i += 3; continue }
				ishex = i + 12 <= NR && b[i + 7] != 92
				for (j = 1; ishex && j <= 12; j++) if (!hex(b[i + j])) ishex = 0
				if (ishex) {
					printf "%d.%d.%d.%d:%d\n", val(b[i+1]) * 16 + val(b[i+2]), val(b[i+3]) * 16 + val(b[i+4]), val(b[i+5]) * 16 + val(b[i+6]), val(b[i+7]) * 16 + val(b[i+8]), ((val(b[i+9]) * 16 + val(b[i+10])) * 256) + val(b[i+11]) * 16 + val(b[i+12])
					i += 12
				} else if (i + 6 <= NR) {
					printf "%d.%d.%d.%d:%d\n", b[i+1], b[i+2], b[i+3], b[i+4], b[i+5] * 256 + b[i+6]
					i += 6
				}
			}
		}'
}

addresses_packed() {
	reply_bytes | awk -v hlen="$1" '{ b[NR] = $1 } END {
		i = 1 + hlen
		while (i + 5 <= NR) {
			if (b[i] == 255 && b[i + 1] == 255 && b[i + 2] == 255 && b[i + 3] == 255) { i += hlen; continue }
			printf "%d.%d.%d.%d:%d\n", b[i], b[i+1], b[i+2], b[i+3], b[i+4] * 256 + b[i+5]
			i += 6
		}
	}'
}

addresses_cube2() {
	awk '/^addserver/ { print $2 ":" $3 }' "${reply}"
}

addresses_http() {
	if jq -e . "${reply}" >/dev/null 2>&1; then
		jq -r -f "${here}/addresses.jq" "${reply}"
	else
		{ grep -aoE '[0-9]{1,3}(\.[0-9]{1,3}){3}(:|[[:blank:]]+)[0-9]{1,5}' "${reply}" || true; } | sed -E 's/[[:blank:]]+/:/'
	fi
}

save_addresses() {
	[[ -n "${addrfile:-}" ]] || return 0
	"$@" | sort -u >"${addrfile}" || true
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

addresses_tribes1() {
	reply_bytes | awk '{ b[NR] = $1 } END {
		for (i = 1; i + 7 <= NR; i++) {
			if (b[i] == 16 && b[i + 1] == 6 && b[i + 4] == 1 && b[i + 5] == 2 && b[i + 6] == 0 && b[i + 7] == 102) starts[++n] = i
		}
		for (k = 1; k <= n; k++) {
			end = (k < n ? starts[k + 1] : NR + 1)
			num = b[starts[k] + 2]
			part[num] = ""
			for (j = starts[k] + 8; j < end; j++) part[num] = part[num] " " b[j]
			if (num > total) total = num
		}
		data = ""
		for (k = 1; k <= total; k++) data = data part[k]
		m = split(data, d, " ")
		p = 1
		p += 1 + d[p]
		p += 1 + d[p]
		while (p <= m) {
			p++
			count = d[p++]
			for (c = 0; c < count && p + 6 <= m; c++) {
				if (d[p] != 6) exit
				printf "%d.%d.%d.%d:%d\n", d[p + 1], d[p + 2], d[p + 3], d[p + 4], d[p + 5] + d[p + 6] * 256
				p += 7
			}
		}
	}'
}

probe_once() {
	local host="$1" type="$2" port="$3" game="$4" protocol="$5" gamename="$6" key="$7" url="$8" jqexpr="$9" pattern="${10}" count rc format="${11:-text}" push="${12:-false}"
	case "${type}" in
	tcp)
		# shellcheck disable=SC2016 # Positional arguments expand in the child shell.
		if timeout 5 bash -c 'exec 3<>"/dev/tcp/$1/$2"' _ "${host}" "${port}" 2>/dev/null; then
			echo "online|"
		else
			echo "no-response||connection-failed"
		fi
		;;
	cube2)
		{
			printf 'list\n'
			sleep 3
		} | timeout 8 nc "${host}" "${port}" >"${reply}" 2>/dev/null || true
		if [[ -s "${reply}" ]]; then
			save_addresses addresses_cube2
			echo "online|$(grep -c '^addserver' "${reply}" || true)"
		fi
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
			save_addresses addresses_http
			echo "online|${count}"
		fi
		;;
	gamespy)
		if count="$(timeout 20 "${here}/gamespy-list.sh" "${host}" "${port}" "${gamename}" "${key}" "${addrfile:-}" "${format}" "${push}")"; then
			echo "online|${count}"
		else
			rc=$?
			case "${rc}" in
			2) echo "no-response||connection-failed" ;;
			3) echo "no-response||challenge-incomplete" ;;
			4) echo "no-response||validation-rejected" ;;
			5) echo "no-response||incomplete-response" ;;
			124) echo "no-response||timeout" ;;
			*) echo "no-response||query-failed" ;;
			esac
		fi
		;;
	enctypex)
		if count="$(timeout 30 "${ENCTYPEX:-${here}/enctypex}" "${host}" "${port}" "${gamename}" "${key}" "${addrfile:-}" 2>/dev/null)"; then
			echo "online|${count}"
		else
			rc=$?
			if [[ "${rc}" == 124 ]]; then echo "no-response||timeout"; else echo "no-response||query-failed"; fi
		fi
		;;
	getservers)
		udp_query "${host}" "${port}" "\xff\xff\xff\xffgetservers ${game:+${game} }${protocol} full empty" && save_addresses addresses_getservers && echo "online|$(count_getservers)"
		;;
	q2query)
		udp_query "${host}" "${port}" "query" && save_addresses addresses_packed 12 && echo "online|$(count_packed 12)"
		;;
	qwquery)
		udp_query "${host}" "${port}" "c\n" && save_addresses addresses_packed 6 && echo "online|$(count_packed 6)"
		;;
	idtech4)
		udp_query "${host}" "${port}" "\xff\xffgetServers\x00$(int32le "${protocol}")\x00\x00\x00\x00" && save_addresses addresses_packed 10 && echo "online|$(count_packed 10)"
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
	tribes1)
		udp_query "${host}" "${port}" "\x10\x03\xff\x00\x01\x02" && save_addresses addresses_tribes1 && echo "online|$(addresses_tribes1 | sort -u | wc -l)"
		;;
	esac
	return 0
}

probe() {
	local result
	if ! resolves "$1"; then
		echo "no-dns||dns-resolution-failed"
		return
	fi
	if [[ "$2" == "dns" ]]; then
		echo "dns-only|"
		return
	fi
	result="$(probe_once "$@")"
	echo "${result:-no-response||no-reply}"
}

results='{}'
if [[ -n "${ADDRESS_DIR:-}" ]]; then
	mkdir -p "${ADDRESS_DIR}"
	: >"${ADDRESS_DIR}/index.tsv"
fi
# Interleave hosts so one master does not receive a burst of game queries.
mapfile -t pending < <(jq -c '
	[.games[].masters[] | [.host, .probe]] | unique | group_by(.[0]) as $groups
	| range(0; ([$groups[] | length] | max // 0)) as $i
	| $groups[] | .[$i] // empty
' "${file}")
declare -A next_host=() retry_after=() transport_down=() address_indexed=() rate_keys=()
for attempt in 1 2 3; do
	# Failures are retried only after the rest of the pass has been checked.
	queue=("${pending[@]}")
	pending=()
	transport_down=()
	while ((${#queue[@]})); do
		waiting=()
		earliest=0
		for entry in "${queue[@]}"; do
			mapfile -t fields < <(jq -r '.[0], (.[1] | .type, .port, .game, .protocol, .gamename, .key, .url, .jq, .pattern, .format, .push) | . // "" | tostring' <<<"${entry}")
			host="${fields[0]}"
			endpoint="${host}:${fields[2]}"
			if [[ -z "${rate_keys[${host}]:-}" ]]; then
				ip="$(getent ahostsv4 "${host}" | awk 'NR==1 {print $1}')" || true
				rate_keys["${host}"]="${ip:-${host}}"
			fi
			rate_key="${rate_keys[${host}]}"
			cached=false
			if [[ ("${fields[1]}" == gamespy || "${fields[1]}" == tcp) && -n "${transport_down[${endpoint}]:-}" ]]; then
				# A refused connection is shared by every game on this endpoint.
				status=no-response servers="" error=connection-failed cached=true
			else
				due="${retry_after[${entry}]:-0}"
				((${next_host[${rate_key}]:-0} > due)) && due="${next_host[${rate_key}]}"
				if ((SECONDS < due)); then
					waiting+=("${entry}")
					if ((earliest == 0 || due < earliest)); then earliest="${due}"; fi
					continue
				fi
				addrfile=""
				if [[ -n "${ADDRESS_DIR:-}" ]] && [[ "$(jq -r '.[1].addresses' <<<"${entry}")" != false ]]; then
					addrfile="${ADDRESS_DIR}/$(printf '%s' "${entry}" | sha1sum | cut -c1-16).txt"
					rm -f "${addrfile}"
					if [[ -z "${address_indexed[${entry}]:-}" ]]; then
						printf '%s\t%s\n' "${entry}" "${addrfile}" >>"${ADDRESS_DIR}/index.tsv"
						address_indexed["${entry}"]=1
					fi
				fi
				IFS='|' read -r status servers error < <(probe "${fields[@]}")
				next_host["${rate_key}"]=$((SECONDS + min_interval))
				if [[ "${error}" == connection-failed ]]; then transport_down["${endpoint}"]=1; fi
			fi
			printf '%-12s %6s  %s %s %s attempt=%s/3%s%s\n' "${status}" "${servers}" "${host}" "${fields[1]}" "${fields[5]}" "${attempt}" "${error:+ reason=${error}}" "$(if [[ "${cached}" == true ]]; then printf ' cached-endpoint-failure'; fi)" >&2
			results="$(jq --arg k "${entry}" --arg s "${status}" --arg n "${servers}" --arg e "${error}" '. + {($k): {status: $s, servers: (if $n == "" then null else ($n | tonumber) end), error: $e}}' <<<"${results}")"
			if [[ "${status}" == no-response || "${status}" == no-dns ]] && ((attempt < 3)); then
				pending+=("${entry}")
				retry_after["${entry}"]=$((SECONDS + attempt * retry_delay))
			fi
		done
		queue=("${waiting[@]}")
		if ((${#queue[@]})); then
			pause=$((earliest - SECONDS))
			((pause > 0)) || pause=1
			sleep "${pause}"
		fi
	done
	((${#pending[@]})) || break
done

jq --argjson results "${results}" --arg today "${today}" '
	.checked = $today
	| .games[].masters[] |= (
		$results[[.host, .probe] | tojson] as $r
		| .status = $r.status
		| .servers = (if .probe.count == false then null else $r.servers end)
		| if $r.error != "" then .check_error = $r.error else del(.check_error) end
		| .last_seen = (if .status == "online" then $today else (.last_seen // null) end)
	)' "${file}" >"${file}.tmp"
mv "${file}.tmp" "${file}"
