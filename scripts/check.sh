#!/usr/bin/env bash
set -euo pipefail

file="${1:-servers.json}"
today="$(date -u +%F)"

resolves() {
	local addr
	addr="$(getent ahostsv4 "$1" | awk 'NR==1 {print $1}')" || true
	[[ -n "${addr}" && "${addr}" != "0.0.0.0" ]]
}

udp_responds() {
	local host="$1" port="$2" payload="$3" bytes
	bytes="$(printf '%b' "${payload}" | timeout 6 nc -u -w 4 "${host}" "${port}" 2>/dev/null | wc -c)" || true
	((bytes > 0))
}

probe() {
	local host="$1" type="$2" port="$3" protocol="$4"
	if ! resolves "${host}"; then
		echo "no-dns"
		return
	fi
	if [[ "${type}" == "dns" ]]; then
		echo "dns-only"
		return
	fi
	for _ in 1 2; do
		case "${type}" in
			tcp)
				timeout 5 bash -c "exec 3<>/dev/tcp/${host}/${port}" 2>/dev/null && echo "online" && return
				;;
			getservers)
				udp_responds "${host}" "${port}" "\xff\xff\xff\xffgetservers ${protocol} empty full" && echo "online" && return
				;;
			q2query)
				udp_responds "${host}" "${port}" "query" && echo "online" && return
				;;
		esac
	done
	echo "no-response"
}

results='{}'
while IFS='|' read -r host type port protocol; do
	status="$(probe "${host}" "${type}" "${port}" "${protocol}")"
	printf '%-12s %s\n' "${status}" "${host} ${type} ${port} ${protocol}" >&2
	results="$(jq --arg k "${host}|${type}|${port}|${protocol}" --arg s "${status}" '. + {($k): $s}' <<<"${results}")"
done < <(jq -r '[.games[].masters[] | [.host, .probe.type, (.probe.port // ""), (.probe.protocol // "")] | map(tostring) | join("|")] | unique[]' "${file}")

jq --argjson results "${results}" --arg today "${today}" '
	.checked = $today
	| .games[].masters[] |= (
		.status = $results["\(.host)|\(.probe.type)|\(.probe.port // "")|\(.probe.protocol // "")"]
		| .last_seen = (if .status == "online" then $today else (.last_seen // null) end)
	)' "${file}" >"${file}.tmp"
mv "${file}.tmp" "${file}"
