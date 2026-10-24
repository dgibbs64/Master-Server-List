#!/usr/bin/env bash
set -euo pipefail

file="${1:-servers.json}"
readme="${2:-README.md}"

{
	cat <<'EOF'
# Master Server List

<!-- Generated from servers.json by scripts/generate-readme.sh. Edit servers.json, not this file. -->

Since GameSpy servers went offline in May 2014 there have been many master servers popping up to ensure that multiplayer games still run. Some are a complete replacement and others supplement official master servers. This repo lists these master servers so you can update server and client configs, allowing your server to be listed and clients to see the list.

> To add or change a master server, edit `servers.json`, run `./scripts/generate-readme.sh` and open a pull request.

## Status

Every master server is checked daily, and where the protocol allows it the check also counts how many servers the master lists. Live status and counts are at https://ismygameserver.online/masters, which reads `servers.json` from https://dgibbs64.github.io/Master-Server-List/servers.json. This README is updated when a status changes, so its server counts are from that day.

| Status | Meaning |
|---|---|
| ✅ Online | Answered a master server query |
| ❔ DNS only | Hostname resolves, but there is no query check for this protocol yet |
| ⚠️ No response | Hostname resolves, but the server did not answer |
| ❌ No DNS | Hostname no longer resolves |

Masters known to be gone, official or community, are listed under "Retired master servers" for each game so server admins can remove them from their configs. They are not checked. "Shut down" dates come from the linked source. "Not answering since" is the first check that found them dead, so they may have died earlier.

EOF
	jq -r '
		def status_label: {"online": "✅ Online", "dns-only": "❔ DNS only", "no-response": "⚠️ No response", "no-dns": "❌ No DNS"}[. // ""] // "Unchecked";
		def status_rank: {"online": 0, "dns-only": 1, "no-response": 2, "no-dns": 3}[. // ""] // 4;
		def anchor: ascii_downcase | gsub("[^a-z0-9 -]"; "") | gsub(" "; "-");
		"Status as of: \(.checked // "never")\n",
		"## Games\n",
		(.games[] | "- [\(.name)](#\(.name | anchor))"),
		"",
		(.games[]
			| "## \(.name)\n",
			(if .notes then "\(.notes)\n" else empty end),
			(if (.masters | length) > 0 then
				"| Master server | Status | Servers | Last seen |",
				"|---|---|---|---|",
				(.masters | sort_by([(.status | status_rank), -(.servers // -1)])[] | "| `\(.host)\(if .port then ":\(.port)" else "" end)` | \(.status | status_label) | \(.servers // "-") | \(.last_seen // "Never") |"),
				""
			else empty end),
			(if (.retired // [] | length) > 0 then
				"### Retired master servers\n",
				"| Master server | Run by | Gone | Notes |",
				"|---|---|---|---|",
				(.retired[] | "| `\(.host)\(if .port then ":\(.port)" else "" end)` | \(if .official then "Official" else "Community" end) | \(if .shutdown then "Shut down \(.shutdown)" else "Not answering since \(.down_since)" end) | \(.reason)\(if .source then " [Source](\(.source))" else "" end) |"),
				""
			else empty end))
	' "${file}" | sed '$ { /^$/d }'
} >"${readme}"
