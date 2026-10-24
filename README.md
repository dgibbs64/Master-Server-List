# Master Server List

<!-- Generated from servers.json by scripts/generate-readme.sh. Edit servers.json, not this file. -->

Since GameSpy servers went offline in May 2014 there have been many master servers popping up to ensure that multiplayer games still run. Some are a complete replacement and others supplement official master servers. This repo lists these master servers so you can update server and client configs, allowing your server to be listed and clients to see the list.

> To add or change a master server, edit `servers.json`, run `./scripts/generate-readme.sh` and open a pull request.

## Status

Every master server is checked daily, and where the protocol allows it the check also counts how many servers the master lists. Live status and counts are at https://ismygameserver.online/masters, which reads `servers.json` from https://dgibbs64.github.io/Master-Server-List/servers.json. This README is updated when a status changes, so its server counts are from that day. Each check's status and count is also kept for 180 days in `history.json` on the `history` branch, published at https://dgibbs64.github.io/Master-Server-List/history.json. Where a master returns its full list, the addresses are merged per game, with duplicates removed, into https://dgibbs64.github.io/Master-Server-List/servers-list.json, which also gives each game's count of unique servers.

| Status | Meaning |
|---|---|
| ✅ Online | Answered a master server query |
| ❔ DNS only | Hostname resolves, but there is no query check for this protocol yet |
| ⚠️ No response | Hostname resolves, but the server did not answer |
| ❌ No DNS | Hostname no longer resolves |

"Run by" is Official for a master run by the game's developer or publisher, or by the game's own project for open-source games and mods, and Community for one run by anyone else.

Masters known to be gone, official or community, are listed under "Retired master servers" for each game so server admins can remove them from their configs. They are not checked. "Shut down" dates come from the linked source. "Not answering since" is the first check that found them dead, so they may have died earlier.

Status as of: 2026-10-24

## Games

