# Card Game Biga

Godot-driven card battle game prototype.

## Current State

This repository contains a minimal Godot 4 project with:

- A tiny deckbuilding combat demo in `scenes/main.tscn`
- Core match state in `scripts/core`
- Card data definitions in `scripts/data`
- A tiny UI controller in `scripts/ui/main.gd`
- Project planning docs in `docs`

The current gameplay supports a small Slay-the-Spire-style loop: start a fight, draw a hand, spend energy on attack or block cards, read the enemy intent, end the turn, and play until victory or defeat.

## Local Setup

1. Install Godot 4.6.3 or newer.
2. Open this folder as a Godot project.
3. Run the main scene.

Headless smoke check:

```powershell
godot --headless --path . --script res://tests/e2e_spire_demo.gd
```

Local verified binary:

```text
Q:\codex\.omx\tools\godot-4.6.3\Godot_v4.6.3-stable_win64_console.exe
```

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
