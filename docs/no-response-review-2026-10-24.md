# No-response master review: 2026-10-24

Baseline: the completed [catalogue check](https://github.com/dgibbs64/Master-Server-List/actions/runs/40118935334), commit `41a2415`. It reported 48 no-response entries across 12 hostnames. No masters were retired or removed in this review.

The audit below predates the merged [enctype X decrypter (#39)](https://github.com/dgibbs64/Master-Server-List/pull/39). This PR preserves its encrypted probes, Qtracker port changes and the newer automated results. The table records historical observations; it does not replace the latest catalogue status. Failure diagnostics will be populated by subsequent checks.

## Findings

- A first audit, using the existing protocol implementations with 30 seconds between requests to the same host and a later retry pass, recovered 16 of the 48 entries. This demonstrates intermittent failures; it does not establish a provider-specific rate limit.
- All 11 Frag-Net game lists answered in that audit, as did both Qtracker lists, both Noccer lists and the UT4 public list.
- GoneSpy refused three spaced TCP connection checks. Its 25 failed game entries share one endpoint; the native UT2004 endpoint also refused connections.
- OpenSpy explicitly rejected the Deus Ex validation response. This is a query/validation failure, not an unavailable TCP service. Its catalogue entry remains included with a diagnostic reason.
- The two QuakeWorld masters, Jedi Academy master and two Tribes masters did not answer repeated UDP checks. A separate IPv4 probe received connection-refused from qwmaster.fodquake.net; the other four timed out. Positive controls using the responding Tribes and WON2 masters answered from the same network.
- Local DNS returned 0.0.0.0 for master.newbiesplayground.net, while Cloudflare and Google both returned 199.247.4.173. That local DNS result was excluded from catalogue downgrades and full-query upgrades. No local DNS filtering was bypassed.

## Checker changes

- Interleave hostnames; enforce a configurable 30-second cooldown shared by names resolving to the same IPv4 address.
- Retry failures in two later passes, with minimum delays of 30 and 60 seconds. DNS failures are retried too.
- Recheck refused TCP endpoints once per pass instead of repeating the same refused connection for every game.
- Record failure reasons in check_error and print GameSpy rejection/challenge errors in logs. Keep the status vocabulary compatible with existing consumers.
- Preserve successful zero-server lists, last-seen dates, and address indexes for entries recovered on later passes.

## Validation

An immutable copy of the final scripts was run against 63 selected entries covering all 48 failures and the proposed TCP-to-GameSpy upgrades. The run used the default pacing and all three passes. Seven integration tests use real local GameSpy sockets to cover scheduling, shared-IP cooldowns, late recovery, DNS recovery, validation rejection, zero-server lists and address-index recovery. ShellCheck and shfmt checks pass.

The final paced run recovered **14 of the original 48 entries**. Qtracker answered both lists in the first audit, then refused connections in the later run; those audit results recorded no-response with a connection-failed diagnostic. The newer catalogue results are preserved. Pacing therefore mitigates bursts without guaranteeing a response or proving the cause of every failure. Results are observations from the checking network on 2026-10-24, not guarantees of continuous availability.

## GameSpy labels and upgrades

The catalogue previously displayed the probe method TCP as if it were the service protocol. Remaining weak checks are now labelled GameSpy (TCP check only), or UT2004 (TCP check only) for the native service. The validated Soldier of Fortune II and UT2004 requests use the [upstream 333networks game definitions](https://github.com/333networks/Masterserver-Qt5/blob/main/data/SupportedGames.json). Only successful full queries were upgraded.

| Game | Master | Servers |
|---|---|---:|
| Soldier of Fortune II | `master.333networks.com` | 0 |
| Soldier of Fortune II | `master.errorist.eu` | 0 |
| Soldier of Fortune II | `master.fragaholic.com` | 0 |
| Soldier of Fortune II | `master-au.unrealarchive.org` | 0 |
| Soldier of Fortune II | `master.noccer.de` | 0 |
| Soldier of Fortune II | `master.eatsleeput.com` | 0 |
| Soldier of Fortune II | `master.frag-net.com` | 0 |
| Unreal Tournament 2004 | `master.333networks.com` | 4 |
| Unreal Tournament 2004 | `master.fragaholic.com` | 4 |
| Unreal Tournament 2004 | `master-au.unrealarchive.org` | 3 |
| Unreal Tournament 2004 | `master.noccer.de` | 3 |
| Unreal Tournament 2004 | `master.eatsleeput.com` | 3 |
| Unreal Tournament 2004 | `master.frag-net.com` | 3 |

## Original no-response entries after the final paced run

| Game | Master | Status | Servers | Diagnostic |
|---|---|---|---:|---|
| Clive Barker's Undying | `master.gonespy.com` | no-response | n/a | connection-failed |
| Deus Ex | `master.gonespy.com` | no-response | n/a | connection-failed |
| Deus Ex | `master.openspy.net` | no-response | n/a | validation-rejected |
| Deus Ex | `master.noccer.de` | online | 8 | n/a |
| Deus Ex | `master.frag-net.com` | online | 8 | n/a |
| Drakan: Order of the Flame | `master.gonespy.com` | no-response | n/a | connection-failed |
| Drakan: Order of the Flame | `master.frag-net.com` | online | 1 | n/a |
| Duke Nukem Forever (2001) | `master.gonespy.com` | no-response | n/a | connection-failed |
| Duke Nukem Forever (2001) | `master.noccer.de` | online | 4 | n/a |
| Duke Nukem Forever (2001) | `master.frag-net.com` | online | 5 | n/a |
| Global Operations | `master.gonespy.com` | no-response | n/a | connection-failed |
| Global Operations | `master.frag-net.com` | online | 3 | n/a |
| Heretic II | `master.gonespy.com` | no-response | n/a | connection-failed |
| Iron Storm | `master.gonespy.com` | no-response | n/a | connection-failed |
| Kingpin | `master.gonespy.com` | no-response | n/a | connection-failed |
| Kingpin | `master.frag-net.com` | online | 30 | n/a |
| Kingpin | `gsm.qtracker.com` | no-response | n/a | connection-failed |
| Medal of Honor: Allied Assault | `master.gonespy.com` | no-response | n/a | connection-failed |
| Medal of Honor: Allied Assault | `master.frag-net.com` | online | 207 | n/a |
| Medal of Honor: Allied Assault Breakthrough | `master.gonespy.com` | no-response | n/a | connection-failed |
| Medal of Honor: Allied Assault Breakthrough | `master.frag-net.com` | online | 35 | n/a |
| Medal of Honor: Allied Assault Spearhead | `master.gonespy.com` | no-response | n/a | connection-failed |
| Medal of Honor: Allied Assault Spearhead | `master.frag-net.com` | online | 70 | n/a |
| Mobile Forces | `master.gonespy.com` | no-response | n/a | connection-failed |
| Mobile Forces | `master.frag-net.com` | online | 1 | n/a |
| Nerf Arena Blast | `master.gonespy.com` | no-response | n/a | connection-failed |
| Nerf Arena Blast | `master.frag-net.com` | online | 0 | n/a |
| Postal 2 | `master.gonespy.com` | no-response | n/a | connection-failed |
| Postal 2 | `master.frag-net.com` | online | 38 | n/a |
| QuakeWorld | `master.quakeservers.net` | no-response | n/a | no-reply |
| QuakeWorld | `qwmaster.fodquake.net` | no-response | n/a | no-reply |
| Rune | `master.gonespy.com` | no-response | n/a | connection-failed |
| Serious Sam | `master.gonespy.com` | no-response | n/a | connection-failed |
| Serious Sam: Second Encounter | `master.gonespy.com` | no-response | n/a | connection-failed |
| Soldier of Fortune | `master.gonespy.com` | no-response | n/a | connection-failed |
| Soldier of Fortune II | `master.gonespy.com` | no-response | n/a | connection-failed |
| Star Wars Jedi Knight: Jedi Academy | `master.jk2mv.org` | no-response | n/a | no-reply |
| Turok 2 | `master.gonespy.com` | no-response | n/a | connection-failed |
| Unreal | `master.gonespy.com` | no-response | n/a | connection-failed |
| Unreal Tournament 2003 | `master.gonespy.com` | no-response | n/a | connection-failed |
| Unreal Tournament 2004 | `master.gonespy.com` | no-response | n/a | connection-failed |
| Unreal Tournament 2004 | `ut2004master.gonespy.com` | no-response | n/a | connection-failed |
| Unreal Tournament 99 | `master.gonespy.com` | no-response | n/a | connection-failed |
| Unreal Tournament 99 | `gsm.qtracker.com` | no-response | n/a | connection-failed |
| Wheel of Time | `master.gonespy.com` | no-response | n/a | connection-failed |
| Starsiege: Tribes | `t1m1.masters.tribesmasterserver.com` | no-response | n/a | no-reply |
| Starsiege: Tribes | `t1m1.tribes0.com` | no-response | n/a | no-reply |
| Unreal Tournament 4 (pre-alpha) | `master-ut4.timiimit.com` | online | 42 | n/a |

## Companion website wording

The game-page introduction and status legend were corrected to describe configured checks, rather than claiming that every online entry returned a game list. The local browser preview confirms the GameSpy (TCP check only) labels render correctly. All 39 existing website tests pass.