- [Alien Arena](#alien-arena)
- [AssaultCube](#assaultcube)
- [Battlefield 1942](#battlefield-1942)
- [BeamMP](#beammp)
- [Call of Duty](#call-of-duty)
- [Call of Duty 2](#call-of-duty-2)
- [Call of Duty 4: Modern Warfare](#call-of-duty-4-modern-warfare)
- [Call of Duty: United Offensive](#call-of-duty-united-offensive)
- [Chocolate Doom](#chocolate-doom)
- [Clive Barker's Undying](#clive-barkers-undying)
- [DDNet / Teeworlds](#ddnet--teeworlds)
- [Deus Ex](#deus-ex)
- [Doom 3](#doom-3)
- [Drakan: Order of the Flame](#drakan-order-of-the-flame)
- [Duke Nukem Forever (2001)](#duke-nukem-forever-2001)
- [Global Operations](#global-operations)
- [Halo: Combat Evolved](#halo-combat-evolved)
- [Heretic II](#heretic-ii)
- [HeXen II](#hexen-ii)
- [HeXenWorld](#hexenworld)
- [Iron Storm](#iron-storm)
- [Kingpin](#kingpin)
- [Luanti (Minetest)](#luanti-minetest)
- [Medal of Honor: Allied Assault](#medal-of-honor-allied-assault)
- [Medal of Honor: Allied Assault Breakthrough](#medal-of-honor-allied-assault-breakthrough)
- [Medal of Honor: Allied Assault Spearhead](#medal-of-honor-allied-assault-spearhead)
- [Mobile Forces](#mobile-forces)
- [Nerf Arena Blast](#nerf-arena-blast)
- [Nexuiz](#nexuiz)
- [Odamex](#odamex)
- [OpenArena](#openarena)
- [Postal 2](#postal-2)
- [Q3Rally](#q3rally)
- [Quake (DarkPlaces)](#quake-darkplaces)
- [Quake 2](#quake-2)
- [Quake 3](#quake-3)
- [Quake 4](#quake-4)
- [QuakeWorld](#quakeworld)
- [Return to Castle Wolfenstein](#return-to-castle-wolfenstein)
- [Rune](#rune)
- [San Andreas Multiplayer (SA:MP / open.mp)](#san-andreas-multiplayer-samp--openmp)
- [Sauerbraten](#sauerbraten)
- [Serious Sam](#serious-sam)
- [Serious Sam: Second Encounter](#serious-sam-second-encounter)
- [Smokin' Guns](#smokin-guns)
- [Soldat](#soldat)
- [Soldier of Fortune](#soldier-of-fortune)
- [Soldier of Fortune II](#soldier-of-fortune-ii)
- [Star Trek: Elite Force II](#star-trek-elite-force-ii)
- [Star Trek: Voyager Elite Force](#star-trek-voyager-elite-force)
- [Star Wars Jedi Knight II: Jedi Outcast](#star-wars-jedi-knight-ii-jedi-outcast)
- [Star Wars Jedi Knight: Jedi Academy](#star-wars-jedi-knight-jedi-academy)
- [Tesseract](#tesseract)
- [Tremulous](#tremulous)
- [Tribes 2](#tribes-2)
- [Turok 2](#turok-2)
- [Unreal](#unreal)
- [Unreal Tournament 2003](#unreal-tournament-2003)
- [Unreal Tournament 2004](#unreal-tournament-2004)
- [Unreal Tournament 99](#unreal-tournament-99)
- [Urban Terror](#urban-terror)
- [Vintage Story](#vintage-story)
- [Warfork](#warfork)
- [Warsow](#warsow)
- [Wheel of Time](#wheel-of-time)
- [Wolfenstein: Enemy Territory](#wolfenstein-enemy-territory)
- [World of Padman](#world-of-padman)
- [Xonotic](#xonotic)
- [Zandronum](#zandronum)
- [Battlefield 2142](#battlefield-2142)
- [Battlefield Vietnam](#battlefield-vietnam)
- [Call of Juarez: Bound in Blood](#call-of-juarez-bound-in-blood)
- [Chaser](#chaser)
- [Contract J.A.C.K.](#contract-jack)
- [Crysis 2](#crysis-2)
- [Deer Hunter 2004](#deer-hunter-2004)
- [Deer Hunter 2005](#deer-hunter-2005)
- [Dirt Track Racing 2](#dirt-track-racing-2)
- [F1 1999-2000 Compilation](#f1-1999-2000-compilation)
- [F.E.A.R.](#fear)
- [F.E.A.R. Perseus Mandate](#fear-perseus-mandate)
- [FlatOut 2](#flatout-2)
- [Gore: Ultimate Soldier](#gore-ultimate-soldier)
- [IGI 2: Covert Strike](#igi-2-covert-strike)
- [James Bond 007: Nightfire](#james-bond-007-nightfire)
- [Legends of Might and Magic](#legends-of-might-and-magic)
- [Line of Sight: Vietnam](#line-of-sight-vietnam)
- [Need for Speed: Hot Pursuit 2](#need-for-speed-hot-pursuit-2)
- [No One Lives Forever](#no-one-lives-forever)
- [No One Lives Forever 2](#no-one-lives-forever-2)
- [Painkiller](#painkiller)
- [Saints Row 2](#saints-row-2)
- [Sniper Elite](#sniper-elite)
- [Star Trek: Bridge Commander](#star-trek-bridge-commander)
- [Star Wars: Republic Commando](#star-wars-republic-commando)
- [THUG Pro](#thug-pro)
- [Tony Hawk's American Wasteland](#tony-hawks-american-wasteland)
- [Tony Hawk's Pro Skater 4](#tony-hawks-pro-skater-4)
- [Tribes: Vengeance](#tribes-vengeance)
- [Unreal Tournament 3](#unreal-tournament-3)
- [Vietcong 2](#vietcong-2)
- [SWAT 4](#swat-4)
- [Crysis](#crysis)
- [Crysis Wars](#crysis-wars)
- [Vietcong](#vietcong)
- [Red Eclipse](#red-eclipse)
- [Daikatana](#daikatana)
- [SiN](#sin)
- [Starsiege: Tribes](#starsiege-tribes)
- [Unreal Tournament 4 (pre-alpha)](#unreal-tournament-4-pre-alpha)
- [Half-Life (WON)](#half-life-won)
- [Mount & Blade: Warband](#mount--blade-warband)
- [Space Station 14](#space-station-14)
- [Skyrim Together Reborn](#skyrim-together-reborn)
- [Renegade X](#renegade-x)
- [Brickadia](#brickadia)
- [Halo: Custom Edition](#halo-custom-edition)
- [Battlefield 2](#battlefield-2)

## Alien Arena

| Master server | Run by | Status | Servers | Last seen |
|---|---|---|---|---|
| `master.alienarena.org:27900` | Official | ✅ Online | 20 | 2026-10-24 |
| `master2.alienarena.org:27900` | Official | ✅ Online | 20 | 2026-10-24 |

## AssaultCube

The master returns its list over HTTP.

| Master server | Run by | Status | Servers | Last seen |
|---|---|---|---|---|
| `ms.cubers.net` | Official | ✅ Online | 45 | 2026-10-24 |

## Battlefield 1942

Needs the multiplayer patch from bf1942.org, which points the game at this master.

| Master server | Run by | Status | Servers | Last seen |
|---|---|---|---|---|
| `master.openspy.net:27900` | Community | ✅ Online | 0 | 2026-10-24 |
| `master.bf1942.org` | Community | ✅ Online | - | 2026-10-24 |

### Retired master servers

| Master server | Run by | Gone | Notes |
|---|---|---|---|
| `master.bf1942.eu` | Community | Not answering since 2026-10-24 | Community master from bf1942.eu. The hostname resolves but did not answer a check. |

## BeamMP

This game has no classic master server. Its public server list is a web API, checked the same way and counted from the API's response.

| Master server | Run by | Status | Servers | Last seen |
|---|---|---|---|---|
| `backend.beammp.com` | Official | ✅ Online | 3072 | 2026-10-24 |

## Call of Duty

| Master server | Run by | Status | Servers | Last seen |
|---|---|---|---|---|
| `codmaster.activision.com:20510` | Official | ✅ Online | 119 | 2026-10-24 |
| `master.openspy.net:27900` | Community | ✅ Online | 0 | 2026-10-24 |

## Call of Duty 2

| Master server | Run by | Status | Servers | Last seen |
|---|---|---|---|---|
| `cod2master.activision.com:20710` | Official | ✅ Online | 372 | 2026-10-24 |
| `master.openspy.net:27900` | Community | ✅ Online | 0 | 2026-10-24 |

## Call of Duty 4: Modern Warfare

| Master server | Run by | Status | Servers | Last seen |
|---|---|---|---|---|
| `cod4master.activision.com:20810` | Official | ✅ Online | 1345 | 2026-10-24 |
| `master.cod.pm:20810` | Community | ✅ Online | 984 | 2026-10-24 |

### Retired master servers

| Master server | Run by | Gone | Notes |
|---|---|---|---|
| `cod4master.cod4x.ovh:20810` | Community | Not answering since 2026-10-24 | CoD4x community master. The hostname resolves to 0.0.0.0. |

## Call of Duty: United Offensive

| Master server | Run by | Status | Servers | Last seen |
|---|---|---|---|---|
| `coduomaster.activision.com:20610` | Official | ✅ Online | 160 | 2026-10-24 |

## Chocolate Doom

| Master server | Run by | Status | Servers | Last seen |
|---|---|---|---|---|
| `master.chocolate-doom.org:2342` | Official | ✅ Online | 25 | 2026-10-24 |

## Clive Barker's Undying

| Master server | Run by | Status | Servers | Last seen |
|---|---|---|---|---|
| `master.openspy.net:27900` | Community | ✅ Online | 2 | 2026-10-24 |
| `master.333networks.com:27900` | Community | ✅ Online | - | 2026-10-24 |
| `master.errorist.eu:27900` | Community | ✅ Online | - | 2026-10-24 |
| `master.newbiesplayground.net:27900` | Community | ✅ Online | - | 2026-10-24 |
| `master.fragaholic.com:27900` | Community | ✅ Online | - | 2026-10-24 |
| `master-au.unrealarchive.org:27900` | Community | ✅ Online | - | 2026-10-24 |
| `master.noccer.de:27900` | Community | ✅ Online | - | 2026-10-24 |
| `master.eatsleeput.com:27900` | Community | ✅ Online | - | 2026-10-24 |
| `master.frag-net.com:27900` | Community | ✅ Online | - | 2026-10-24 |
| `master.gonespy.com:27900` | Community | ⚠️ No response | - | 2026-10-23 |

### Retired master servers

| Master server | Run by | Gone | Notes |
|---|---|---|---|
| `master0.gamespy.com:27900` | Official | Shut down 2014-05-31 | GameSpy master that Unreal Engine 1 games list by default. GameSpy ended all hosted services. [Source](https://www.pcgamer.com/au/gamespy-multiplayer-service-shutting-down-next-month) |

## DDNet / Teeworlds

This game has no classic master server. Its public server list is a web API, checked the same way and counted from the API's response.

| Master server | Run by | Status | Servers | Last seen |
|---|---|---|---|---|
| `master1.ddnet.org` | Official | ✅ Online | 1476 | 2026-10-24 |

## Deus Ex

| Master server | Run by | Status | Servers | Last seen |
|---|---|---|---|---|
| `master.deusexnetwork.com:27900` | Community | ✅ Online | 10 | 2026-10-24 |
| `master.333networks.com:27900` | Community | ✅ Online | 10 | 2026-10-24 |
| `master.fragaholic.com:27900` | Community | ✅ Online | 10 | 2026-10-24 |
| `master.errorist.eu:27900` | Community | ✅ Online | 7 | 2026-10-24 |
| `master.newbiesplayground.net:27900` | Community | ✅ Online | 7 | 2026-10-24 |
| `master-au.unrealarchive.org:27900` | Community | ✅ Online | 7 | 2026-10-24 |
| `master.eatsleeput.com:27900` | Community | ✅ Online | 7 | 2026-10-24 |
| `master.gonespy.com:27900` | Community | ⚠️ No response | - | 2026-10-23 |
| `master.openspy.net:27900` | Community | ⚠️ No response | - | 2026-10-24 |
| `master.noccer.de:27900` | Community | ⚠️ No response | - | Never |
| `master.frag-net.com:27900` | Community | ⚠️ No response | - | Never |

### Retired master servers

| Master server | Run by | Gone | Notes |
|---|---|---|---|
| `master.gamespy.com:27900` | Official | Shut down 2014-05-31 | GameSpy ended all hosted services. Games also used per-game hosts under master.gamespy.com. [Source](https://www.pcgamer.com/au/gamespy-multiplayer-service-shutting-down-next-month) |
| `master0.gamespy.com:27900` | Official | Shut down 2014-05-31 | GameSpy master that Unreal Engine 1 games list by default. GameSpy ended all hosted services. [Source](https://www.pcgamer.com/au/gamespy-multiplayer-service-shutting-down-next-month) |
| `master.errorist.tk:27900` | Community | Not answering since 2026-10-23 | Moved to master.errorist.eu. |

## Doom 3

| Master server | Run by | Status | Servers | Last seen |
|---|---|---|---|---|
| `idnet.ua-corp.com:27650` | Official | ✅ Online | 21 | 2026-10-24 |

## Drakan: Order of the Flame

| Master server | Run by | Status | Servers | Last seen |
|---|---|---|---|---|
| `master.333networks.com:27900` | Community | ✅ Online | 1 | 2026-10-24 |
| `master.errorist.eu:27900` | Community | ✅ Online | 1 | 2026-10-24 |
| `master.newbiesplayground.net:27900` | Community | ✅ Online | 1 | 2026-10-24 |
| `master.fragaholic.com:27900` | Community | ✅ Online | 1 | 2026-10-24 |
| `master-au.unrealarchive.org:27900` | Community | ✅ Online | 1 | 2026-10-24 |
| `master.noccer.de:27900` | Community | ✅ Online | 1 | 2026-10-24 |
| `master.eatsleeput.com:27900` | Community | ✅ Online | 1 | 2026-10-24 |
| `master.gonespy.com:27900` | Community | ⚠️ No response | - | Never |
| `master.frag-net.com:27900` | Community | ⚠️ No response | - | Never |

### Retired master servers

| Master server | Run by | Gone | Notes |
|---|---|---|---|
| `master.gamespy.com:27900` | Official | Shut down 2014-05-31 | GameSpy ended all hosted services. Games also used per-game hosts under master.gamespy.com. [Source](https://www.pcgamer.com/au/gamespy-multiplayer-service-shutting-down-next-month) |

## Duke Nukem Forever (2001)

The leaked 2001 build, which still has a small multiplayer community.

| Master server | Run by | Status | Servers | Last seen |
|---|---|---|---|---|
| `master.333networks.com:27900` | Community | ✅ Online | 9 | 2026-10-24 |
| `master.fragaholic.com:27900` | Community | ✅ Online | 9 | 2026-10-24 |
| `master.errorist.eu:27900` | Community | ✅ Online | 4 | 2026-10-24 |
| `master-au.unrealarchive.org:27900` | Community | ✅ Online | 4 | 2026-10-24 |
| `master.eatsleeput.com:27900` | Community | ✅ Online | 4 | 2026-10-24 |
| `master.newbiesplayground.net:27900` | Community | ✅ Online | 3 | 2026-10-24 |
| `master.gonespy.com:27900` | Community | ⚠️ No response | - | Never |
| `master.noccer.de:27900` | Community | ⚠️ No response | - | Never |
| `master.frag-net.com:27900` | Community | ⚠️ No response | - | Never |

## Global Operations

| Master server | Run by | Status | Servers | Last seen |
|---|---|---|---|---|
| `master.errorist.eu:27900` | Community | ✅ Online | 6 | 2026-10-24 |
| `master.openspy.net:27900` | Community | ✅ Online | 5 | 2026-10-24 |
| `master.333networks.com:27900` | Community | ✅ Online | 4 | 2026-10-24 |
| `master.fragaholic.com:27900` | Community | ✅ Online | 4 | 2026-10-24 |
| `master.newbiesplayground.net:27900` | Community | ✅ Online | 3 | 2026-10-24 |
| `master-au.unrealarchive.org:27900` | Community | ✅ Online | 3 | 2026-10-24 |
| `master.noccer.de:27900` | Community | ✅ Online | 3 | 2026-10-24 |
| `master.eatsleeput.com:27900` | Community | ✅ Online | 3 | 2026-10-24 |
| `master.gonespy.com:27900` | Community | ⚠️ No response | - | 2026-10-23 |
| `master.frag-net.com:27900` | Community | ⚠️ No response | - | Never |

### Retired master servers

| Master server | Run by | Gone | Notes |
|---|---|---|---|
| `master.gamespy.com:27900` | Official | Shut down 2014-05-31 | GameSpy ended all hosted services. Games also used per-game hosts under master.gamespy.com. [Source](https://www.pcgamer.com/au/gamespy-multiplayer-service-shutting-down-next-month) |

## Halo: Combat Evolved

Bungie's patch 1.0.10 (May 2014) moved Halo PC and Custom Edition off GameSpy to this master: the server list comes from s1.master.hosthpc.com, servers report to s1.ms01.hosthpc.com, and NAT negotiation uses natneg1 and natneg2.hosthpc.com. The Chimera client mod uses the same hosts by default. Retail Halo lists under the GameSpy name halor; Custom Edition has its own entry.

| Master server | Run by | Status | Servers | Last seen |
|---|---|---|---|---|
| `master.openspy.net:27900` | Community | ✅ Online | 0 | 2026-10-24 |
| `s1.master.hosthpc.com` | Official | ✅ Online | - | 2026-10-24 |

## Heretic II

| Master server | Run by | Status | Servers | Last seen |
|---|---|---|---|---|
| `master.333networks.com:27900` | Community | ✅ Online | 4 | 2026-10-24 |
| `master.fragaholic.com:27900` | Community | ✅ Online | 4 | 2026-10-24 |
| `master.errorist.eu:27900` | Community | ✅ Online | 3 | 2026-10-24 |
| `master.newbiesplayground.net:27900` | Community | ✅ Online | 3 | 2026-10-24 |
| `master-au.unrealarchive.org:27900` | Community | ✅ Online | 3 | 2026-10-24 |
| `master.noccer.de:27900` | Community | ✅ Online | 3 | 2026-10-24 |
| `master.eatsleeput.com:27900` | Community | ✅ Online | 3 | 2026-10-24 |
| `master.frag-net.com:27900` | Community | ✅ Online | 3 | 2026-10-24 |
| `master.maraakate.org:27900` | Community | ✅ Online | 3 | 2026-10-24 |
| `master.openspy.net:27900` | Community | ✅ Online | 2 | 2026-10-24 |
| `master.gonespy.com:27900` | Community | ⚠️ No response | - | 2026-10-23 |

### Retired master servers

| Master server | Run by | Gone | Notes |
|---|---|---|---|
| `master.gamespy.com:27900` | Official | Shut down 2014-05-31 | GameSpy ended all hosted services. Games also used per-game hosts under master.gamespy.com. [Source](https://www.pcgamer.com/au/gamespy-multiplayer-service-shutting-down-next-month) |
| `master.errorist.tk:27900` | Community | Not answering since 2026-10-23 | Moved to master.errorist.eu. |
| `thyrion.hexenworld.org:27900` | Community | Not answering since 2026-10-23 | Community master. The hostname no longer resolves. |

## HeXen II

Only master.maraakate.org is known to list HeXen II servers. It is a GameSpy-compatible master run by Maraakate, and publishes its list at http://maraakate.org/gamespy/, which is where the count comes from. The original HexenWorld master at hexenworld.org no longer resolves.

| Master server | Run by | Status | Servers | Last seen |
|---|---|---|---|---|
| `master.maraakate.org:27900` | Community | ✅ Online | 1 | 2026-10-24 |

## HeXenWorld

Only master.maraakate.org is known to list HeXenWorld servers. It is a GameSpy-compatible master run by Maraakate, and publishes its list at http://maraakate.org/gamespy/, which is where the count comes from. The original HexenWorld master at hexenworld.org no longer resolves.

| Master server | Run by | Status | Servers | Last seen |
|---|---|---|---|---|
| `master.maraakate.org:27900` | Community | ✅ Online | 3 | 2026-10-24 |

### Retired master servers

| Master server | Run by | Gone | Notes |
|---|---|---|---|
| `master.hexenworld.org` | Community | Not answering since 2026-10-24 | Community master. The hostname no longer resolves. |
| `thyrion.hexenworld.org:27900` | Community | Not answering since 2026-10-23 | Community master. The hostname no longer resolves. |

## Iron Storm

qtracker's website is gone, but gsm.qtracker.com still serves GameSpy lists. Its encrypted list port answers reliably where the plain one often does not.

| Master server | Run by | Status | Servers | Last seen |
|---|---|---|---|---|
| `gsm.qtracker.com:27900` | Community | ✅ Online | 0 | 2026-10-24 |
| `master.333networks.com:27900` | Community | ✅ Online | 0 | 2026-10-24 |
| `master.errorist.eu:27900` | Community | ✅ Online | 0 | 2026-10-24 |
| `master.gonespy.com:27900` | Community | ⚠️ No response | - | 2026-10-23 |

### Retired master servers

| Master server | Run by | Gone | Notes |
|---|---|---|---|
| `master.gamespy.com:27900` | Official | Shut down 2014-05-31 | GameSpy ended all hosted services. Games also used per-game hosts under master.gamespy.com. [Source](https://www.pcgamer.com/au/gamespy-multiplayer-service-shutting-down-next-month) |
| `master.errorist.tk:27900` | Community | Not answering since 2026-10-23 | Moved to master.errorist.eu. |

## Kingpin

master.kingpin.info answers Quake II style queries and lists each server's query port, which is the game port plus 10, so its addresses are not merged with the other masters'.

| Master server | Run by | Status | Servers | Last seen |
|---|---|---|---|---|
| `master.kingpin.info:27900` | Community | ✅ Online | 41 | 2026-10-24 |
| `master.333networks.com:27900` | Community | ✅ Online | 40 | 2026-10-24 |
| `master.fragaholic.com:27900` | Community | ✅ Online | 40 | 2026-10-24 |
| `master.maraakate.org:27900` | Community | ✅ Online | 40 | 2026-10-24 |
| `master.errorist.eu:27900` | Community | ✅ Online | 30 | 2026-10-24 |
| `master.newbiesplayground.net:27900` | Community | ✅ Online | 30 | 2026-10-24 |
| `master-au.unrealarchive.org:27900` | Community | ✅ Online | 30 | 2026-10-24 |
| `master.noccer.de:27900` | Community | ✅ Online | 30 | 2026-10-24 |
| `master.eatsleeput.com:27900` | Community | ✅ Online | 30 | 2026-10-24 |
| `master.gonespy.com:27900` | Community | ⚠️ No response | - | 2026-10-23 |
| `master.frag-net.com:27900` | Community | ⚠️ No response | - | Never |
| `gsm.qtracker.com:27900` | Community | ⚠️ No response | - | Never |

### Retired master servers

| Master server | Run by | Gone | Notes |
|---|---|---|---|
| `master.gamespy.com:27900` | Official | Shut down 2014-05-31 | GameSpy ended all hosted services. Games also used per-game hosts under master.gamespy.com. [Source](https://www.pcgamer.com/au/gamespy-multiplayer-service-shutting-down-next-month) |

## Luanti (Minetest)

This game has no classic master server. Its public server list is a web API, checked the same way and counted from the API's response.

| Master server | Run by | Status | Servers | Last seen |
|---|---|---|---|---|
| `servers.luanti.org` | Official | ✅ Online | 447 | 2026-10-24 |

## Medal of Honor: Allied Assault

Spearhead and Breakthrough have their own entries below.

| Master server | Run by | Status | Servers | Last seen |
|---|---|---|---|---|
| `master.333networks.com:27900` | Community | ✅ Online | 239 | 2026-10-24 |
| `master.fragaholic.com:27900` | Community | ✅ Online | 237 | 2026-10-24 |
| `master.errorist.eu:27900` | Community | ✅ Online | 213 | 2026-10-24 |
| `master-au.unrealarchive.org:27900` | Community | ✅ Online | 202 | 2026-10-24 |
| `master.noccer.de:27900` | Community | ✅ Online | 201 | 2026-10-24 |
| `master.eatsleeput.com:27900` | Community | ✅ Online | 200 | 2026-10-24 |
| `master.newbiesplayground.net:27900` | Community | ✅ Online | 172 | 2026-10-24 |
| `master.openspy.net:27900` | Community | ✅ Online | 137 | 2026-10-24 |
| `master.gonespy.com:27900` | Community | ⚠️ No response | - | 2026-10-23 |
| `master.frag-net.com:27900` | Community | ⚠️ No response | - | Never |

### Retired master servers

| Master server | Run by | Gone | Notes |
|---|---|---|---|
| `master.gamespy.com:27900` | Official | Shut down 2014-05-31 | GameSpy ended all hosted services. Games also used per-game hosts under master.gamespy.com. [Source](https://www.pcgamer.com/au/gamespy-multiplayer-service-shutting-down-next-month) |
| `mohmaster.2015.com` | Official | Not answering since 2026-10-24 | Official master from developer 2015, Inc. The hostname no longer resolves. |

## Medal of Honor: Allied Assault Breakthrough

Needs the patched binaries from 333networks.com/instructions/mohaa.

| Master server | Run by | Status | Servers | Last seen |
|---|---|---|---|---|
| `master.333networks.com:27900` | Community | ✅ Online | 50 | 2026-10-24 |
| `master.fragaholic.com:27900` | Community | ✅ Online | 50 | 2026-10-24 |
| `master.errorist.eu:27900` | Community | ✅ Online | 39 | 2026-10-24 |
| `master.noccer.de:27900` | Community | ✅ Online | 37 | 2026-10-24 |
| `master-au.unrealarchive.org:27900` | Community | ✅ Online | 36 | 2026-10-24 |
| `master.eatsleeput.com:27900` | Community | ✅ Online | 35 | 2026-10-24 |
| `master.newbiesplayground.net:27900` | Community | ✅ Online | 31 | 2026-10-24 |
| `master.gonespy.com:27900` | Community | ⚠️ No response | - | Never |
| `master.frag-net.com:27900` | Community | ⚠️ No response | - | Never |

### Retired master servers

| Master server | Run by | Gone | Notes |
|---|---|---|---|
| `master.gamespy.com:27900` | Official | Shut down 2014-05-31 | GameSpy ended all hosted services. Games also used per-game hosts under master.gamespy.com. [Source](https://www.pcgamer.com/au/gamespy-multiplayer-service-shutting-down-next-month) |

## Medal of Honor: Allied Assault Spearhead

Needs the patched binaries from 333networks.com/instructions/mohaa.

| Master server | Run by | Status | Servers | Last seen |
|---|---|---|---|---|
| `master.333networks.com:27900` | Community | ✅ Online | 79 | 2026-10-24 |
| `master.fragaholic.com:27900` | Community | ✅ Online | 79 | 2026-10-24 |
| `master-au.unrealarchive.org:27900` | Community | ✅ Online | 79 | 2026-10-24 |
| `master.errorist.eu:27900` | Community | ✅ Online | 71 | 2026-10-24 |
| `master.noccer.de:27900` | Community | ✅ Online | 67 | 2026-10-24 |
| `master.eatsleeput.com:27900` | Community | ✅ Online | 65 | 2026-10-24 |
| `master.newbiesplayground.net:27900` | Community | ✅ Online | 62 | 2026-10-24 |
| `master.gonespy.com:27900` | Community | ⚠️ No response | - | Never |
| `master.frag-net.com:27900` | Community | ⚠️ No response | - | Never |

### Retired master servers

| Master server | Run by | Gone | Notes |
|---|---|---|---|
| `master.gamespy.com:27900` | Official | Shut down 2014-05-31 | GameSpy ended all hosted services. Games also used per-game hosts under master.gamespy.com. [Source](https://www.pcgamer.com/au/gamespy-multiplayer-service-shutting-down-next-month) |

## Mobile Forces

| Master server | Run by | Status | Servers | Last seen |
|---|---|---|---|---|
| `master.333networks.com:27900` | Community | ✅ Online | 2 | 2026-10-24 |
| `master.fragaholic.com:27900` | Community | ✅ Online | 2 | 2026-10-24 |
| `master.errorist.eu:27900` | Community | ✅ Online | 1 | 2026-10-24 |
| `master.newbiesplayground.net:27900` | Community | ✅ Online | 1 | 2026-10-24 |
| `master-au.unrealarchive.org:27900` | Community | ✅ Online | 1 | 2026-10-24 |
| `master.noccer.de:27900` | Community | ✅ Online | 1 | 2026-10-24 |
| `master.eatsleeput.com:27900` | Community | ✅ Online | 1 | 2026-10-24 |
| `master.gonespy.com:27900` | Community | ⚠️ No response | - | 2026-10-23 |
| `master.frag-net.com:27900` | Community | ⚠️ No response | - | Never |

### Retired master servers

| Master server | Run by | Gone | Notes |
|---|---|---|---|
| `master.gamespy.com:27900` | Official | Shut down 2014-05-31 | GameSpy ended all hosted services. Games also used per-game hosts under master.gamespy.com. [Source](https://www.pcgamer.com/au/gamespy-multiplayer-service-shutting-down-next-month) |
| `master0.gamespy.com:27900` | Official | Shut down 2014-05-31 | GameSpy master that Unreal Engine 1 games list by default. GameSpy ended all hosted services. [Source](https://www.pcgamer.com/au/gamespy-multiplayer-service-shutting-down-next-month) |

## Nerf Arena Blast

| Master server | Run by | Status | Servers | Last seen |
|---|---|---|---|---|
| `master.333networks.com:27900` | Community | ✅ Online | 0 | 2026-10-24 |
| `master.errorist.eu:27900` | Community | ✅ Online | 0 | 2026-10-24 |
| `master.newbiesplayground.net:27900` | Community | ✅ Online | 0 | 2026-10-24 |
| `master.fragaholic.com:27900` | Community | ✅ Online | 0 | 2026-10-24 |
| `master-au.unrealarchive.org:27900` | Community | ✅ Online | 0 | 2026-10-24 |
| `master.noccer.de:27900` | Community | ✅ Online | 0 | 2026-10-24 |
| `master.eatsleeput.com:27900` | Community | ✅ Online | 0 | 2026-10-24 |
| `master.gonespy.com:27900` | Community | ⚠️ No response | - | 2026-10-23 |
| `master.frag-net.com:27900` | Community | ⚠️ No response | - | Never |

### Retired master servers

| Master server | Run by | Gone | Notes |
|---|---|---|---|
| `master.gamespy.com:27900` | Official | Shut down 2014-05-31 | GameSpy ended all hosted services. Games also used per-game hosts under master.gamespy.com. [Source](https://www.pcgamer.com/au/gamespy-multiplayer-service-shutting-down-next-month) |
| `master0.gamespy.com:27900` | Official | Shut down 2014-05-31 | GameSpy master that Unreal Engine 1 games list by default. GameSpy ended all hosted services. [Source](https://www.pcgamer.com/au/gamespy-multiplayer-service-shutting-down-next-month) |

## Nexuiz

dpmaster.deathmask.net, dpmaster.tchr.no and dpm.dpmaster.org are the DarkPlaces engine's built-in default masters. Each is run by a community admin, not by the game's project.

| Master server | Run by | Status | Servers | Last seen |
|---|---|---|---|---|
| `dpmaster.tchr.no:27950` | Community | ✅ Online | 29 | 2026-10-24 |
| `dpmaster.deathmask.net:27950` | Community | ✅ Online | 18 | 2026-10-24 |
| `dpm.dpmaster.org:27777` | Community | ✅ Online | 0 | 2026-10-24 |

## Odamex

| Master server | Run by | Status | Servers | Last seen |
|---|---|---|---|---|
| `master1.odamex.net:15000` | Official | ✅ Online | 143 | 2026-10-24 |
| `master2.odamex.net:15000` | Official | ✅ Online | 143 | 2026-10-24 |

## OpenArena

dpmaster.deathmask.net is OpenArena's built-in default master (sv_master1). It is run by a community admin, not by the OpenArena project.

| Master server | Run by | Status | Servers | Last seen |
|---|---|---|---|---|
| `dpmaster.deathmask.net:27950` | Community | ✅ Online | 112 | 2026-10-24 |
| `master.ioquake3.org:27950` | Community | ✅ Online | 66 | 2026-10-24 |

## Postal 2

| Master server | Run by | Status | Servers | Last seen |
|---|---|---|---|---|
| `master.fragaholic.com:27900` | Community | ✅ Online | 29 | 2026-10-24 |
| `master.333networks.com:27900` | Community | ✅ Online | 28 | 2026-10-24 |
| `master.errorist.eu:27900` | Community | ✅ Online | 26 | 2026-10-24 |
| `master-au.unrealarchive.org:27900` | Community | ✅ Online | 26 | 2026-10-24 |
| `master.noccer.de:27900` | Community | ✅ Online | 26 | 2026-10-24 |
| `master.eatsleeput.com:27900` | Community | ✅ Online | 26 | 2026-10-24 |
| `master.newbiesplayground.net:27900` | Community | ✅ Online | 9 | 2026-10-24 |
| `master.gonespy.com:27900` | Community | ⚠️ No response | - | 2026-10-23 |
| `master.frag-net.com:27900` | Community | ⚠️ No response | - | Never |

### Retired master servers

| Master server | Run by | Gone | Notes |
|---|---|---|---|
| `master.gamespy.com:27900` | Official | Shut down 2014-05-31 | GameSpy ended all hosted services. Games also used per-game hosts under master.gamespy.com. [Source](https://www.pcgamer.com/au/gamespy-multiplayer-service-shutting-down-next-month) |

## Q3Rally

| Master server | Run by | Status | Servers | Last seen |
|---|---|---|---|---|
| `dpmaster.deathmask.net:27950` | Community | ✅ Online | 2 | 2026-10-24 |

## Quake (DarkPlaces)

dpmaster.deathmask.net, dpmaster.tchr.no and dpm.dpmaster.org are the DarkPlaces engine's built-in default masters. Each is run by a community admin, not by the game's project.

| Master server | Run by | Status | Servers | Last seen |
|---|---|---|---|---|
| `dpmaster.tchr.no:27950` | Community | ✅ Online | 52 | 2026-10-24 |
| `dpmaster.deathmask.net:27950` | Community | ✅ Online | 42 | 2026-10-24 |
| `dpm.dpmaster.org:27777` | Community | ✅ Online | 1 | 2026-10-24 |

## Quake 2

master.maraakate.org is a GameSpy-compatible master for GameSpy 3D style browsers, run by Maraakate. It publishes its lists at http://maraakate.org/gamespy/, which is where the count comes from.

| Master server | Run by | Status | Servers | Last seen |
|---|---|---|---|---|
| `master.maraakate.org:27900` | Community | ✅ Online | 433 | 2026-10-24 |
| `master.quakeservers.net:27900` | Community | ✅ Online | 109 | 2026-10-24 |
| `master.itbacon.com:27900` | Community | ✅ Online | 26 | 2026-10-24 |

### Retired master servers

| Master server | Run by | Gone | Notes |
|---|---|---|---|
| `master.q2servers.com:27900` | Community | Not answering since 2026-10-23 | Community master. The hostname resolves but has not answered a check. |
| `netdome.biz:27900` | Community | Not answering since 2026-10-23 | Community master. The hostname resolves but has not answered a check. |

## Quake 3

| Master server | Run by | Status | Servers | Last seen |
|---|---|---|---|---|
| `master.quake3arena.com:27950` | Official | ✅ Online | 1002 | 2026-10-24 |
| `master.ioquake3.org:27950` | Community | ✅ Online | 950 | 2026-10-24 |
| `master.maverickservers.com:27950` | Community | ✅ Online | 442 | 2026-10-24 |
| `master0.excessiveplus.net:27950` | Community | ✅ Online | 210 | 2026-10-24 |
| `dpmaster.deathmask.net:27950` | Community | ✅ Online | 183 | 2026-10-24 |
| `master.huxxer.de:27950` | Community | ✅ Online | 39 | 2026-10-24 |

### Retired master servers

| Master server | Run by | Gone | Notes |
|---|---|---|---|
| `master3.idsoftware.com:27950` | Official | Not answering since 2026-10-23 | Official id Software master. The hostname no longer resolves. |

## Quake 4

master.quakehub.net runs the open-source quakehub-q4master (https://github.com/booskibro/quakehub-q4master) and relays client authorisation to id's master, so connecting still works. Players set it with seta net_master0, the only slot the client reads for its server list; server operators use net_master1 to net_master4.

| Master server | Run by | Status | Servers | Last seen |
|---|---|---|---|---|
| `q4master.idsoftware.com:27650` | Official | ✅ Online | 24 | 2026-10-24 |
| `master.quakehub.net:27650` | Community | ✅ Online | 18 | 2026-10-24 |

## QuakeWorld

master.maraakate.org is a GameSpy-compatible master for GameSpy 3D style browsers, run by Maraakate. It publishes its lists at http://maraakate.org/gamespy/, which is where the count comes from.

| Master server | Run by | Status | Servers | Last seen |
|---|---|---|---|---|
| `master.maraakate.org:27900` | Community | ✅ Online | 646 | 2026-10-24 |
| `master.quakeservers.net:27000` | Community | ⚠️ No response | - | 2026-10-24 |
| `qwmaster.fodquake.net:27000` | Community | ⚠️ No response | - | 2026-10-23 |

### Retired master servers

| Master server | Run by | Gone | Notes |
|---|---|---|---|
| `master.quakeworld.nu:27000` | Community | Not answering since 2026-10-23 | Community master. The hostname resolves but has not answered a check. |

## Return to Castle Wolfenstein

| Master server | Run by | Status | Servers | Last seen |
|---|---|---|---|---|
| `wolfmaster.s4ndmod.com:27950` | Community | ✅ Online | 144 | 2026-10-24 |
| `wolfmaster.idsoftware.com:27950` | Official | ✅ Online | 94 | 2026-10-24 |
| `dpmaster.deathmask.net:27950` | Community | ✅ Online | 63 | 2026-10-24 |

### Retired master servers

| Master server | Run by | Gone | Notes |
|---|---|---|---|
| `wolfmaster.rtcwmp.com:27950` | Community | Not answering since 2026-10-23 | Community master. The hostname resolves but has not answered a check. |

## Rune

| Master server | Run by | Status | Servers | Last seen |
|---|---|---|---|---|
| `master.333networks.com:27900` | Community | ✅ Online | 57 | 2026-10-24 |
| `master.fragaholic.com:27900` | Community | ✅ Online | 57 | 2026-10-24 |
| `master.errorist.eu:27900` | Community | ✅ Online | 39 | 2026-10-24 |
| `master-au.unrealarchive.org:27900` | Community | ✅ Online | 32 | 2026-10-24 |
| `master.eatsleeput.com:27900` | Community | ✅ Online | 32 | 2026-10-24 |
| `master.newbiesplayground.net:27900` | Community | ✅ Online | 31 | 2026-10-24 |
| `master.noccer.de:27900` | Community | ✅ Online | 31 | 2026-10-24 |
| `master.frag-net.com:27900` | Community | ✅ Online | 31 | 2026-10-24 |
| `master.openspy.net:27900` | Community | ✅ Online | 5 | 2026-10-24 |
| `master.gonespy.com:27900` | Community | ⚠️ No response | - | 2026-10-23 |

### Retired master servers

| Master server | Run by | Gone | Notes |
|---|---|---|---|
| `master.gamespy.com:27900` | Official | Shut down 2014-05-31 | GameSpy ended all hosted services. Games also used per-game hosts under master.gamespy.com. [Source](https://www.pcgamer.com/au/gamespy-multiplayer-service-shutting-down-next-month) |
| `master0.gamespy.com:27900` | Official | Shut down 2014-05-31 | GameSpy master that Unreal Engine 1 games list by default. GameSpy ended all hosted services. [Source](https://www.pcgamer.com/au/gamespy-multiplayer-service-shutting-down-next-month) |
| `runemaster.humanhead.com` | Official | Not answering since 2026-10-24 | Official Human Head master. The hostname no longer resolves. |
| `master.errorist.tk:27900` | Community | Not answering since 2026-10-23 | Moved to master.errorist.eu. |
| `master.telefragged.com` | Community | Not answering since 2026-10-24 | Community master. The hostname resolves but did not answer a check. |

## San Andreas Multiplayer (SA:MP / open.mp)

This game has no classic master server. Its public server list is a web API, checked the same way and counted from the API's response.

| Master server | Run by | Status | Servers | Last seen |
|---|---|---|---|---|
| `api.open.mp` | Official | ✅ Online | 1285 | 2026-10-24 |

## Sauerbraten

| Master server | Run by | Status | Servers | Last seen |
|---|---|---|---|---|
| `master.sauerbraten.org:28787` | Official | ✅ Online | 69 | 2026-10-24 |

## Serious Sam

| Master server | Run by | Status | Servers | Last seen |
|---|---|---|---|---|
| `master.333networks.com:27900` | Community | ✅ Online | 72 | 2026-10-24 |
| `master.fragaholic.com:27900` | Community | ✅ Online | 71 | 2026-10-24 |
| `master.noccer.de:27900` | Community | ✅ Online | 45 | 2026-10-24 |
| `master-au.unrealarchive.org:27900` | Community | ✅ Online | 44 | 2026-10-24 |
| `master.frag-net.com:27900` | Community | ✅ Online | 44 | 2026-10-24 |
| `master.errorist.eu:27900` | Community | ✅ Online | 43 | 2026-10-24 |
| `master.eatsleeput.com:27900` | Community | ✅ Online | 43 | 2026-10-24 |
| `master.newbiesplayground.net:27900` | Community | ✅ Online | 41 | 2026-10-24 |
| `master.gonespy.com:27900` | Community | ⚠️ No response | - | 2026-10-23 |

### Retired master servers

| Master server | Run by | Gone | Notes |
|---|---|---|---|
| `master.gamespy.com:27900` | Official | Shut down 2014-05-31 | GameSpy ended all hosted services. Games also used per-game hosts under master.gamespy.com. [Source](https://www.pcgamer.com/au/gamespy-multiplayer-service-shutting-down-next-month) |
| `master.errorist.tk:27900` | Community | Not answering since 2026-10-23 | Moved to master.errorist.eu. |

## Serious Sam: Second Encounter

| Master server | Run by | Status | Servers | Last seen |
|---|---|---|---|---|
| `master.333networks.com:27900` | Community | ✅ Online | 120 | 2026-10-24 |
| `master.fragaholic.com:27900` | Community | ✅ Online | 120 | 2026-10-24 |
| `master.frag-net.com:27900` | Community | ✅ Online | 80 | 2026-10-24 |
| `master.errorist.eu:27900` | Community | ✅ Online | 79 | 2026-10-24 |
| `master.noccer.de:27900` | Community | ✅ Online | 78 | 2026-10-24 |
| `master-au.unrealarchive.org:27900` | Community | ✅ Online | 77 | 2026-10-24 |
| `master.eatsleeput.com:27900` | Community | ✅ Online | 77 | 2026-10-24 |
| `master.newbiesplayground.net:27900` | Community | ✅ Online | 71 | 2026-10-24 |
| `master.openspy.net:27900` | Community | ✅ Online | 1 | 2026-10-24 |
| `master.gonespy.com:27900` | Community | ⚠️ No response | - | 2026-10-23 |

### Retired master servers

| Master server | Run by | Gone | Notes |
|---|---|---|---|
| `master.gamespy.com:27900` | Official | Shut down 2014-05-31 | GameSpy ended all hosted services. Games also used per-game hosts under master.gamespy.com. [Source](https://www.pcgamer.com/au/gamespy-multiplayer-service-shutting-down-next-month) |
| `master.errorist.tk:27900` | Community | Not answering since 2026-10-23 | Moved to master.errorist.eu. |

## Smokin' Guns

| Master server | Run by | Status | Servers | Last seen |
|---|---|---|---|---|
| `master.smokin-guns.org:27950` | Official | ✅ Online | 8 | 2026-10-24 |

## Soldat

This game has no classic master server. Its public server list is a web API, checked the same way and counted from the API's response.

| Master server | Run by | Status | Servers | Last seen |
|---|---|---|---|---|
| `api.soldat.pl` | Official | ✅ Online | 61 | 2026-10-24 |

## Soldier of Fortune

| Master server | Run by | Status | Servers | Last seen |
|---|---|---|---|---|
| `master.333networks.com:27900` | Community | ✅ Online | 44 | 2026-10-24 |
| `master.fragaholic.com:27900` | Community | ✅ Online | 44 | 2026-10-24 |
| `master.errorist.eu:27900` | Community | ✅ Online | 32 | 2026-10-24 |
| `master-au.unrealarchive.org:27900` | Community | ✅ Online | 30 | 2026-10-24 |
| `master.newbiesplayground.net:27900` | Community | ✅ Online | 29 | 2026-10-24 |
| `master.noccer.de:27900` | Community | ✅ Online | 29 | 2026-10-24 |
| `master.eatsleeput.com:27900` | Community | ✅ Online | 29 | 2026-10-24 |
| `master.frag-net.com:27900` | Community | ✅ Online | 29 | 2026-10-24 |
| `master.gonespy.com:27900` | Community | ⚠️ No response | - | 2026-10-23 |

### Retired master servers

| Master server | Run by | Gone | Notes |
|---|---|---|---|
| `master.gamespy.com:27900` | Official | Shut down 2014-05-31 | GameSpy ended all hosted services. Games also used per-game hosts under master.gamespy.com. [Source](https://www.pcgamer.com/au/gamespy-multiplayer-service-shutting-down-next-month) |
| `master.errorist.tk:27900` | Community | Not answering since 2026-10-23 | Moved to master.errorist.eu. |

## Soldier of Fortune II

| Master server | Run by | Status | Servers | Last seen |
|---|---|---|---|---|
| `master.1fxmod.org:20110` | Community | ✅ Online | 50 | 2026-10-24 |
| `master.333networks.com:27900` | Community | ✅ Online | - | 2026-10-24 |
| `master.errorist.eu:27900` | Community | ✅ Online | - | 2026-10-24 |
| `master.newbiesplayground.net:27900` | Community | ✅ Online | - | 2026-10-24 |
| `master.fragaholic.com:27900` | Community | ✅ Online | - | 2026-10-24 |
| `master-au.unrealarchive.org:27900` | Community | ✅ Online | - | 2026-10-24 |
| `master.noccer.de:27900` | Community | ✅ Online | - | 2026-10-24 |
| `master.eatsleeput.com:27900` | Community | ✅ Online | - | 2026-10-24 |
| `master.frag-net.com:27900` | Community | ✅ Online | - | 2026-10-24 |
| `master.gonespy.com:27900` | Community | ⚠️ No response | - | 2026-10-23 |

### Retired master servers

| Master server | Run by | Gone | Notes |
|---|---|---|---|
| `master.sof2.ravensoft.com:20110` | Official | Not answering since 2026-10-24 | Official Raven Software master. The hostname resolves but did not answer a check. |
| `master.errorist.tk:27900` | Community | Not answering since 2026-10-23 | Moved to master.errorist.eu. |

## Star Trek: Elite Force II

The game needs the community master server patch (or a hosts file entry for ef2master.activision.com) to use these masters. They answer queries, but the protocol number EF2 servers register with is unconfirmed, so no server count is shown.

| Master server | Run by | Status | Servers | Last seen |
|---|---|---|---|---|
| `master.hazardmodding.com:27900` | Community | ✅ Online | - | 2026-10-24 |
| `master.stef2.daggolin.de:27900` | Community | ✅ Online | - | 2026-10-24 |

### Retired master servers

| Master server | Run by | Gone | Notes |
|---|---|---|---|
| `ef2master.activision.com` | Official | Not answering since 2026-10-23 | Official Activision master. The hostname resolves, but no server is known to use it and it cannot be queried. |
| `ef2master.sfu-server.de` | Community | Not answering since 2026-10-23 | Community master. The hostname resolves, but no server is known to use it and it cannot be queried. |

## Star Trek: Voyager Elite Force

| Master server | Run by | Status | Servers | Last seen |
|---|---|---|---|---|
| `master.stef1.daggolin.de:27953` | Community | ✅ Online | 29 | 2026-10-24 |
| `master.stvef.org:27953` | Community | ✅ Online | 26 | 2026-10-24 |
| `efmaster.tjps.eu:27953` | Community | ✅ Online | 18 | 2026-10-24 |

### Retired master servers

| Master server | Run by | Gone | Notes |
|---|---|---|---|
| `master.stef1.ravensoft.com:27953` | Official | Not answering since 2026-10-23 | Official Raven Software master. The hostname resolves but has not answered a check. |

## Star Wars Jedi Knight II: Jedi Outcast

| Master server | Run by | Status | Servers | Last seen |
|---|---|---|---|---|
| `master.jkhub.org:28060` | Community | ✅ Online | 42 | 2026-10-24 |
| `master.jk2mv.org:28060` | Community | ✅ Online | 37 | 2026-10-24 |
| `master.ouned.de:28060` | Community | ✅ Online | 37 | 2026-10-24 |

### Retired master servers

| Master server | Run by | Gone | Notes |
|---|---|---|---|
| `masterjk2.ravensoft.com:28060` | Official | Not answering since 2026-10-23 | Official Raven Software master. The hostname resolves but has not answered a check. |

## Star Wars Jedi Knight: Jedi Academy

| Master server | Run by | Status | Servers | Last seen |
|---|---|---|---|---|
| `master.jkhub.org:29060` | Community | ✅ Online | 263 | 2026-10-24 |
| `master.jk2mv.org:29060` | Community | ⚠️ No response | - | 2026-10-24 |

### Retired master servers

| Master server | Run by | Gone | Notes |
|---|---|---|---|
| `masterjk3.ravensoft.com:29060` | Official | Not answering since 2026-10-23 | Official Raven Software master. The hostname resolves but has not answered a check. |

## Tesseract

| Master server | Run by | Status | Servers | Last seen |
|---|---|---|---|---|
| `master.tesseract.gg:41999` | Official | ✅ Online | 4 | 2026-10-24 |

## Tremulous

| Master server | Run by | Status | Servers | Last seen |
|---|---|---|---|---|
| `master.tremulous.net:30710` | Official | ✅ Online | 11 | 2026-10-24 |

## Tribes 2

TribesNext runs the master and authentication for Tribes 2. Servers heartbeat it automatically once TribesNext is installed.

| Master server | Run by | Status | Servers | Last seen |
|---|---|---|---|---|
| `master.tribesnext.com` | Community | ✅ Online | 35 | 2026-10-24 |

## Turok 2

| Master server | Run by | Status | Servers | Last seen |
|---|---|---|---|---|
| `master.333networks.com:27900` | Community | ✅ Online | 4 | 2026-10-24 |
| `master.errorist.eu:27900` | Community | ✅ Online | 4 | 2026-10-24 |
| `master.fragaholic.com:27900` | Community | ✅ Online | 4 | 2026-10-24 |
| `master-au.unrealarchive.org:27900` | Community | ✅ Online | 4 | 2026-10-24 |
| `master.noccer.de:27900` | Community | ✅ Online | 4 | 2026-10-24 |
| `master.eatsleeput.com:27900` | Community | ✅ Online | 4 | 2026-10-24 |
| `master.frag-net.com:27900` | Community | ✅ Online | 4 | 2026-10-24 |
| `master.newbiesplayground.net:27900` | Community | ✅ Online | 0 | 2026-10-24 |
| `master.gonespy.com:27900` | Community | ⚠️ No response | - | 2026-10-23 |

### Retired master servers

| Master server | Run by | Gone | Notes |
|---|---|---|---|
| `master.gamespy.com:27900` | Official | Shut down 2014-05-31 | GameSpy ended all hosted services. Games also used per-game hosts under master.gamespy.com. [Source](https://www.pcgamer.com/au/gamespy-multiplayer-service-shutting-down-next-month) |

## Unreal

| Master server | Run by | Status | Servers | Last seen |
|---|---|---|---|---|
| `master.fragaholic.com:27900` | Community | ✅ Online | 162 | 2026-10-24 |
| `master.333networks.com:27900` | Community | ✅ Online | 162 | 2026-10-24 |
| `master.errorist.eu:27900` | Community | ✅ Online | 146 | 2026-10-24 |
| `master-au.unrealarchive.org:27900` | Community | ✅ Online | 94 | 2026-10-24 |
| `master.oldunreal.com:27900` | Community | ✅ Online | 87 | 2026-10-24 |
| `master.newbiesplayground.net:27900` | Community | ✅ Online | 87 | 2026-10-24 |
| `master.eatsleeput.com:27900` | Community | ✅ Online | 87 | 2026-10-24 |
| `master.frag-net.com:27900` | Community | ✅ Online | 87 | 2026-10-24 |
| `master.noccer.de:27900` | Community | ✅ Online | 87 | 2026-10-24 |
| `master.hypercoop.tk:27900` | Community | ✅ Online | 83 | 2026-10-24 |
| `master.openspy.net:27900` | Community | ✅ Online | 64 | 2026-10-24 |
| `master.exsurge.net:27900` | Community | ✅ Online | 0 | 2026-10-24 |
| `master.gonespy.com:27900` | Community | ⚠️ No response | - | 2026-10-23 |

### Retired master servers

| Master server | Run by | Gone | Notes |
|---|---|---|---|
| `master.gamespy.com:27900` | Official | Shut down 2014-05-31 | GameSpy ended all hosted services. Games also used per-game hosts under master.gamespy.com. [Source](https://www.pcgamer.com/au/gamespy-multiplayer-service-shutting-down-next-month) |
| `master0.gamespy.com:27900` | Official | Shut down 2014-05-31 | GameSpy master that Unreal Engine 1 games list by default. GameSpy ended all hosted services. [Source](https://www.pcgamer.com/au/gamespy-multiplayer-service-shutting-down-next-month) |
| `master-de.unrealarchive.org:27900` | Community | Not answering since 2026-10-24 | Unreal Archive master. The hostname no longer resolves. master-au.unrealarchive.org is still online. |
| `master-uk.unrealarchive.org:27900` | Community | Not answering since 2026-10-24 | Unreal Archive master. The hostname no longer resolves. master-au.unrealarchive.org is still online. |
| `master.errorist.tk:27900` | Community | Not answering since 2026-10-23 | Moved to master.errorist.eu. |
| `master.hlkclan.net:27900` | Community | Not answering since 2026-10-23 | Community master. The hostname no longer resolves. |
| `master.qtracker.com:27900` | Community | Not answering since 2026-10-24 | qtracker's original master. The hostname resolves but no longer answers; gsm.qtracker.com still does. |
| `master2.oldunreal.com:27900` | Community | Not answering since 2026-10-23 | Secondary OldUnreal master. The hostname resolves but has not answered a check. |

## Unreal Tournament 2003

| Master server | Run by | Status | Servers | Last seen |
|---|---|---|---|---|
| `utmaster.openspy.net:28902` | Community | ✅ Online | 6 | 2026-10-24 |
| `master.333networks.com:27900` | Community | ✅ Online | 0 | 2026-10-24 |
| `master.errorist.eu:27900` | Community | ✅ Online | 0 | 2026-10-24 |
| `master.newbiesplayground.net:27900` | Community | ✅ Online | 0 | 2026-10-24 |
| `master.fragaholic.com:27900` | Community | ✅ Online | 0 | 2026-10-24 |
| `master-au.unrealarchive.org:27900` | Community | ✅ Online | 0 | 2026-10-24 |
| `master.noccer.de:27900` | Community | ✅ Online | 0 | 2026-10-24 |
| `master.eatsleeput.com:27900` | Community | ✅ Online | 0 | 2026-10-24 |
| `master.frag-net.com:27900` | Community | ✅ Online | 0 | 2026-10-24 |
| `master.gonespy.com:27900` | Community | ⚠️ No response | - | Never |

## Unreal Tournament 2004

| Master server | Run by | Status | Servers | Last seen |
|---|---|---|---|---|
| `utmaster.openspy.net:28902` | Community | ✅ Online | 502 | 2026-10-24 |
| `master.333networks.com:27900` | Community | ✅ Online | - | 2026-10-24 |
| `master.newbiesplayground.net:27900` | Community | ✅ Online | - | 2026-10-24 |
| `ut2004master.333networks.com:28902` | Community | ✅ Online | - | 2026-10-24 |
| `ut2004master.errorist.eu:28902` | Community | ✅ Online | - | 2026-10-24 |
| `master.fragaholic.com:27900` | Community | ✅ Online | - | 2026-10-24 |
| `master-au.unrealarchive.org:27900` | Community | ✅ Online | - | 2026-10-24 |
| `master.noccer.de:27900` | Community | ✅ Online | - | 2026-10-24 |
| `master.eatsleeput.com:27900` | Community | ✅ Online | - | 2026-10-24 |
| `master.frag-net.com:27900` | Community | ✅ Online | - | 2026-10-24 |
| `master.gonespy.com:27900` | Community | ⚠️ No response | - | 2026-10-23 |
| `ut2004master.gonespy.com:28902` | Community | ⚠️ No response | - | 2026-10-23 |

### Retired master servers

| Master server | Run by | Gone | Notes |
|---|---|---|---|
| `ut2004master1.epicgames.com:28902` | Official | Shut down 2023-01-24 | Epic switched off online services for its older Unreal games. [Source](https://www.gamingonlinux.com/2022/12/epic-games-are-killing-off-a-bunch-of-classics-like-unreal-tournament) |
| `ut2004master2.epicgames.com:28902` | Official | Shut down 2023-01-24 | Epic switched off online services for its older Unreal games. [Source](https://www.gamingonlinux.com/2022/12/epic-games-are-killing-off-a-bunch-of-classics-like-unreal-tournament) |
| `master.errorist.tk:27900` | Community | Not answering since 2026-10-23 | Moved to master.errorist.eu. |

## Unreal Tournament 99

OldUnreal's masterserver guide (https://www.oldunreal.com/wiki/index.php?title=Masterserver_Guide) gives the ListFactories and ServerActors lines for these masters. lists.gameserverlister.com is a plain HTTP list for the UBrowserHTTPFact browser; it gives game and query ports, so its addresses are not merged with the GameSpy masters'.

| Master server | Run by | Status | Servers | Last seen |
|---|---|---|---|---|
| `master.fragaholic.com:27900` | Community | ✅ Online | 1767 | 2026-10-24 |
| `master.333networks.com:27900` | Community | ✅ Online | 1762 | 2026-10-24 |
| `master.errorist.eu:27900` | Community | ✅ Online | 1255 | 2026-10-24 |
| `master-au.unrealarchive.org:27900` | Community | ✅ Online | 928 | 2026-10-24 |
| `master.noccer.de:27900` | Community | ✅ Online | 908 | 2026-10-24 |
| `master.newbiesplayground.net:27900` | Community | ✅ Online | 907 | 2026-10-24 |
| `master.oldunreal.com:27900` | Community | ✅ Online | 907 | 2026-10-24 |
| `master.frag-net.com:27900` | Community | ✅ Online | 903 | 2026-10-24 |
| `master.eatsleeput.com:27900` | Community | ✅ Online | 901 | 2026-10-24 |
| `lists.gameserverlister.com:80` | Community | ✅ Online | 754 | 2026-10-24 |
| `master.openspy.net:27900` | Community | ✅ Online | 529 | 2026-10-24 |
| `master.exsurge.net:27900` | Community | ✅ Online | 0 | 2026-10-24 |
| `master.gonespy.com:27900` | Community | ⚠️ No response | - | 2026-10-23 |
| `gsm.qtracker.com:27900` | Community | ⚠️ No response | - | Never |

### Retired master servers

| Master server | Run by | Gone | Notes |
|---|---|---|---|
| `master.gamespy.com:27900` | Official | Shut down 2014-05-31 | GameSpy ended all hosted services. Games also used per-game hosts under master.gamespy.com. [Source](https://www.pcgamer.com/au/gamespy-multiplayer-service-shutting-down-next-month) |
| `master.mplayer.com:27900` | Official | Shut down 2001 | Mplayer.com closed after its sale to GameSpy. The domain now points elsewhere. [Source](https://en.wikipedia.org/wiki/Mplayer.com) |
| `master0.gamespy.com:27900` | Official | Shut down 2014-05-31 | GameSpy master that Unreal Engine 1 games list by default. GameSpy ended all hosted services. [Source](https://www.pcgamer.com/au/gamespy-multiplayer-service-shutting-down-next-month) |
| `unreal.epicgames.com:27900` | Official | Shut down 2023-01-24 | Epic switched off online services for its older Unreal games. [Source](https://www.gamingonlinux.com/2022/12/epic-games-are-killing-off-a-bunch-of-classics-like-unreal-tournament) |
| `master-de.unrealarchive.org:27900` | Community | Not answering since 2026-10-24 | Unreal Archive master. The hostname no longer resolves. master-au.unrealarchive.org is still online. |
| `master-uk.unrealarchive.org:27900` | Community | Not answering since 2026-10-24 | Unreal Archive master. The hostname no longer resolves. master-au.unrealarchive.org is still online. |
| `master.errorist.tk:27900` | Community | Not answering since 2026-10-23 | Moved to master.errorist.eu. |
| `master.qtracker.com:27900` | Community | Not answering since 2026-10-24 | qtracker's original master. The hostname resolves but no longer answers; gsm.qtracker.com still does. |
| `master.telefragged.com:27900` | Community | Not answering since 2026-10-24 | Community master. The hostname resolves but did not answer a check. |
| `master2.oldunreal.com:27900` | Community | Not answering since 2026-10-23 | Secondary OldUnreal master. The hostname resolves but has not answered a check. |

## Urban Terror

| Master server | Run by | Status | Servers | Last seen |
|---|---|---|---|---|
| `master.urbanterror.info:27900` | Official | ✅ Online | 255 | 2026-10-24 |
| `master2.urbanterror.info:27900` | Official | ✅ Online | 255 | 2026-10-24 |

## Vintage Story

This game has no classic master server. Its public server list is a web API, checked the same way and counted from the API's response.

| Master server | Run by | Status | Servers | Last seen |
|---|---|---|---|---|
| `masterserver.vintagestory.at` | Official | ✅ Online | 2512 | 2026-10-24 |

## Warfork

| Master server | Run by | Status | Servers | Last seen |
|---|---|---|---|---|
| `dpmaster.deathmask.net:27950` | Community | ✅ Online | 87 | 2026-10-24 |
| `master1.forbidden.gg:27950` | - | ✅ Online | 85 | 2026-10-24 |

### Retired master servers

| Master server | Run by | Gone | Notes |
|---|---|---|---|
| `master1.icy.gg:27950` | Community | Not answering since 2026-10-24 | Community master. The hostname no longer resolves. |

## Warsow

| Master server | Run by | Status | Servers | Last seen |
|---|---|---|---|---|
| `dpmaster.tchr.no:27950` | Community | ✅ Online | 28 | 2026-10-24 |
| `dpmaster.deathmask.net:27950` | Community | ✅ Online | 20 | 2026-10-24 |

## Wheel of Time

| Master server | Run by | Status | Servers | Last seen |
|---|---|---|---|---|
| `master.333networks.com:27900` | Community | ✅ Online | 17 | 2026-10-24 |
| `master.fragaholic.com:27900` | Community | ✅ Online | 17 | 2026-10-24 |
| `master.errorist.eu:27900` | Community | ✅ Online | 7 | 2026-10-24 |
| `master.newbiesplayground.net:27900` | Community | ✅ Online | 7 | 2026-10-24 |
| `master-au.unrealarchive.org:27900` | Community | ✅ Online | 7 | 2026-10-24 |
| `master.noccer.de:27900` | Community | ✅ Online | 7 | 2026-10-24 |
| `master.eatsleeput.com:27900` | Community | ✅ Online | 7 | 2026-10-24 |
| `master.frag-net.com:27900` | Community | ✅ Online | 7 | 2026-10-24 |
| `master.gonespy.com:27900` | Community | ⚠️ No response | - | 2026-10-23 |

### Retired master servers

| Master server | Run by | Gone | Notes |
|---|---|---|---|
| `master.gamespy.com:27900` | Official | Shut down 2014-05-31 | GameSpy ended all hosted services. Games also used per-game hosts under master.gamespy.com. [Source](https://www.pcgamer.com/au/gamespy-multiplayer-service-shutting-down-next-month) |
| `master0.gamespy.com:27900` | Official | Shut down 2014-05-31 | GameSpy master that Unreal Engine 1 games list by default. GameSpy ended all hosted services. [Source](https://www.pcgamer.com/au/gamespy-multiplayer-service-shutting-down-next-month) |
| `master.errorist.tk:27900` | Community | Not answering since 2026-10-23 | Moved to master.errorist.eu. |

## Wolfenstein: Enemy Territory

| Master server | Run by | Status | Servers | Last seen |
|---|---|---|---|---|
| `etmaster.idsoftware.com:27950` | Official | ✅ Online | 445 | 2026-10-24 |
| `master.etlegacy.com:27950` | Community | ✅ Online | 436 | 2026-10-24 |
| `wolfmaster.idsoftware.com:27950` | Official | ✅ Online | 62 | 2026-10-24 |

### Retired master servers

| Master server | Run by | Gone | Notes |
|---|---|---|---|
| `master.idsoftware.com:27950` | Official | Not answering since 2026-10-23 | Official id Software master. The hostname no longer resolves. |
| `master3.idsoftware.com:27950` | Official | Not answering since 2026-10-23 | Official id Software master. The hostname no longer resolves. |
| `master0.etmaster.net:27950` | Community | Not answering since 2026-10-23 | Community master. The hostname resolves but has not answered a check. |

## World of Padman

| Master server | Run by | Status | Servers | Last seen |
|---|---|---|---|---|
| `master.worldofpadman.net:27955` | Official | ✅ Online | 1 | 2026-10-24 |
| `master.worldofpadman.com:27955` | Official | ✅ Online | 1 | 2026-10-24 |

## Xonotic

dpmaster.deathmask.net, dpmaster.tchr.no and dpm.dpmaster.org are the DarkPlaces engine's built-in default masters. Each is run by a community admin, not by the game's project.

| Master server | Run by | Status | Servers | Last seen |
|---|---|---|---|---|
| `dpmaster.deathmask.net:27950` | Community | ✅ Online | 296 | 2026-10-24 |
| `dpm.dpmaster.org:27777` | Community | ✅ Online | 235 | 2026-10-24 |
| `dpmaster.tchr.no:27950` | Community | ✅ Online | 35 | 2026-10-24 |

## Zandronum

| Master server | Run by | Status | Servers | Last seen |
|---|---|---|---|---|
| `master.zandronum.com:15300` | Official | ✅ Online | 772 | 2026-10-24 |

## Battlefield 2142

OpenSpy is the only master listed for this game so far. Clients and servers need OpenSpy's patch or a hosts file change; the game's guide is linked from https://openspy.net/supported-games.

| Master server | Run by | Status | Servers | Last seen |
|---|---|---|---|---|
| `master.openspy.net:27900` | Community | ✅ Online | 7 | 2026-10-24 |

## Battlefield Vietnam

OpenSpy is the only master listed for this game so far. Clients and servers need OpenSpy's patch or a hosts file change; the game's guide is linked from https://openspy.net/supported-games.

| Master server | Run by | Status | Servers | Last seen |
|---|---|---|---|---|
| `master.openspy.net:27900` | Community | ✅ Online | 12 | 2026-10-24 |

## Call of Juarez: Bound in Blood

OpenSpy is the only master listed for this game so far. Clients and servers need OpenSpy's patch or a hosts file change; the game's guide is linked from https://openspy.net/supported-games.

| Master server | Run by | Status | Servers | Last seen |
|---|---|---|---|---|
| `master.openspy.net:27900` | Community | ✅ Online | 7 | 2026-10-24 |

## Chaser

OpenSpy is the only master listed for this game so far. Clients and servers need OpenSpy's patch or a hosts file change; the game's guide is linked from https://openspy.net/supported-games.

| Master server | Run by | Status | Servers | Last seen |
|---|---|---|---|---|
| `master.openspy.net:27900` | Community | ✅ Online | 2 | 2026-10-24 |

## Contract J.A.C.K.

OpenSpy is the only master listed for this game so far. Clients and servers need OpenSpy's patch or a hosts file change; the game's guide is linked from https://openspy.net/supported-games.

| Master server | Run by | Status | Servers | Last seen |
|---|---|---|---|---|
| `master.openspy.net:27900` | Community | ✅ Online | 2 | 2026-10-24 |

## Crysis 2

OpenSpy is the only master listed for this game so far. Clients and servers need OpenSpy's patch or a hosts file change; the game's guide is linked from https://openspy.net/supported-games.

| Master server | Run by | Status | Servers | Last seen |
|---|---|---|---|---|
| `master.openspy.net:27900` | Community | ✅ Online | 6 | 2026-10-24 |

## Deer Hunter 2004

OpenSpy is the only master listed for this game so far. Clients and servers need OpenSpy's patch or a hosts file change; the game's guide is linked from https://openspy.net/supported-games.

| Master server | Run by | Status | Servers | Last seen |
|---|---|---|---|---|
| `master.openspy.net:27900` | Community | ✅ Online | 2 | 2026-10-24 |

## Deer Hunter 2005

OpenSpy is the only master listed for this game so far. Clients and servers need OpenSpy's patch or a hosts file change; the game's guide is linked from https://openspy.net/supported-games.

| Master server | Run by | Status | Servers | Last seen |
|---|---|---|---|---|
| `master.openspy.net:27900` | Community | ✅ Online | 3 | 2026-10-24 |

## Dirt Track Racing 2

OpenSpy is the only master listed for this game so far. Clients and servers need OpenSpy's patch or a hosts file change; the game's guide is linked from https://openspy.net/supported-games.

| Master server | Run by | Status | Servers | Last seen |
|---|---|---|---|---|
| `master.openspy.net:27900` | Community | ✅ Online | 6 | 2026-10-24 |

## F1 1999-2000 Compilation

OpenSpy is the only master listed for this game so far. Clients and servers need OpenSpy's patch or a hosts file change; the game's guide is linked from https://openspy.net/supported-games.

| Master server | Run by | Status | Servers | Last seen |
|---|---|---|---|---|
| `master.openspy.net:27900` | Community | ✅ Online | 2 | 2026-10-24 |

## F.E.A.R.

OpenSpy is the only master listed for this game so far. Multiplayer works with the openspy-client patch (https://github.com/anzz1/openspy-client) plus fearservmod (https://github.com/Vityacv/fearservmod), which also fixes client and server bugs. The free F.E.A.R. Combat registers under the same name, so its servers are counted here.

| Master server | Run by | Status | Servers | Last seen |
|---|---|---|---|---|
| `master.openspy.net:27900` | Community | ✅ Online | 2 | 2026-10-24 |

## F.E.A.R. Perseus Mandate

OpenSpy is the only master listed for this game so far. Multiplayer works with the openspy-client patch (https://github.com/anzz1/openspy-client) plus fearservmod (https://github.com/Vityacv/fearservmod), which also adds a co-op mode.

| Master server | Run by | Status | Servers | Last seen |
|---|---|---|---|---|
| `master.openspy.net:27900` | Community | ✅ Online | 1 | 2026-10-24 |

## FlatOut 2

OpenSpy is the only master listed for this game so far. Clients and servers need OpenSpy's patch or a hosts file change; the game's guide is linked from https://openspy.net/supported-games. Covers the retail and Zoom Platform editions, which register under different GameSpy names.

| Master server | Run by | Status | Servers | Last seen |
|---|---|---|---|---|
| `master.openspy.net:27900` | Community | ✅ Online | 24 | 2026-10-24 |

## Gore: Ultimate Soldier

OpenSpy is the only master listed for this game so far. Clients and servers need OpenSpy's patch or a hosts file change; the game's guide is linked from https://openspy.net/supported-games. Covers the original and Special Edition.

| Master server | Run by | Status | Servers | Last seen |
|---|---|---|---|---|
| `master.openspy.net:27900` | Community | ✅ Online | 5 | 2026-10-24 |

## IGI 2: Covert Strike

OpenSpy is the only master listed for this game so far. Clients and servers need OpenSpy's patch or a hosts file change; the game's guide is linked from https://openspy.net/supported-games. The HcSpy master network (https://igi2multiplayer.pages.dev), used through its HcLauncheR, also serves IGI 2. It does not publish a master hostname or an open server list, so it cannot be checked here.

| Master server | Run by | Status | Servers | Last seen |
|---|---|---|---|---|
| `master.openspy.net:27900` | Community | ✅ Online | 9 | 2026-10-24 |

## James Bond 007: Nightfire

OpenSpy is the only master listed for this game so far. Clients and servers need OpenSpy's patch or a hosts file change; the game's guide is linked from https://openspy.net/supported-games. master.nightfirepc.com, the Nightfire community domain, points at OpenSpy.

| Master server | Run by | Status | Servers | Last seen |
|---|---|---|---|---|
| `master.openspy.net:27900` | Community | ✅ Online | 12 | 2026-10-24 |

## Legends of Might and Magic

OpenSpy is the only master listed for this game so far. Clients and servers need OpenSpy's patch or a hosts file change; the game's guide is linked from https://openspy.net/supported-games.

| Master server | Run by | Status | Servers | Last seen |
|---|---|---|---|---|
| `master.openspy.net:27900` | Community | ✅ Online | 3 | 2026-10-24 |

## Line of Sight: Vietnam

OpenSpy is the only master listed for this game so far. Clients and servers need OpenSpy's patch or a hosts file change; the game's guide is linked from https://openspy.net/supported-games.

| Master server | Run by | Status | Servers | Last seen |
|---|---|---|---|---|
| `master.openspy.net:27900` | Community | ✅ Online | 0 | 2026-10-24 |

## Need for Speed: Hot Pursuit 2

OpenSpy is the only master listed for this game so far. Clients and servers need OpenSpy's patch or a hosts file change; the game's guide is linked from https://openspy.net/supported-games.

| Master server | Run by | Status | Servers | Last seen |
|---|---|---|---|---|
| `master.openspy.net:27900` | Community | ✅ Online | 2 | 2026-10-24 |

## No One Lives Forever

OpenSpy is the only master listed for this game so far. Clients and servers need OpenSpy's patch or a hosts file change; the game's guide is linked from https://openspy.net/supported-games.

| Master server | Run by | Status | Servers | Last seen |
|---|---|---|---|---|
| `master.openspy.net:27900` | Community | ✅ Online | 3 | 2026-10-24 |

## No One Lives Forever 2

OpenSpy is the only master listed for this game so far. Clients and servers need OpenSpy's patch or a hosts file change; the game's guide is linked from https://openspy.net/supported-games.

| Master server | Run by | Status | Servers | Last seen |
|---|---|---|---|---|
| `master.openspy.net:27900` | Community | ✅ Online | 5 | 2026-10-24 |

## Painkiller

OpenSpy is the only master listed for this game so far. Clients and servers need OpenSpy's patch or a hosts file change; the game's guide is linked from https://openspy.net/supported-games.

| Master server | Run by | Status | Servers | Last seen |
|---|---|---|---|---|
| `master.openspy.net:27900` | Community | ✅ Online | 13 | 2026-10-24 |

## Saints Row 2

OpenSpy is the only master listed for this game so far. Clients and servers need OpenSpy's patch or a hosts file change; the game's guide is linked from https://openspy.net/supported-games.

| Master server | Run by | Status | Servers | Last seen |
|---|---|---|---|---|
| `master.openspy.net:27900` | Community | ✅ Online | 3 | 2026-10-24 |

## Sniper Elite

OpenSpy is the only master listed for this game so far. Clients and servers need OpenSpy's patch or a hosts file change; the game's guide is linked from https://openspy.net/supported-games.

| Master server | Run by | Status | Servers | Last seen |
|---|---|---|---|---|
| `master.openspy.net:27900` | Community | ✅ Online | 0 | 2026-10-24 |

## Star Trek: Bridge Commander

OpenSpy is the only master listed for this game so far. Clients and servers need OpenSpy's patch or a hosts file change; the game's guide is linked from https://openspy.net/supported-games.

| Master server | Run by | Status | Servers | Last seen |
|---|---|---|---|---|
| `master.openspy.net:27900` | Community | ✅ Online | 2 | 2026-10-24 |

## Star Wars: Republic Commando

OpenSpy is the only master listed for this game so far. Clients and servers need OpenSpy's patch or a hosts file change; the game's guide is linked from https://openspy.net/supported-games.

| Master server | Run by | Status | Servers | Last seen |
|---|---|---|---|---|
| `master.openspy.net:27900` | Community | ✅ Online | 11 | 2026-10-24 |

## THUG Pro

OpenSpy is the only master listed for this game so far. Clients and servers need OpenSpy's patch or a hosts file change; the game's guide is linked from https://openspy.net/supported-games. A community mod built on Tony Hawk's Underground 2.

| Master server | Run by | Status | Servers | Last seen |
|---|---|---|---|---|
| `master.openspy.net:27900` | Community | ✅ Online | 12 | 2026-10-24 |

## Tony Hawk's American Wasteland

OpenSpy is the only master listed for this game so far. Clients and servers need OpenSpy's patch or a hosts file change; the game's guide is linked from https://openspy.net/supported-games. Covers the retail game and the reTHAWed community mod.

| Master server | Run by | Status | Servers | Last seen |
|---|---|---|---|---|
| `master.openspy.net:27900` | Community | ✅ Online | 3 | 2026-10-24 |

## Tony Hawk's Pro Skater 4

OpenSpy is the only master listed for this game so far. Clients and servers need OpenSpy's patch or a hosts file change; the game's guide is linked from https://openspy.net/supported-games.

| Master server | Run by | Status | Servers | Last seen |
|---|---|---|---|---|
| `master.openspy.net:27900` | Community | ✅ Online | 1 | 2026-10-24 |

## Tribes: Vengeance

OpenSpy is the only master listed for this game so far. Clients and servers need OpenSpy's patch or a hosts file change; the game's guide is linked from https://openspy.net/supported-games.

| Master server | Run by | Status | Servers | Last seen |
|---|---|---|---|---|
| `master.openspy.net:27900` | Community | ✅ Online | 7 | 2026-10-24 |

## Unreal Tournament 3

OpenSpy is the only master listed for this game so far. Clients and servers need OpenSpy's patch or a hosts file change; the game's guide is linked from https://openspy.net/supported-games.

| Master server | Run by | Status | Servers | Last seen |
|---|---|---|---|---|
| `master.openspy.net:27900` | Community | ✅ Online | 40 | 2026-10-24 |

## Vietcong 2

OpenSpy is the only master listed for this game so far. Clients and servers need OpenSpy's patch or a hosts file change; the game's guide is linked from https://openspy.net/supported-games.

| Master server | Run by | Status | Servers | Last seen |
|---|---|---|---|---|
| `master.openspy.net:27900` | Community | ✅ Online | 2 | 2026-10-24 |

## SWAT 4

Needs the swat4stats Engine.dll patch, which points the game at master.swat4stats.com.

| Master server | Run by | Status | Servers | Last seen |
|---|---|---|---|---|
| `master.swat4stats.com:27900` | Community | ✅ Online | 50 | 2026-10-24 |
| `master.openspy.net:27900` | Community | ✅ Online | 0 | 2026-10-24 |

## Crysis

CryMP replaces the GameSpy master. Its client points the game at m.crymp.org.

| Master server | Run by | Status | Servers | Last seen |
|---|---|---|---|---|
| `m.crymp.org:27900` | Community | ✅ Online | 12 | 2026-10-24 |
| `master.openspy.net:27900` | Community | ✅ Online | 0 | 2026-10-24 |

## Crysis Wars

crysiswarsmp.com runs the replacement GameSpy service for Crysis Wars, with master.g.jedi95.us as its master. Get the game working with the installer from crysiswarsmp.com. The count comes from the service's public server list at api.crysiswarsmp.com.

| Master server | Run by | Status | Servers | Last seen |
|---|---|---|---|---|
| `master.g.jedi95.us:28910` | Community | ✅ Online | 20 | 2026-10-24 |
| `master.openspy.net:27900` | Community | ✅ Online | 0 | 2026-10-24 |

## Vietcong

Two community masters replace GameSpy for Vietcong. Players point master.gamespy.com at one in the Windows hosts file: vietcong1.de (https://www.vietcong1.de/en/alternative-server-list/) uses 46.28.109.117, and vietcong.tk runs 51.68.46.73. Both answer with GameSpy's encrypted list format, so only their port is checked and there is no count yet.

| Master server | Run by | Status | Servers | Last seen |
|---|---|---|---|---|
| `master.openspy.net:27900` | Community | ✅ Online | 0 | 2026-10-24 |
| `51.68.46.73:28900` | Community | ✅ Online | - | 2026-10-24 |
| `46.28.109.117:28900` | Community | ✅ Online | - | 2026-10-24 |

## Red Eclipse

| Master server | Run by | Status | Servers | Last seen |
|---|---|---|---|---|
| `play.redeclipse.net:28800` | Official | ✅ Online | 13 | 2026-10-24 |

## Daikatana

Only master.maraakate.org is known to list Daikatana servers. master.maraakate.org is a GameSpy-compatible master for GameSpy 3D style browsers, run by Maraakate. It publishes its lists at http://maraakate.org/gamespy/, which is where the count comes from.

| Master server | Run by | Status | Servers | Last seen |
|---|---|---|---|---|
| `master.maraakate.org:27900` | Community | ✅ Online | 13 | 2026-10-24 |

## SiN

Only master.maraakate.org is known to list SiN servers. master.maraakate.org is a GameSpy-compatible master for GameSpy 3D style browsers, run by Maraakate. It publishes its lists at http://maraakate.org/gamespy/, which is where the count comes from.

| Master server | Run by | Status | Servers | Last seen |
|---|---|---|---|---|
| `master.maraakate.org:27900` | Community | ✅ Online | 3 | 2026-10-24 |

## Starsiege: Tribes

Point the game at the community masters by pasting $Server::MasterAddressN0 into the console, as tribesmasterserver.com explains. Dynamix's own masters are gone.

| Master server | Run by | Status | Servers | Last seen |
|---|---|---|---|---|
| `t1m1.pu.net:28000` | Community | ✅ Online | 30 | 2026-10-24 |
| `t1m1.masters.tribesmasterserver.com:28000` | Community | ⚠️ No response | - | Never |
| `t1m1.tribes0.com:28000` | Community | ⚠️ No response | - | Never |

### Retired master servers

| Master server | Run by | Gone | Notes |
|---|---|---|---|
| `t1m1.masters.dynamix.com:28000` | Official | Not answering since 2026-10-24 | Official Dynamix master. The hostname no longer resolves. |
| `t1m2.masters.dynamix.com:28000` | Official | Not answering since 2026-10-24 | Official Dynamix master. The hostname no longer resolves. |
| `t1aum1.masters.dynamix.com:28000` | Official | Not answering since 2026-10-24 | Official Dynamix Australian master. The hostname no longer resolves. |
| `t1m1.masters.dynamix1.com:28000` | Official | Not answering since 2026-10-24 | Dynamix backup master. The hostname no longer resolves. |
| `t1m2.masters.dynamix1.com:28000` | Official | Not answering since 2026-10-24 | Dynamix backup master. The hostname no longer resolves. |
| `skbmaster.ath.cx:28000` | Community | Not answering since 2026-10-24 | Community master. The hostname resolves to 0.0.0.0. |
| `kigen.ath.cx:28000` | Community | Not answering since 2026-10-24 | Community master. The hostname resolves to 0.0.0.0. |

## Unreal Tournament 4 (pre-alpha)

UT4MasterServer (https://github.com/timiimit/UT4MasterServer) is an open-source replacement for Epic's backend, with accounts at https://ut4.timiimit.com. The count comes from its public matchmaking list.

| Master server | Run by | Status | Servers | Last seen |
|---|---|---|---|---|
| `master-ut4.timiimit.com` | Community | ⚠️ No response | - | Never |

## Half-Life (WON)

WON2, started by SteamlessProject.nl and NoWon, replaces Valve's WON service (shut down 31 July 2004) for the pre-Steam Half-Life and its mods, such as Counter-Strike 1.5. Players install the WON2 patch, which sets these masters in woncomm.lst. master and master2 share one machine, and master3 and master4 another.

| Master server | Run by | Status | Servers | Last seen |
|---|---|---|---|---|
| `master3.won2.steamlessproject.nl:27010` | Community | ✅ Online | 64 | 2026-10-24 |
| `master4.won2.steamlessproject.nl:27010` | Community | ✅ Online | 64 | 2026-10-24 |
| `master.won2.steamlessproject.nl:27010` | Community | ✅ Online | 63 | 2026-10-24 |
| `master2.won2.steamlessproject.nl:27010` | Community | ✅ Online | 63 | 2026-10-24 |

### Retired master servers

| Master server | Run by | Gone | Notes |
|---|---|---|---|
| `209.173.38.9:27010` | Community | Not answering since 2026-10-24 | Listed in the 2013 WON2 woncomm.lst. It no longer answers master queries. |

## Mount & Blade: Warband

TaleWorlds still runs Warband's master server. The count comes from its public list.

| Master server | Run by | Status | Servers | Last seen |
|---|---|---|---|---|
| `warbandmain.taleworlds.com` | Official | ✅ Online | 297 | 2026-10-24 |

## Space Station 14

The Space Station 14 hub lists public servers. The count comes from its API.

| Master server | Run by | Status | Servers | Last seen |
|---|---|---|---|---|
| `hub.spacestation14.com` | Official | ✅ Online | 188 | 2026-10-24 |

## Skyrim Together Reborn

Servers with bAnnounceServer on report to the mod's own list server, which its source code names. The count comes from its public list.

| Master server | Run by | Status | Servers | Last seen |
|---|---|---|---|---|
| `skyrim-reborn-list.skyrim-together.com` | Official | ✅ Online | 95 | 2026-10-24 |

## Renegade X

Totem Arts, Renegade X's developer, publishes the server list. The count comes from it.

| Master server | Run by | Status | Servers | Last seen |
|---|---|---|---|---|
| `serverlist-rx.totemarts.services` | Official | ✅ Online | 9 | 2026-10-24 |

## Brickadia

Brickadia's own API lists public servers. Servers connect through Epic Online Services, so the list has no addresses and only the count is kept.

| Master server | Run by | Status | Servers | Last seen |
|---|---|---|---|---|
| `brickadia.com` | Official | ✅ Online | 57 | 2026-10-24 |

## Halo: Custom Edition

The free multiplayer expansion for Halo PC lists under the GameSpy name halom on the same master Bungie's patch 1.0.10 set up for retail Halo.

| Master server | Run by | Status | Servers | Last seen |
|---|---|---|---|---|
| `s1.master.hosthpc.com` | Official | Unchecked | - | Never |

## Battlefield 2

OpenSpy is the only master listed for this game so far. Clients and servers need OpenSpy's patch or a hosts file change; the game's guide is linked from https://openspy.net/supported-games.

| Master server | Run by | Status | Servers | Last seen |
|---|---|---|---|---|
| `master.openspy.net:27900` | Community | Unchecked | - | Never |
