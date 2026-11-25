# Zombie Pac-Man — Design Doc

> Living document. Yours to write; the AI will prompt you and offer options.
> Keep it short. Decisions + reasons > prose.

## Pitch (one sentence)

_A 3/4-view zombie-apocalypse take on Pac-Man: scavenge every supply in the area while
the horde closes in — grab a weapon to turn the tables, but it won't last._

## Core loop

**Every 10 seconds** — route and evade.
- Like Pac-Man: pick a route through the level collecting supplies (food, medicine, tools)
  while avoiding zombie bites.
- When chased, choose: **run** (fast, but noisy — may pull in more zombies) or **duck into
  a hiding spot** for a short breather.
- **Weapons replace power pellets:** grab one to turn the tables and fight back — but it
  won't last.

**Every minute** — the pressure builds.
- Supplies get collected; the level empties out.
- The horde keeps growing over time.
- **Awareness rises as you carry more supplies** (more scent, tracks, noise): zombies get
  more aggressive and hunt you deliberately (faster, more direct).
- A visible **overrun timer** counts down to the tipping point.

**Every level** — new rules to read.
- New zombie types with different behaviors (e.g. sound-only, smell-only — post-MVP).
- New setting (grocery store, police station, ...).

## Win / lose

- **Win a level when:** all supplies are collected before the overrun timer runs out.
- **Lose a life when:** a zombie bites you. Actors reset to start positions; collected
  supplies stay collected; play continues.
- **Game over when:** out of lives, **or** the overrun timer runs out (the level is overrun).

## Setting & layout

- [ ] City grid
- [ ] Supermarket
- [x] Different per level

Notes: one setting per level. **Level 1: grocery store** (aisles = Pac-Man corridors; supplies
fit the theme). Later: police station, ...

## Perspective & movement

| Decision | Choice | Why |
|----------|--------|-----|
| 2D (3/4 art) or 3D (angled camera) | 2D, 3/4-view art | Simpler for a first game; Pac-Man is a 2D grid game at heart |
| Grid-locked or free movement | Grid-locked, but the player can **stop** (for hiding) | Crisp Pac-Man feel + turn buffering; stopping to be playtested |
| Tile size / base resolution | Retro: 16×16 tiles, 384×216 base res (1152×648 window, 3× integer scale) | Fast to make art for; clean 5× scale to 1080p; explore higher res later |
| Art style (pixel art? low-poly?) | Pixel art | Fits retro res; lots of CC0 placeholder art (Kenney.nl) |

Zombie AI is grid-based too (tile-to-tile pathing).

## The survivor

- Can hide for a short breather — not full stealth. Hiding is a pause, not a strategy:
  escalation and the overrun timer keep running.
- Running costs stamina, regain by taking a breather.
- **How to hide:** break line of sight with a chasing zombie, then make **2+ turns**. The
  zombie loses track (goes to your last known position and sniffs around).
- Unlike Pac-Man, the survivor can **stop** moving (still grid-locked).
- **Hold to move:** the survivor moves only while a direction is held; release = stop at the next tile center (stop-anywhere was playtested in M2.5 and rejected).
  No auto-run. **Instant reverse** mid-tile is allowed.

## Supplies (the "dots")

_Types? All the same, or some worth more? Any "fruit" bonus equivalent?_

- **Regular supplies** (the dots): medicine bottles, packaged food — mostly equivalent.
- **Special item** (the "fruit"): e.g. a cake or a fuel container. Effect TBD. Possibly increasing player stat.

## Zombies

_How many? Do they have Pac-Man-style personalities? How do they behave when you're armed?_

