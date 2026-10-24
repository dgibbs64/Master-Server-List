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

## Alien Arena

| Master server | Status | Servers | Last seen |
|---|---|---|---|
| `master.alienarena.org:27900` | ✅ Online | 20 | 2026-10-24 |
| `master2.alienarena.org:27900` | ✅ Online | 20 | 2026-10-24 |

## AssaultCube

The master returns its list over HTTP.

| Master server | Status | Servers | Last seen |
|---|---|---|---|
| `ms.cubers.net` | ✅ Online | 45 | 2026-10-24 |

## Battlefield 1942

Needs the multiplayer patch from bf1942.org, which points the game at this master.

| Master server | Status | Servers | Last seen |
|---|---|---|---|
| `master.bf1942.org` | ✅ Online | - | 2026-10-24 |

## BeamMP

This game has no classic master server. Its public server list is a web API, checked the same way and counted from the API's response.

| Master server | Status | Servers | Last seen |
|---|---|---|---|
| `backend.beammp.com` | ✅ Online | 2991 | 2026-10-24 |

## Call of Duty

| Master server | Status | Servers | Last seen |
|---|---|---|---|
| `codmaster.activision.com:20510` | ✅ Online | 65 | 2026-10-24 |

## Call of Duty 2

| Master server | Status | Servers | Last seen |
|---|---|---|---|
| `cod2master.activision.com:20710` | ✅ Online | 371 | 2026-10-24 |

## Call of Duty 4: Modern Warfare

| Master server | Status | Servers | Last seen |
|---|---|---|---|
| `cod4master.activision.com:20810` | ✅ Online | 1297 | 2026-10-24 |

## Call of Duty: United Offensive

| Master server | Status | Servers | Last seen |
|---|---|---|---|
| `coduomaster.activision.com:20610` | ✅ Online | 158 | 2026-10-24 |

## Chocolate Doom

| Master server | Status | Servers | Last seen |
|---|---|---|---|
| `master.chocolate-doom.org:2342` | ✅ Online | 24 | 2026-10-24 |

## Clive Barker's Undying

| Master server | Status | Servers | Last seen |
|---|---|---|---|
| `master.333networks.com:27900` | ✅ Online | - | 2026-10-24 |
| `master.errorist.eu:27900` | ✅ Online | - | 2026-10-24 |
| `master.gonespy.com:27900` | ✅ Online | - | 2026-10-23 |
| `master.newbiesplayground.net:27900` | ✅ Online | - | 2026-10-24 |

## DDNet / Teeworlds

This game has no classic master server. Its public server list is a web API, checked the same way and counted from the API's response.

| Master server | Status | Servers | Last seen |
|---|---|---|---|
| `master1.ddnet.org` | ✅ Online | 1432 | 2026-10-24 |

## Deus Ex

| Master server | Status | Servers | Last seen |
|---|---|---|---|
| `master.deusexnetwork.com:27900` | ✅ Online | 7 | 2026-10-24 |
| `master.333networks.com:27900` | ✅ Online | 7 | 2026-10-24 |
| `master.gonespy.com:27900` | ✅ Online | 7 | 2026-10-23 |
| `master.errorist.eu:27900` | ✅ Online | 6 | 2026-10-24 |
| `master.newbiesplayground.net:27900` | ✅ Online | 6 | 2026-10-24 |

## Doom 3

| Master server | Status | Servers | Last seen |
|---|---|---|---|
| `idnet.ua-corp.com:27650` | ✅ Online | 21 | 2026-10-24 |

## Drakan: Order of the Flame

| Master server | Status | Servers | Last seen |
|---|---|---|---|
| `master.333networks.com:27900` | ✅ Online | 1 | 2026-10-24 |
| `master.errorist.eu:27900` | ✅ Online | 1 | 2026-10-24 |
| `master.newbiesplayground.net:27900` | ✅ Online | 1 | 2026-10-24 |
| `master.gonespy.com:27900` | Unchecked | - | Never |

## Duke Nukem Forever (2001)

The leaked 2001 build, which still has a small multiplayer community.

