#!/usr/bin/env bash
set -euo pipefail

servers="${1:-servers.json}"
history="${2:-history.json}"
today="${3:-$(date -u +%F)}"
list="${4:-}"
keep="${HISTORY_DAYS:-180}"

[[ -s "${history}" ]] || echo '{"days": [], "entries": {}}' >"${history}"
[[ -s "${list}" ]] || list=/dev/null

jq --slurpfile cur "${servers}" --slurpfile list "${list}" --arg today "${today}" --argjson keep "${keep}" '
	def point: [(if .status == "online" then 1 elif .status == "no-response" or .status == "no-dns" then 0 else null end), (.servers // null)] | if . == [null, null] then null else . end;
	(($cur[0] | [.games[] | .name as $g | .masters[] | {key: "\($g)|\(if .port then "\(.host):\(.port)" else .host end)", value: point}] | from_entries)
	+ (($list[0].games // {}) | with_entries({key: "\(.key)|unique", value: [null, .value.unique]}))) as $now
	| (.days // []) as $old_days
	| ($old_days | length) as $old_n
	| (($old_days | last) == $today) as $replace
	| (if $replace then $old_days else $old_days + [$today] end) as $days
	| ($days | length) as $n
	| ([$n - $keep, 0] | max) as $drop
	| (.entries // {}) as $old
	| {
		days: $days[$drop:],
		entries: ([$old | keys[]] + [$now | keys[]] | unique | map(
			. as $k
			| ($old[$k] // []) as $a
			| ($a + [range($a | length; $old_n) | null]) as $padded
			| (if $replace then $padded[:$old_n - 1] else $padded end) + [$now[$k] // null]
			| {key: $k, value: .[$drop:]}
		) | map(select(any(.value[]; . != null))) | from_entries)
	}
' "${history}" >"${history}.tmp"
mv "${history}.tmp" "${history}"
