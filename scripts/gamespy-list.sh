#!/usr/bin/env bash
set -euo pipefail

host="$1"
port="$2"
gamename="$3"
key="$4"
addresses="${5:-}"
here="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

exec 3<>"/dev/tcp/${host}/${port}"
banner="$(timeout 5 head -c 21 <&3)" || true
[[ "${banner}" == *"\\secure\\"* ]] || exit 1
secure="${banner#*\\secure\\}"
secure="${secure:0:6}"
[[ "${#secure}" -eq 6 ]] || exit 1
validate="$(GS_SECURE="${secure}" GS_KEY="${key}" LC_ALL=C gawk -f "${here}/gsmsalg.awk" </dev/null)"
printf '%s' "\\gamename\\${gamename}\\location\\0\\validate\\${validate}\\final\\\\list\\\\gamename\\${gamename}\\final\\" >&3
response="$(timeout 10 cat <&3 | tr -d '\0')" || true
exec 3>&-
[[ "${response}" == *$'\\final\\'* ]] || exit 1
if [[ -n "${addresses}" ]]; then
	{ grep -oE '\\ip\\[0-9]{1,3}(\.[0-9]{1,3}){3}:[0-9]{1,5}' <<<"${response}" || true; } | sed 's/^\\ip\\//' >"${addresses}"
fi
{ grep -oF $'\\ip\\' <<<"${response}" || true; } | wc -l