| Master server | Status | Servers | Last seen |
|---|---|---|---|
| `master.333networks.com:27900` | ✅ Online | 8 | 2026-10-24 |
| `master.errorist.eu:27900` | ✅ Online | 4 | 2026-10-24 |
| `master.newbiesplayground.net:27900` | ✅ Online | 4 | 2026-10-24 |
| `master.gonespy.com:27900` | Unchecked | - | Never |

## Global Operations

| Master server | Status | Servers | Last seen |
|---|---|---|---|
| `master.errorist.eu:27900` | ✅ Online | 6 | 2026-10-24 |
| `master.333networks.com:27900` | ✅ Online | 4 | 2026-10-24 |
| `master.gonespy.com:27900` | ✅ Online | 3 | 2026-10-23 |
| `master.newbiesplayground.net:27900` | ✅ Online | 3 | 2026-10-24 |

## Halo: Combat Evolved

Patch 1.0.10 points the game at this master, so no config change is needed.

| Master server | Status | Servers | Last seen |
|---|---|---|---|
| `s1.master.hosthpc.com` | ✅ Online | - | 2026-10-24 |

## Heretic II

| Master server | Status | Servers | Last seen |
|---|---|---|---|
| `master.333networks.com:27900` | ✅ Online | 4 | 2026-10-24 |
| `master.errorist.eu:27900` | ✅ Online | 3 | 2026-10-24 |
| `master.gonespy.com:27900` | ✅ Online | 3 | 2026-10-23 |
| `master.newbiesplayground.net:27900` | ✅ Online | 3 | 2026-10-24 |

## HeXen II

Hexen II itself has no master server: multiplayer uses direct IP. Internet play with a server browser uses HeXenWorld.

## HeXenWorld

No public master server is known. hexenworld.org, which ran the last one, no longer resolves. Hammer of Thyrion (uHexen2) ships hwmaster for anyone wanting to host one; its default port is 26900.

## Iron Storm

| Master server | Status | Servers | Last seen |
|---|---|---|---|
| `master.333networks.com:27900` | ✅ Online | 0 | 2026-10-24 |
| `master.errorist.eu:27900` | ✅ Online | 0 | 2026-10-24 |
| `master.gonespy.com:27900` | ✅ Online | 0 | 2026-10-23 |
| `gsm.qtracker.com` | ✅ Online | - | 2026-10-24 |

## Kingpin

| Master server | Status | Servers | Last seen |
|---|---|---|---|
| `master.333networks.com:27900` | ✅ Online | 40 | 2026-10-24 |
| `master.gonespy.com:27900` | ✅ Online | 31 | 2026-10-23 |
| `master.errorist.eu:27900` | ✅ Online | 30 | 2026-10-24 |
| `master.newbiesplayground.net:27900` | ✅ Online | 30 | 2026-10-24 |

## Luanti (Minetest)

This game has no classic master server. Its public server list is a web API, checked the same way and counted from the API's response.

| Master server | Status | Servers | Last seen |
|---|---|---|---|
| `servers.luanti.org` | ✅ Online | 438 | 2026-10-24 |

## Medal of Honor: Allied Assault

Spearhead and Breakthrough have their own entries below.

| Master server | Status | Servers | Last seen |
|---|---|---|---|
| `master.gonespy.com:27900` | ✅ Online | 225 | 2026-10-23 |
| `master.333networks.com:27900` | ✅ Online | 208 | 2026-10-24 |
| `master.errorist.eu:27900` | ✅ Online | 184 | 2026-10-24 |
| `master.newbiesplayground.net:27900` | ✅ Online | 163 | 2026-10-24 |

## Medal of Honor: Allied Assault Breakthrough

Needs the patched binaries from 333networks.com/instructions/mohaa.

| Master server | Status | Servers | Last seen |
|---|---|---|---|
| `master.333networks.com:27900` | ✅ Online | 49 | 2026-10-24 |
| `master.errorist.eu:27900` | ✅ Online | 37 | 2026-10-24 |
| `master.newbiesplayground.net:27900` | ✅ Online | 30 | 2026-10-24 |
| `master.gonespy.com:27900` | Unchecked | - | Never |

