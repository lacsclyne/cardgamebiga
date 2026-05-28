# Project Collaboration Notes

This is the real `CardGameA` project workspace.

## Paths

- Main repository: `Q:\codex\cardgamea`
- Shared Symphony installation: `Q:\codex\.omx\symphony-local`
- CardGameA runtime root: `Q:\codex\.omx\projects\cardgamea`
- CardGameA workflow: `Q:\codex\.omx\projects\cardgamea\WORKFLOW.generated.md`
- CardGameA workspaces: `Q:\codex\.omx\projects\cardgamea\workspaces`
- CardGameA logs: `Q:\codex\.omx\projects\cardgamea\logs`
- CardGameA temp files: `Q:\codex\.omx\projects\cardgamea\tmp`
- Symphony dashboard: `http://127.0.0.1:4100/`

## Symphony

Symphony is configured as a local long-running runner for this project. It reuses the shared Symphony installation and credentials, but its workflow, workspace, logs, temp files, and dashboard port are isolated from other projects.

- Linear project slug: `cardgamea-3f851a07e18a`
- Linear project URL: `https://linear.app/lacsclyne/project/cardgamea-3f851a07e18a/overview`
- GitHub repository: `https://github.com/lacsclyne/cardgamebiga.git`
- Active issue states: `Todo`, `In Progress`, `Merging`, `Rework`
- Preferred state for newly drafted issues: `Todo`

Use Symphony for unattended implementation work driven by Linear issues. Keep each issue small, concrete, and verifiable.

## Skills

Project-local skills live in `.codex/skills`.

- Use `create-symphony-issue` when the user asks to draft, split, refine, review, or create Linear issues for Symphony/Codex unattended execution.
- Treat requests like "create a Linear issue", "write a Linear issue", "create a Symphony issue", or "write an issue" as automatic `create-symphony-issue` triggers. Unless the user explicitly asks for a draft only, create the issue in Linear after preparing a specific Symphony-ready title and body.
- Existing repo workflow skills include `linear`, `pull`, `commit`, `push`, and `land`.

## Linear Issue Style

When preparing issues for Symphony, include:

- a clear goal
- relevant background when helpful
- concrete requirements
- acceptance checks
- constraints such as avoiding unrelated file changes

Prefer splitting broad requests into multiple independently executable issues.
