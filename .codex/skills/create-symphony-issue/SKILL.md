---
name: create-symphony-issue
description: Turn natural-language requests into clear Symphony-ready Linear issues for the CardGameA project. Use when the user asks to write, draft, split, refine, review, or create Linear issues/tasks for Symphony/Codex unattended execution.
---

# Create Symphony Issue

## Purpose

Prepare Linear issues that Symphony can execute without back-and-forth. Optimize for small, concrete, verifiable tasks in the `CardGameA` repository.

Project defaults:

- Linear project slug: `cardgamea-3f851a07e18a`
- Linear project URL: `https://linear.app/lacsclyne/project/cardgamea-3f851a07e18a/overview`
- Repository: `https://github.com/lacsclyne/cardgamebiga.git`
- Active states handled by Symphony: `Todo`, `In Progress`, `Merging`, `Rework`
- Preferred first state for new work: `Todo`
- Local dashboard: `http://127.0.0.1:4000/`

Do not expose secrets. If Linear API access is needed, read local environment setup without printing API keys.

## Workflow

1. Convert the user's request into one or more small issues.
2. Split work when one issue would require unrelated files, broad design choices, or multiple validation surfaces.
3. For each issue, produce:
   - Title
   - Description body
   - Suggested Linear state
   - Suggested labels only if the user or repo already implies them
4. Ask at most one concise question only when a missing decision would make unattended execution unsafe.
5. If the user explicitly asks to create issues in Linear, create them only after the title and body are specific enough for Symphony.

## Activation and Creation Behavior

This skill is automatically triggered by requests such as "create a Linear issue",
"write a Linear issue", "create a Symphony issue", "write an issue", or their
Chinese equivalents.

When the user says to write or create an issue and the request is concrete enough
for unattended Symphony work, create the issue in Linear by default. Only return a
draft without creating it when the user explicitly asks for a draft, asks to
review the issue text first, or the issue would be unsafe to create without one
more decision.

## Issue Quality Rules

Write issues as instructions to an unattended coding agent:

- State the concrete outcome, not a vague theme.
- Include the relevant page, command, file, behavior, or error when known.
- Include acceptance checks that can be run or observed.
- Include limits such as "do not change unrelated files" when useful.
- Avoid bundling research, design, implementation, and cleanup unless they are tiny.
- Avoid phrases like "improve", "optimize", or "make better" unless followed by measurable criteria.

Prefer issue titles in this shape:

- `Fix <specific broken behavior>`
- `Add <specific user-visible feature>`
- `Refactor <specific narrow area> to <desired structure>`
- `Document <specific workflow or command>`

## Output Format

When drafting only, use this compact format:

```markdown
Title: <imperative or outcome-focused title>
State: Todo

Description:
目标：<one paragraph>

背景：<only if useful>

要求：
- <requirement>
- <requirement>

验收：
- <check>
- <check>

限制：
- 不要改动与本 issue 无关的文件。
- 保持现有项目风格。
```

For multiple issues, number them and keep each issue independently executable.

## References

Load `references/symphony-linear-issue-template.md` when the user wants examples, asks what a good issue looks like, or wants a larger request split into several polished Linear issues.
