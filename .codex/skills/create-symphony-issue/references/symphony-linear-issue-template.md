# Symphony Linear Issue Template

Use this reference to draft Linear issues for Symphony/Codex unattended execution.

## Minimal Issue

```markdown
目标：在 CardGameA 仓库中 <实现/修复/更新> <具体事项>。

要求：
- <明确要求 1>
- <明确要求 2>
- <明确要求 3>

验收：
- <可运行的命令、测试、截图检查、或用户可见行为>
- <另一个完成标准>

限制：
- 不要改动与本 issue 无关的文件。
- 保持现有代码风格和项目结构。
- 如果遇到无法安全决定的问题，在 Linear 的 Codex Workpad 评论中说明 blocker。
```

## Good Issue Example

```markdown
Title: Add deterministic card draw tests
State: Todo

Description:
目标：为 CardGameA 的牌库抽牌、弃牌回洗和手牌上限行为添加最小可维护测试。

背景：当前项目已经有 `scripts/core/deck.gd` 和 `tests/test_game_state.gd`，但牌库边界行为还没有被覆盖。

要求：
- 添加覆盖 `Deck.draw`、弃牌回洗、空牌库抽牌、手牌上限的测试。
- 测试应使用固定随机种子，避免不稳定结果。
- 如发现现有实现有小 bug，可以在同一 PR 中修复。

验收：
- 运行 Godot headless 测试或项目当前可用的等效检查。
- 运行 `git diff --check`。
- PR 描述中说明实际运行过的验证。

限制：
- 不要重构 UI 或改动场景文件。
- 不要引入新的测试框架，除非仓库已有约定无法满足。
```

## Splitting Heuristics

Split into separate issues when:

- UI, data model, rules engine, and tests are each non-trivial.
- The request contains "and also" items that can be shipped independently.
- One issue would require more than one PR to review comfortably.
- A prerequisite decision or discovery step may change the implementation plan.

Keep one issue when:

- The change is localized to one behavior or one small workflow.
- Validation can be stated in two or three checks.
- The task can be completed safely from the issue text alone.
