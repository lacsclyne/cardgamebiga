# Automation Playbook

## Goal

Use Linear for issue tracking and Symphony for coordinated execution while keeping this repository as the durable source of implementation truth.

## Current Integration Status

CardGameA has a Linear project and reuses the shared local Symphony installation already used by the `rance` workspace. Runtime state is isolated per project.

- Linear project slug: `cardgamea-3f851a07e18a`
- Linear project URL: `https://linear.app/lacsclyne/project/cardgamea-3f851a07e18a/overview`
- GitHub repository: `https://github.com/lacsclyne/cardgamebiga.git`
- Shared Symphony installation: `Q:\codex\.omx\symphony-local`
- CardGameA runtime root: `Q:\codex\.omx\projects\cardgamea`
- CardGameA workspaces: `Q:\codex\.omx\projects\cardgamea\workspaces`
- CardGameA logs: `Q:\codex\.omx\projects\cardgamea\logs`
- CardGameA temp files: `Q:\codex\.omx\projects\cardgamea\tmp`
- CardGameA dashboard: `http://127.0.0.1:4100/`
- CardGameA Symphony launcher: `scripts/start-cardgamea-symphony.ps1`

Automation should read from these files:

- `docs/game_design_brief.md`
- `docs/core_gameplay_spec.md`
- `docs/architecture.md`
- `docs/backlog.md`
- `docs/symphony_project_isolation.md`

## Linear Structure

Project: `CardGameA`

Milestones:

- Foundation
- Rules Prototype
- Playable Local Match
- Content Pipeline
- Automation

Issue labels:

- `godot`
- `rules`
- `ui`
- `content`
- `test`
- `automation`

## Suggested Symphony Workflow

1. Read `docs/backlog.md`.
2. Pick one unblocked issue.
3. Create or update a branch from `main`.
4. Implement the smallest complete slice.
5. Run available checks.
6. Open a PR with:
   - Gameplay impact
   - Files changed
   - Manual test notes
   - Follow-up tasks

## Starting Symphony For CardGameA

Run a preflight check:

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\start-cardgamea-symphony.ps1 -PreflightOnly
```

Start the CardGameA runner:

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\start-cardgamea-symphony.ps1
```

This generates a CardGameA-specific Symphony workflow without overwriting the existing `rance` workflow.

The default CardGameA port is `4100`, so `rance` can keep using `4000`.

## Branch Naming

```text
feature/<linear-id>-short-name
fix/<linear-id>-short-name
chore/<linear-id>-short-name
```

If Linear is not connected yet:

```text
feature/local-short-name
fix/local-short-name
chore/local-short-name
```

## First Automation Prompts

### Issue Generator

Read `docs/backlog.md` and create Linear issues for unchecked tasks. Preserve milestone grouping and apply labels based on the task wording.

### Implementation Agent

Pick one Linear issue, inspect the repository, implement the smallest complete change, update tests or manual QA notes, and prepare a PR.

### QA Agent

Review the PR for gameplay regressions, Godot scene/script errors, missing tests, and unclear player-facing behavior.
