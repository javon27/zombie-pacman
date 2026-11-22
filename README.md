# Zombie Pac-Man

A 3/4-view pixel-art zombie-apocalypse take on Pac-Man, built in **Godot 4.7**.

> *Scavenge every supply in the area while the horde closes in — grab a weapon to turn the tables, but it won't last.*

## Why this project exists

I've been a software engineer for 12+ years, and my day-to-day workflow has gone deep into fully agentic AI. That works great when you already know the domain — but I've never shipped a complete game.

This project is a deliberate step back to basics: building a small, complete game in Godot using AI strictly as a **tutor and design critic**, not an autopilot. Every milestone pairs a Godot concept with a game-design lesson, and I'm writing the code and building the scenes myself.

- **Devlog #1:** [Watch on YouTube](https://www.youtube.com/watch?v=-Qw1a_7O5SI)
- **AI tutor rules & roadmap:** [AGENTS.md](AGENTS.md)
- **Living design doc:** [docs/DESIGN.md](docs/DESIGN.md)
- **Milestone progress & session log:** [docs/PROGRESS.md](docs/PROGRESS.md)

## The game (so far)

- **Setting:** Level 1 is a grocery store (aisles map naturally to Pac-Man corridors).
- **Supplies (the "dots"):** Medicine bottles, packaged food, and a special bonus item. Collecting more supplies raises zombie awareness — smarter pathing and speed.
- **Weapons (the power pellets):** Grab a melee weapon (starting with a bat/crowbar) to temporarily flip the tables on the horde.
- **Hiding & pressure:** Break line of sight + make 2+ turns for a short breather, while a visible **overrun timer** keeps you moving.
- **Look & feel:** 2D 3/4-view pixel art (`16×16` tiles, `384×216` base resolution, integer scaling) with grid-locked movement and turn buffering.

## Current progress

- [x] **M0** — Godot 4.7 orientation & VS Code LSP hookup
- [x] **M1** — Game design one-pager (`docs/DESIGN.md`)
- [ ] **M2** — The survivor moves *(M2.1 pixel-art viewport & Input Map done; player movement next)*
- [ ] **M3** — The maze (`TileMapLayer`, Y-sorting, camera)
- [ ] **M4** — Supplies & HUD
- [ ] **M5** — Zombies (grid pathfinding, state machine, sniffing telegraph)
- [ ] **M6** — Weapons (durability variants & custom Resources)
- [ ] **M7** — Game loop & progression
- [ ] **M8** — Juice (animations, tweens, screen shake, audio)
- [ ] **M9** — Playtesting & export

## Running locally

1. Install **Godot 4.7** (standard build).
2. Clone this repo and import `project.godot` in the Godot Project Manager (or run `godot -e` from the repo root).
3. Press **F5** to run.
