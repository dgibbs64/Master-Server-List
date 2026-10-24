#!/usr/bin/env bash
set -euo pipefail

previous=$1
current=$2
label="master-down"
today=$(date -u +%Y-%m-%d)

transitions() {
	jq -r --slurpfile prev "$previous" '
		def bysocket:
			[.games[] | .name as $g | .masters[] | {socket: (if .port then "\(.host):\(.port)" else .host end), status, game: $g}]
			| group_by(.socket)
			| map({key: .[0].socket, value: {online: any(.[]; .status == "online"), status: (map(.status) | first), games: (map(.game) | unique | join(", "))}})
			| from_entries;
		($prev[0] | bysocket) as $p
		| bysocket | to_entries[]
		| select($p[.key].online == true and (.value.status == "no-response" or .value.status == "no-dns"))
		| [.key, .value.status, .value.games] | @tsv
	' "$current"
}

online_sockets() {
	jq -r '.games[].masters[] | select(.status == "online") | if .port then "\(.host):\(.port)" else .host end' "$current" | sort -u
}

gh label create "$label" --color B60205 --description "A master server stopped answering" --force >/dev/null

open_issues=$(gh issue list --label "$label" --state open --limit 200 --json number,title --jq '.[] | [.number, (.title | sub("^Master down: "; ""))] | @tsv')

while IFS=$'\t' read -r socket status games; do
	[ -n "$socket" ] || continue
	if grep -qxF "$socket" <(cut -f2 <<<"$open_issues"); then
		continue
	fi
	gh issue create --label "$label" --title "Master down: $socket" --body "\`$socket\` answered the previous check but not the one on $today (status: \`$status\`).

Games: $games

This issue closes itself when the master answers a daily check again." >/dev/null
	echo "Opened issue for $socket"
done < <(transitions)

online=$(online_sockets)
while IFS=$'\t' read -r number socket; do
	[ -n "$number" ] || continue
	if grep -qxF "$socket" <<<"$online"; then
		gh issue close "$number" --comment "\`$socket\` answered the check on $today." >/dev/null
		echo "Closed issue #$number for $socket"
	fi
done <<<"$open_issues"
