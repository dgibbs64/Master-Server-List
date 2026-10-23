#!/usr/bin/env bash
set -euo pipefail

host="$1"
port="$2"
gamename="$3"
key="$4"
here="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

exec 3<>"/dev/tcp/${host}/${port}"
banner="$(timeout 5 head -c 21 <&3)" || true
secure="$(printf '%s' "${banner}" | sed -n 's/.*\\secure\\\([A-Za-z]\{6\}\).*/\1/p')"
[[ -n "${secure}" ]] || exit 1
validate="$(LC_ALL=C gawk -v secure="${secure}" -v key="${key}" -f "${here}/gsmsalg.awk")"
printf '%s' "\\gamename\\${gamename}\\location\\0\\validate\\${validate}\\final\\\\list\\\\gamename\\${gamename}\\final\\" >&3
response="$(timeout 10 cat <&3 | tr -d '\0')" || true
exec 3>&-
[[ "${response}" == *$'\\final\\'* ]] || exit 1
{ grep -oF $'\\ip\\' <<<"${response}" || true; } | wc -l
