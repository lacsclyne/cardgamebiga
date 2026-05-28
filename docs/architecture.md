# Architecture

## Current Shape

```text
scenes/main.tscn
  -> scripts/ui/main.gd
      -> scripts/core/game_state.gd
          -> scripts/core/player_state.gd
              -> scripts/core/deck.gd
          -> scripts/data/card_data.gd
```

## Boundaries

- `scripts/core`: pure match rules and state transitions.
- `scripts/data`: card definitions and future static content resources.
- `scripts/ui`: input, rendering, and presentation only.
- `tests`: headless checks for deterministic game behavior.

## Near-Term Direction

Add a card effect resolution layer before expanding UI complexity. The first useful split is:

- `CardData`: static card identity, cost, type, and text.
- `CardEffect`: executable rule payload.
- `GameState`: owns legal state transitions and win/loss checks.
- `TurnManager`: optional later extraction if turn timing becomes complex.

## Testing Strategy

Prioritize small deterministic tests around:

- Deck shuffle/draw/discard behavior
- Turn transitions
- Energy and playability
- Damage and win conditions
- Any mechanic with timing windows or random outcomes
