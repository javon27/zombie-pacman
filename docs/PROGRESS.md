# Progress

> Updated by the AI assistant at the end of each step/session. See [AGENTS.md](../AGENTS.md).

## Current step

**M2 — The survivor moves**, in progress (M2.4: turn buffering).

## Roadmap

- [x] M0 — Orientation (editor tour, VS Code hookup, first run)
  - [x] M0.1 — Editor tour, placeholder `main.tscn` (Node2D + Sprite2D), first run (F5)
  - [x] M0.2 — VS Code external editor, verify godot-tools LSP, attach first script
- [x] M1 — Design one-pager
  - [x] M1.1 — Core loop + win/lose (DESIGN.md)
  - [x] M1.2 — Perspective & movement decisions (2D vs 3D, grid vs free, resolution/art)
  - [x] M1.3 — Setting + first pass on zombies/weapons
- [ ] M2 — The survivor moves
  - [x] M2.1 — Pixel-art display settings + Input Map actions
  - [x] M2.2 — Player scene (`CharacterBody2D`), free movement first
  - [x] M2.3 — Grid-locked movement (tile-to-tile)
  - [ ] M2.4 — Turn buffering (pre-turning)
  - [ ] M2.5 — Stopping (tile-center vs. anywhere playtest)
- [ ] M3 — The maze
- [ ] M4 — Supplies (the "dots")
- [ ] M5 — Zombies
- [ ] M6 — Weapons (the power pellets)
- [ ] M7 — Game loop & structure
- [ ] M8 — Juice
- [ ] M9 — Ship it

<!-- Sub-steps get added under the active milestone as we break it down. -->

## Graduated skills

Things the human has learned well enough that the AI may do them directly in "drive" mode.

- _(none yet)_

## Session log

### 2026-11-21 — Project setup
- Created Godot 4.7 project skeleton, AGENTS.md / CLAUDE.md, docs.
- Next: M0 — open the project in Godot, tour the editor, wire up VS Code.

### 2026-11-21 — M0.1 Editor tour & first run
- Opened project, created `main.tscn` (`Main: Node2D` → `Icon: Sprite2D`), set as main scene, ran with F5.
- Learned: nodes vs. scenes, the four main docks, `.tscn` stores only non-default props,
  main scene is referenced by UID (why `.uid`/`.import` files get committed).
- Open questions: none. Decided against a Godot MCP addon for now (learning goal); revisit if debugging round-trips get painful.

### 2026-11-21 — M0.2 VS Code hookup
- Godot external editor → VS Code (`D:\...\Microsoft VS Code\Code.exe`, flags `{project} --goto {file}:{line}:{col}`).
- Attached `main.gd` to `Main`, `print()` in `_ready()` shows in Output.
- Gotcha learned: launching Godot from VS Code's integrated terminal breaks "open in external editor"
  silently (inherited VS Code env vars). Launch Godot via Win+R / standalone terminal.
- Open: confirm godot-tools LSP is actually connected (status bar shows GDScript, `get_tree()` autocompletes).

### 2026-11-21 — M1.1 Core loop + win/lose
- Filled in DESIGN.md core loop and win/lose; reviewed against Pac-Man's design.
- Decisions: weapons = power pellets; overrun = visible countdown timer (prevents hiding forever);
  hiding is a short breather, not stealth; MVP zombies always-chase, detection senses post-MVP;
  killed zombies replaced; no exit; setting varies per level.
- Open: how hiding works with always-chase, timer length/reset on death, spawn points (see DESIGN.md).

### 2026-11-21 — M1.2 Perspective & movement
- Decisions: 2D 3/4-view pixel art, 16 px tiles at retro res; grid-locked movement + AI;
  player can stop; hiding = break line of sight + 2+ turns. Also: aggression scales with
  supplies collected (smarter pathing + speed), zombies pause to sniff (telegraph).
- Open: stop at tile centers vs. anywhere (M2 playtest); how long zombies stay "lost".

### 2026-11-21 — M1.3 First level & weapon (M1 complete)
- Level 1 = grocery store; first weapon = melee (bat/crowbar); supplies mostly equivalent
  (medicine, packaged food) + one special "fruit" item (cake or fuel, effect TBD).
- Next: M2.1 display settings + Input Map.

### 2026-11-21 — M2.1 Pixel-art display settings + Input Map
- Set viewport to `384×216` (`1152×648` window override, `viewport` stretch, `integer` scale) and `Nearest` default texture filter.
- Added `move_up`, `move_down`, `move_left`, `move_right` actions bound to WASD + arrow keys.
- Next: M2.2 — create `actors/player/player.tscn` (`CharacterBody2D`) and get basic movement running.

### 2026-11-24 — M2.2 Player scene & free movement
- Built `actors/player/player.tscn` (`Player: CharacterBody2D`, Floating motion mode, `Sprite2D` at 0.125 scale, 16×16 `RectangleShape2D`); instanced in `main.tscn`.
- `player.gd`: `@export var speed: float = 80.0`, `Input.get_vector` over the `move_*` actions, `velocity = direction * speed`, `move_and_slide()`.
- Learned: scenes are built in the Godot editor and scripts in VS Code; Attach Script's default template is a platformer (gravity/jump), so replace it; don't multiply velocity by `delta` with `move_and_slide()`; `@export` = live tuning via the Remote tree.
- Feel: instant start/stop, no acceleration (Pac-Man-like; needed for grid movement).
- Next: M2.3 — grid-locked tile-to-tile movement.

### 2026-11-24 — M2.3 Grid-locked movement
- `player.gd` moves tile-to-tile: `_target` tile center, input read only at the target, `position.move_toward(_target, speed * delta)`; dropped `velocity`/`move_and_slide()` (overshoots tile centers; walls will be tile checks).
- 4-way input from `get_vector` via `signf` per axis (fixed a 0.707 off-grid drift). Own idea: holding two directions prefers the axis you're *not* on → zig-zag; with walls this becomes "turn at the next opening" (seed of M2.4).
- Added a runtime `DebugGrid` (`_draw()` + `draw_line`) to `main.tscn`. Player starts on tile center (184, 104); screen is 13.5 tiles tall, so no tile center is at screen center.
- Design: **hold to move**, release stops at next tile center (DESIGN.md).
- Learned: type inference (`:=`), `absf`/`signf` vs untyped `abs`/`sign`, GDScript member order + 2 blank lines between functions.
