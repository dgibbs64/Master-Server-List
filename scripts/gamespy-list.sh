#!/usr/bin/env bash
set -euo pipefail

host="$1"
port="$2"
gamename="$3"
key="$4"
addresses="${5:-}"
format="${6:-text}"
push="${7:-false}"
here="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

fail() {
	printf 'GameSpy %s:%s (%s): %s\n' "${host}" "${port}" "${gamename}" "$2" >&2
	exit "$1"
}

{ exec 3<>"/dev/tcp/${host}/${port}"; } 2>/dev/null || fail 2 "TCP connection failed"
if [[ "${push}" == true && "${format}" == enctype2 ]]; then
	# These masters stream the encrypted list immediately after this prefix,
	# without a challenge. Reading six challenge bytes would truncate the list.
	banner="$(timeout 5 head -c 15 <&3)" || true
	[[ "${banner}" == "\\basic\\\\secure\\" ]] || fail 3 "Invalid pushed-list banner"
else
	banner="$(timeout 5 head -c 21 <&3)" || true
	[[ "${banner}" == *"\\secure\\"* ]] || fail 3 "No GameSpy challenge received"
	secure="${banner#*\\secure\\}"
	secure="${secure:0:6}"
	[[ "${#secure}" -eq 6 ]] || fail 3 "Incomplete GameSpy challenge"
	validate="$(GS_SECURE="${secure}" GS_KEY="${key}" LC_ALL=C gawk -f "${here}/gsmsalg.awk" </dev/null)"
	listmode=""
	[[ "${format}" == enctype2 ]] && listmode="cmp"
	printf '%s' "\\gamename\\${gamename}\\location\\0\\validate\\${validate}\\final\\\\list\\${listmode}\\gamename\\${gamename}\\final\\" >&3
fi
if [[ "${format}" == enctype2 ]]; then
	encrypted="$(mktemp)"
	trap 'rm -f "${encrypted}"' EXIT
	timeout 10 head -c 4194305 <&3 >"${encrypted}" || true
	response="$("${GAMESPY_ENCTYPE2:-${here}/gamespy-enctype2}" "${key}" "${encrypted}")" || fail 5 "Invalid or incomplete Enctype 2 list response"
else
	response="$(timeout 10 cat <&3 | tr -d '\0')" || true
fi
exec 3>&-
if [[ "${response}" == *"\\error\\"* ]]; then
	message="${response#*\\error\\}"
	fail 4 "Query rejected: ${message:0:160}"
fi
[[ "${response}" == *$'\\final\\'* ]] || fail 5 "Incomplete GameSpy list response"
if [[ -n "${addresses}" ]]; then
	{ grep -oE '\\ip\\[0-9]{1,3}(\.[0-9]{1,3}){3}:[0-9]{1,5}' <<<"${response}" || true; } | sed 's/^\\ip\\//' >"${addresses}"
fi
{ grep -oF $'\\ip\\' <<<"${response}" || true; } | wc -l