## Medal of Honor: Allied Assault Spearhead

Needs the patched binaries from 333networks.com/instructions/mohaa.

| Master server | Status | Servers | Last seen |
|---|---|---|---|
| `master.333networks.com:27900` | ✅ Online | 73 | 2026-10-24 |
| `master.errorist.eu:27900` | ✅ Online | 66 | 2026-10-24 |
| `master.newbiesplayground.net:27900` | ✅ Online | 57 | 2026-10-24 |
| `master.gonespy.com:27900` | Unchecked | - | Never |

## Mobile Forces

| Master server | Status | Servers | Last seen |
|---|---|---|---|
| `master.333networks.com:27900` | ✅ Online | 2 | 2026-10-24 |
| `master.errorist.eu:27900` | ✅ Online | 1 | 2026-10-24 |
| `master.gonespy.com:27900` | ✅ Online | 1 | 2026-10-23 |
| `master.newbiesplayground.net:27900` | ✅ Online | 1 | 2026-10-24 |

## Nerf Arena Blast

| Master server | Status | Servers | Last seen |
|---|---|---|---|
| `master.333networks.com:27900` | ✅ Online | 0 | 2026-10-24 |
| `master.errorist.eu:27900` | ✅ Online | 0 | 2026-10-24 |
| `master.gonespy.com:27900` | ✅ Online | 0 | 2026-10-23 |
| `master.newbiesplayground.net:27900` | ✅ Online | 0 | 2026-10-24 |

## Nexuiz

| Master server | Status | Servers | Last seen |
|---|---|---|---|
| `dpmaster.tchr.no:27950` | ✅ Online | 29 | 2026-10-24 |
| `dpmaster.deathmask.net:27950` | ✅ Online | 18 | 2026-10-24 |

## Odamex

| Master server | Status | Servers | Last seen |
|---|---|---|---|
| `master1.odamex.net:15000` | ✅ Online | 141 | 2026-10-24 |
| `master2.odamex.net:15000` | ✅ Online | 141 | 2026-10-24 |

## OpenArena

| Master server | Status | Servers | Last seen |
|---|---|---|---|
| `dpmaster.deathmask.net:27950` | ✅ Online | 114 | 2026-10-24 |
| `master.ioquake3.org:27950` | ✅ Online | 66 | 2026-10-24 |

## Postal 2

| Master server | Status | Servers | Last seen |
|---|---|---|---|
| `master.gonespy.com:27900` | ✅ Online | 27 | 2026-10-23 |
| `master.333networks.com:27900` | ✅ Online | 21 | 2026-10-24 |
| `master.errorist.eu:27900` | ✅ Online | 18 | 2026-10-24 |
| `master.newbiesplayground.net:27900` | ✅ Online | 6 | 2026-10-24 |

## Q3Rally

| Master server | Status | Servers | Last seen |
|---|---|---|---|
| `dpmaster.deathmask.net:27950` | ✅ Online | 2 | 2026-10-24 |

## Quake (DarkPlaces)

| Master server | Status | Servers | Last seen |
|---|---|---|---|
| `dpmaster.tchr.no:27950` | ✅ Online | 58 | 2026-10-24 |
| `dpmaster.deathmask.net:27950` | ✅ Online | 43 | 2026-10-24 |

## Quake 2

| Master server | Status | Servers | Last seen |
|---|---|---|---|
| `master.quakeservers.net:27900` | ✅ Online | 102 | 2026-10-24 |

## Quake 3

| Master server | Status | Servers | Last seen |
|---|---|---|---|
| `master.quake3arena.com:27950` | ✅ Online | 980 | 2026-10-24 |
| `master.ioquake3.org:27950` | ✅ Online | 943 | 2026-10-24 |
| `master.maverickservers.com:27950` | ✅ Online | 445 | 2026-10-24 |
| `master0.excessiveplus.net:27950` | ✅ Online | 213 | 2026-10-24 |
| `dpmaster.deathmask.net:27950` | ✅ Online | 174 | 2026-10-24 |

## Quake 4

| Master server | Status | Servers | Last seen |
|---|---|---|---|
| `q4master.idsoftware.com:27650` | ✅ Online | 23 | 2026-10-24 |

