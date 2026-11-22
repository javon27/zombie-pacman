# Progress

> Updated by the AI assistant at the end of each step/session. See [AGENTS.md](../AGENTS.md).

## Current step

**M1 — Design one-pager**, in progress (M1.1: core loop + win/lose).

## Roadmap

- [x] M0 — Orientation (editor tour, VS Code hookup, first run)
  - [x] M0.1 — Editor tour, placeholder `main.tscn` (Node2D + Sprite2D), first run (F5)
  - [x] M0.2 — VS Code external editor, verify godot-tools LSP, attach first script
- [ ] M1 — Design one-pager
  - [ ] M1.1 — Core loop + win/lose (DESIGN.md)
  - [ ] M1.2 — Perspective & movement decisions (2D vs 3D, grid vs free, resolution/art)
  - [ ] M1.3 — Setting + first pass on zombies/weapons
- [ ] M2 — The survivor moves
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
