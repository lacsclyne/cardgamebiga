# Card Game Biga

Godot-driven card battle game prototype.

## Current State

This repository contains a minimal Godot 4 project with:

- A playable prototype shell in `scenes/main.tscn`
- Core match state in `scripts/core`
- Card data definitions in `scripts/data`
- A tiny UI controller in `scripts/ui/main.gd`
- Project planning docs in `docs`

The current gameplay is intentionally skeletal: start a match, draw cards, and pass turns. The real rules can be layered into the core scripts without making the UI carry game logic.

## Local Setup

1. Install Godot 4.3 or newer.
2. Open this folder as a Godot project.
3. Run the main scene.

If Godot is available on the command line, a future test command can be added for the scripts in `tests`.

## Repository

Remote:

```text
https://github.com/lacsclyne/cardgamebiga.git
```

## Automation Notes

Linear and Symphony should treat `docs/backlog.md`, `docs/core_gameplay_spec.md`, and `docs/automation.md` as the first source of truth.

CardGameA uses the existing local Symphony installation from `Q:\codex\.omx\symphony-local`, with isolated runtime state under `Q:\codex\.omx\projects\cardgamea`.

Start it for this project with:

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\start-cardgamea-symphony.ps1
```

The default dashboard is `http://127.0.0.1:4100/`.