## QuakeWorld

| Master server | Status | Servers | Last seen |
|---|---|---|---|
| `master.quakeservers.net:27000` | ✅ Online | 688 | 2026-10-24 |
| `qwmaster.fodquake.net:27000` | ✅ Online | 646 | 2026-10-23 |

## Return to Castle Wolfenstein

| Master server | Status | Servers | Last seen |
|---|---|---|---|
| `wolfmaster.s4ndmod.com:27950` | ✅ Online | 104 | 2026-10-24 |
| `wolfmaster.idsoftware.com:27950` | ✅ Online | 83 | 2026-10-24 |
| `dpmaster.deathmask.net:27950` | ✅ Online | 53 | 2026-10-24 |

## Rune

| Master server | Status | Servers | Last seen |
|---|---|---|---|
| `master.333networks.com:27900` | ✅ Online | 58 | 2026-10-24 |
| `master.errorist.eu:27900` | ✅ Online | 39 | 2026-10-24 |
| `master.gonespy.com:27900` | ✅ Online | 32 | 2026-10-23 |
| `master.newbiesplayground.net:27900` | ✅ Online | 32 | 2026-10-24 |

## San Andreas Multiplayer (SA:MP / open.mp)

This game has no classic master server. Its public server list is a web API, checked the same way and counted from the API's response.

| Master server | Status | Servers | Last seen |
|---|---|---|---|
| `api.open.mp` | ✅ Online | 1236 | 2026-10-24 |

## Sauerbraten

| Master server | Status | Servers | Last seen |
|---|---|---|---|
| `master.sauerbraten.org:28787` | ✅ Online | 70 | 2026-10-24 |

## Serious Sam

| Master server | Status | Servers | Last seen |
|---|---|---|---|
| `master.333networks.com:27900` | ✅ Online | 70 | 2026-10-24 |
| `master.errorist.eu:27900` | ✅ Online | 41 | 2026-10-24 |
| `master.gonespy.com:27900` | ✅ Online | 41 | 2026-10-23 |
| `master.newbiesplayground.net:27900` | ✅ Online | 41 | 2026-10-24 |

## Serious Sam: Second Encounter

| Master server | Status | Servers | Last seen |
|---|---|---|---|
| `master.333networks.com:27900` | ✅ Online | 111 | 2026-10-24 |
| `master.gonespy.com:27900` | ✅ Online | 78 | 2026-10-23 |
| `master.errorist.eu:27900` | ✅ Online | 76 | 2026-10-24 |
| `master.newbiesplayground.net:27900` | ✅ Online | 72 | 2026-10-24 |

## Smokin' Guns

| Master server | Status | Servers | Last seen |
|---|---|---|---|
| `master.smokin-guns.org:27950` | ✅ Online | 8 | 2026-10-24 |

## Soldat

This game has no classic master server. Its public server list is a web API, checked the same way and counted from the API's response.

| Master server | Status | Servers | Last seen |
|---|---|---|---|
| `api.soldat.pl` | ✅ Online | 60 | 2026-10-24 |

## Soldier of Fortune

| Master server | Status | Servers | Last seen |
|---|---|---|---|
| `master.333networks.com:27900` | ✅ Online | 44 | 2026-10-24 |
| `master.errorist.eu:27900` | ✅ Online | 32 | 2026-10-24 |
| `master.gonespy.com:27900` | ✅ Online | 30 | 2026-10-23 |
| `master.newbiesplayground.net:27900` | ✅ Online | 29 | 2026-10-24 |

## Soldier of Fortune II

| Master server | Status | Servers | Last seen |
|---|---|---|---|
| `master.1fxmod.org:20110` | ✅ Online | 50 | 2026-10-24 |
| `master.333networks.com:27900` | ✅ Online | - | 2026-10-24 |
| `master.errorist.eu:27900` | ✅ Online | - | 2026-10-24 |
| `master.gonespy.com:27900` | ✅ Online | - | 2026-10-23 |
| `master.newbiesplayground.net:27900` | ✅ Online | - | 2026-10-24 |

