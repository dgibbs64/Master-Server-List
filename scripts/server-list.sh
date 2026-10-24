#!/usr/bin/env bash
set -euo pipefail

servers="${1:-servers.json}"
dir="${2:?address directory from check.sh}"
out="${3:-servers-list.json}"
rows="$(mktemp)"
trap 'rm -f "${rows}"' EXIT

index="$(jq -Rn '[inputs | split("\t") | {key: .[0], value: .[1]}] | from_entries' "${dir}/index.tsv")"

while IFS=$'\t' read -r game socket file; do
	[[ -s "${file}" ]] || continue
	awk -v g="${game}" -v s="${socket}" 'NF { print g "\t" s "\t" $0 }' "${file}"
done < <(jq -r --argjson index "${index}" '
	.games[] | .name as $g | .masters[]
	| select(.status == "online")
	| $index[[.host, .probe] | tojson] as $file
	| select($file != null)
	| [$g, (if .port then "\(.host):\(.port)" else .host end), $file] | @tsv
' "${servers}") >"${rows}"

jq -Rn --arg checked "$(jq -r '.checked // empty' "${servers}")" '
	[inputs | split("\t")]
	| group_by(.[0])
	| map(
		(map(.[1]) | unique) as $masters
		| (group_by(.[2]) | map({key: .[0][2], value: (map(.[1] as $s | $masters | index($s)) | unique)}) | from_entries) as $list
		| {key: .[0][0], value: {unique: ($list | length), masters: $masters, servers: $list}}
	)
	| from_entries
	| {checked: $checked, games: .}
' "${rows}" >"${out}.tmp"
mv "${out}.tmp" "${out}"