- **MVP: always-chasing** — zombies always know where you are (like Pac-Man's ghosts),
  **except** they lose track when you break line of sight + make 2+ turns (see Survivor).
  Detection by sound/smell is a possible post-MVP layer.
- Start with ~1, more arrive over time and in response to noise.
- Killed zombies don't come back — they're **replaced** by new ones.
- **Awareness/aggression scales with supplies carried**, not time — the more you've
  collected, the harder they hunt: **smarter pathing** (more direct routes to you) and speed.
- **Readable tells:** zombies visibly **sniff** or **listen** for the player, so awareness
  changes are something you can see, not just feel. (Placeholder icon/tint until M8 animations.)
- **Sniffing pauses the zombie** — a telegraph and a window for the player to slip away.

| Zombie | Behavior | Notes |
|--------|----------|-------|
| Listener | Detects by sound only | Post-MVP idea |
| Sniffer | Detects by smell only | Post-MVP idea |

## Weapons (the power pellets)

_Timed durability is the starting idea. Alternatives to playtest: hit-count, ammo, melee vs. ranged._

- Weapons take the place of Pac-Man's power pellets: pick one up and the hunted becomes the
  hunter, temporarily.

| Weapon | Duration / durability | Effect on zombies | Notes |
|--------|-----------------------|-------------------|-------|
| Bat / crowbar (first prototype) | TBD (timed vs. hit-count — playtest in M6) | TBD (flee? killable on contact?) | Melee |

## Open questions

- **Special item: what does it do?** Pac-Man's fruit is just bonus points, appearing briefly
  at a fixed spot. A fuel container hints at a mechanic (fire? a generator?); cake is pure reward.
- **How long does a zombie stay lost?** Does it sniff for a few seconds, then resume
  chasing from anywhere, or wander until it sees you again?
- **How long is the overrun timer, and does it reset on death?** Also: does the horde size
  reset when you lose a life, or keep climbing?
- **How do awareness levels map to behavior?** Thresholds for smarter pathing / speed, how
  often they wander vs. hunt? Can hiding lower awareness temporarily?
- **What happens at the tipping point?** Instant game over, or a flood of zombies that's
  effectively unsurvivable?
- **Where do new zombies spawn?** (Pac-Man has the ghost house.) Spawning in view or right
  next to the player feels unfair.
- **How does "noise" work under always-chase?** Running pulls in more zombies — is that a
  faster spawn rate while running?

## Decisions log

| Date | Decision | Reason |
|------|----------|--------|
| 2026-11-21 | No exit/safe room — collecting all supplies wins | Keep it simple |
| 2026-11-21 | Killed zombies stay dead but are replaced by new ones | Kills give relief without letting the level get easier |
| 2026-11-21 | Setting changes per level (grocery store, police station, ...) | Variety between levels |
| 2026-11-21 | Weapons replace power pellets | Core power-fantasy moment: the hunted becomes the hunter |
| 2026-11-21 | "Overrun" = a visible countdown timer; horde grows until the tipping point | Measurable lose condition; prevents hiding forever |
| 2026-11-21 | Hiding = short breather, not full stealth | Relief valve without building a stealth game |
| 2026-11-21 | MVP zombies are always-chasing; detection senses are post-MVP | Readable like Pac-Man; much smaller scope for M5 |
| 2026-11-21 | Zombie aggression scales with supplies collected, not time | Progress = danger (risk/reward); the overrun timer handles stalling |
| 2026-11-21 | Awareness = smarter pathing + speed; zombies pause to sniff/listen as a visible tell | Readable telegraph; gives the player a window to escape |
| 2026-11-21 | 2D, 3/4-view pixel art, 16 px tiles at retro res | Simplest path for a first game; revisit resolution later |
| 2026-11-21 | Grid-locked movement + AI; the player can stop | Pac-Man feel and simple pathing; stopping enables hiding |
| 2026-11-21 | Hiding = break line of sight + 2+ turns | Skill-based escape, no hiding-spot tiles needed |
| 2026-11-21 | Level 1 is a grocery store | Aisles map to Pac-Man corridors; sets the tone |
| 2026-11-21 | First weapon: melee (bat/crowbar) | Simple to prototype; closest to a power pellet |
| 2026-11-21 | Supplies mostly equivalent + one special item | Pac-Man dots + fruit model |
| 2026-11-24 | Stop only at tile centers; instant reverse mid-tile | Playtested stop-anywhere in M2.5 and didn't like it; reverse keeps Pac-Man's dodge |
| 2026-11-24 | Hold a direction to move; releasing stops at the next tile center (no Pac-Man auto-run) | Stopping (for hiding) comes for free; deliberate, direct control |