## Star Trek: Elite Force II

The game needs the community master server patch (or a hosts file entry for ef2master.activision.com) to use these masters. They answer queries, but the protocol number EF2 servers register with is unconfirmed, so no server count is shown.

| Master server | Status | Servers | Last seen |
|---|---|---|---|
| `master.hazardmodding.com:27900` | ✅ Online | - | 2026-10-24 |
| `master.stef2.daggolin.de:27900` | ✅ Online | - | 2026-10-24 |

## Star Trek: Voyager Elite Force

| Master server | Status | Servers | Last seen |
|---|---|---|---|
| `master.stef1.daggolin.de:27953` | ✅ Online | 29 | 2026-10-24 |
| `master.stvef.org:27953` | ✅ Online | 26 | 2026-10-24 |
| `efmaster.tjps.eu:27953` | ✅ Online | 19 | 2026-10-24 |

## Star Wars Jedi Knight II: Jedi Outcast

| Master server | Status | Servers | Last seen |
|---|---|---|---|
| `master.jkhub.org:28060` | ✅ Online | 42 | 2026-10-24 |
| `master.jk2mv.org:28060` | ✅ Online | 36 | 2026-10-24 |

## Star Wars Jedi Knight: Jedi Academy

| Master server | Status | Servers | Last seen |
|---|---|---|---|
| `master.jkhub.org:29060` | ✅ Online | 263 | 2026-10-24 |
| `master.jk2mv.org:29060` | ✅ Online | 224 | 2026-10-24 |

## Tesseract

| Master server | Status | Servers | Last seen |
|---|---|---|---|
| `master.tesseract.gg:41999` | ✅ Online | 4 | 2026-10-24 |

## Tremulous

| Master server | Status | Servers | Last seen |
|---|---|---|---|
| `master.tremulous.net:30710` | ✅ Online | 15 | 2026-10-24 |

## Tribes 2

TribesNext runs the master and authentication for Tribes 2. Servers heartbeat it automatically once TribesNext is installed.

| Master server | Status | Servers | Last seen |
|---|---|---|---|
| `master.tribesnext.com` | ✅ Online | 35 | 2026-10-24 |

## Turok 2

| Master server | Status | Servers | Last seen |
|---|---|---|---|
| `master.gonespy.com:27900` | ✅ Online | 4 | 2026-10-23 |
| `master.333networks.com:27900` | ✅ Online | 0 | 2026-10-24 |
| `master.errorist.eu:27900` | ✅ Online | 0 | 2026-10-24 |
| `master.newbiesplayground.net:27900` | ✅ Online | 0 | 2026-10-24 |

## Unreal

| Master server | Status | Servers | Last seen |
|---|---|---|---|
| `master.errorist.eu:27900` | ✅ Online | 147 | 2026-10-24 |
| `master-au.unrealarchive.org:27900` | ✅ Online | 95 | 2026-10-24 |
| `master.gonespy.com:27900` | ✅ Online | 93 | 2026-10-23 |
| `master.oldunreal.com:27900` | ✅ Online | 88 | 2026-10-24 |
| `master.newbiesplayground.net:27900` | ✅ Online | 88 | 2026-10-24 |
| `master.frag-net.com:27900` | ✅ Online | 88 | 2026-10-23 |
| `master.eatsleeput.com:27900` | ✅ Online | 87 | 2026-10-24 |
| `master.hypercoop.tk:27900` | ✅ Online | 73 | 2026-10-24 |
| `master.exsurge.net:27900` | ✅ Online | 0 | 2026-10-24 |

## Unreal Tournament 2003

| Master server | Status | Servers | Last seen |
|---|---|---|---|
| `master.333networks.com:27900` | ✅ Online | 0 | 2026-10-24 |
| `master.errorist.eu:27900` | ✅ Online | 0 | 2026-10-24 |
| `master.newbiesplayground.net:27900` | ✅ Online | 0 | 2026-10-24 |
| `master.gonespy.com:27900` | Unchecked | - | Never |

## Unreal Tournament 2004

