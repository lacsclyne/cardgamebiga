# Symphony Project Isolation

Use this pattern when adding another Linear/Symphony-driven project.

## Isolation Model

Projects may share the installed Symphony binaries and local credentials, but each project should own its runtime state:

```text
Q:\codex\.omx\projects\<project-key>\
  WORKFLOW.generated.md
  workspaces\
  logs\
  tmp\
```

This keeps cloned repositories, agent logs, temporary build files, and generated workflows separate.

## CardGameA Runtime

```text
Runtime root: Q:\codex\.omx\projects\cardgamea
Workflow:     Q:\codex\.omx\projects\cardgamea\WORKFLOW.generated.md
Workspaces:   Q:\codex\.omx\projects\cardgamea\workspaces
Logs:         Q:\codex\.omx\projects\cardgamea\logs
Temp:         Q:\codex\.omx\projects\cardgamea\tmp
Dashboard:    http://127.0.0.1:4100/
```

## Parallel Project Rules

- Use a unique Linear project slug.
- Use a unique GitHub repository URL.
- Use a unique runtime root under `Q:\codex\.omx\projects`.
- Use a unique dashboard port.
- Keep project-local Codex skills in the repository's `.codex/skills`.
- Do not write project-specific workflow files into the shared `symphony-local` directory.

## Start CardGameA

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\start-cardgamea-symphony.ps1
```

## Preflight Only

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\start-cardgamea-symphony.ps1 -PreflightOnly
```
