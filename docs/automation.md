# Automation Playbook

## Goal

Use Linear for issue tracking and Symphony for coordinated execution while keeping this repository as the durable source of implementation truth.

## Current Integration Status

No callable Linear or Symphony connector is currently exposed in this Codex session. Until those are connected, automation should read from these files:

- `docs/game_design_brief.md`
- `docs/core_gameplay_spec.md`
- `docs/architecture.md`
- `docs/backlog.md`

## Suggested Linear Structure

Project: `Card Game Biga`

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
