#!/usr/bin/env bash
set -euo pipefail

appid="$1"
addresses="${2:-}"
url="${STEAM_API_URL:-https://api.steampowered.com/IGameServersService/GetServerList/v1/}"
cap="${STEAM_CAP:-10000}"
splits=('\noplayers\1' '\linux\1' '\secure\1' '\dedicated\1' '\password\1' '\full\1')
reply="$(mktemp)"
found="$(mktemp)"
trap 'rm -f "${reply}" "${found}"' EXIT
partial=false

fetch() {
	printf '%s' "${STEAM_API_KEY:?}" | curl -fsS --max-time 30 -A "Master-Server-List checker" -G -o "${reply}" \
		--data-urlencode "key@-" --data-urlencode "filter=\\appid\\${appid}$1" --data-urlencode "limit=${cap}" "${url}" 2>/dev/null &&
		jq -e '.response | type == "object"' "${reply}" >/dev/null 2>&1
}

collect() {
	local filter="$1" depth="$2" returned
	if ! fetch "${filter}"; then
		((depth > 0)) || exit 1
		partial=true
		return
	fi
	returned="$(jq '.response.servers // [] | length' "${reply}")"
	jq -r '.response.servers[]?.addr // empty' "${reply}" >>"${found}"
	((returned >= cap)) || return 0
	if ((depth < ${#splits[@]})); then
		collect "${filter}${splits[depth]}" $((depth + 1))
		collect "${filter}\\nor\\1${splits[depth]}" $((depth + 1))
	else
		partial=true
	fi
}

collect "" 0
if [[ -n "${addresses}" ]]; then
	sort -u "${found}" >"${addresses}"
fi
sort -u "${found}" | grep -c . || true
[[ "${partial}" == false ]] || exit 3