| Master server | Status | Servers | Last seen |
|---|---|---|---|
| `master.333networks.com:27900` | ✅ Online | - | 2026-10-24 |
| `master.gonespy.com:27900` | ✅ Online | - | 2026-10-23 |
| `master.newbiesplayground.net:27900` | ✅ Online | - | 2026-10-24 |
| `ut2004master.333networks.com:28902` | ✅ Online | - | 2026-10-24 |
| `ut2004master.errorist.eu:28902` | ✅ Online | - | 2026-10-24 |
| `ut2004master.gonespy.com:28902` | ✅ Online | - | 2026-10-23 |

## Unreal Tournament 99

| Master server | Status | Servers | Last seen |
|---|---|---|---|
| `master.333networks.com:27900` | ✅ Online | 1766 | 2026-10-24 |
| `master.errorist.eu:27900` | ✅ Online | 1248 | 2026-10-24 |
| `master.gonespy.com:27900` | ✅ Online | 995 | 2026-10-23 |
| `master-au.unrealarchive.org:27900` | ✅ Online | 927 | 2026-10-24 |
| `master.frag-net.com:27900` | ✅ Online | 901 | 2026-10-24 |
| `master.noccer.de:27900` | ✅ Online | 899 | 2026-10-24 |
| `master.eatsleeput.com:27900` | ✅ Online | 899 | 2026-10-24 |
| `master.newbiesplayground.net:27900` | ✅ Online | 896 | 2026-10-24 |
| `master.oldunreal.com:27900` | ✅ Online | 896 | 2026-10-24 |
| `master.exsurge.net:27900` | ✅ Online | 0 | 2026-10-24 |

## Urban Terror

| Master server | Status | Servers | Last seen |
|---|---|---|---|
| `master.urbanterror.info:27900` | ✅ Online | 238 | 2026-10-24 |
| `master2.urbanterror.info:27900` | ✅ Online | 238 | 2026-10-24 |

## Vintage Story

This game has no classic master server. Its public server list is a web API, checked the same way and counted from the API's response.

| Master server | Status | Servers | Last seen |
|---|---|---|---|
| `masterserver.vintagestory.at` | ✅ Online | 2485 | 2026-10-24 |

## Warfork

| Master server | Status | Servers | Last seen |
|---|---|---|---|
| `dpmaster.deathmask.net:27950` | ✅ Online | 1 | 2026-10-24 |

## Warsow

| Master server | Status | Servers | Last seen |
|---|---|---|---|
| `dpmaster.tchr.no:27950` | ✅ Online | 28 | 2026-10-24 |
| `dpmaster.deathmask.net:27950` | ✅ Online | 23 | 2026-10-24 |

## Wheel of Time

| Master server | Status | Servers | Last seen |
|---|---|---|---|
| `master.333networks.com:27900` | ✅ Online | 17 | 2026-10-24 |
| `master.errorist.eu:27900` | ✅ Online | 7 | 2026-10-24 |
| `master.gonespy.com:27900` | ✅ Online | 7 | 2026-10-23 |
| `master.newbiesplayground.net:27900` | ✅ Online | 7 | 2026-10-24 |

## Wolfenstein: Enemy Territory

| Master server | Status | Servers | Last seen |
|---|---|---|---|
| `etmaster.idsoftware.com:27950` | ✅ Online | 430 | 2026-10-24 |
| `master.etlegacy.com:27950` | ✅ Online | 418 | 2026-10-24 |
| `wolfmaster.idsoftware.com:27950` | ✅ Online | 62 | 2026-10-24 |

## World of Padman

| Master server | Status | Servers | Last seen |
|---|---|---|---|
| `master.worldofpadman.net:27955` | ✅ Online | 1 | 2026-10-24 |

## Xonotic

| Master server | Status | Servers | Last seen |
|---|---|---|---|
| `dpmaster.deathmask.net:27950` | ✅ Online | 292 | 2026-10-24 |
| `dpmaster.tchr.no:27950` | ✅ Online | 32 | 2026-10-24 |

## Zandronum

| Master server | Status | Servers | Last seen |
|---|---|---|---|
| `master.zandronum.com:15300` | ✅ Online | 757 | 2026-10-24 |
