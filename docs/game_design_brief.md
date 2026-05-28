# Game Design Brief

## One-Line Pitch

A Godot card battle game where the rules engine is separated from presentation so the core gameplay can evolve quickly.

## Design Pillars

- Rules first: match state, deck flow, card costs, and turn flow should be testable outside the UI.
- Fast iteration: new cards and mechanics should be easy to prototype as data plus small effect handlers.
- Readable battles: the player should always understand turn, resources, hand state, and outcome.

## Initial Game Loop

1. Build each player's deck.
2. Start a match with deterministic seed support.
3. Draw cards at the start of each turn.
4. Spend energy to play cards.
5. Resolve card effects.
6. End turn, discard hand, pass priority.
7. Finish when a player reaches 0 health or another win condition is met.

## Open Gameplay Slots

These are intentionally undecided in code until the concrete core gameplay is written down:

- Card lanes or board positions
- Attack targeting rules
- Defense, armor, shield, or block systems
- Persistent summons or units
- Status effects
- Deck construction restrictions
- Match length and comeback mechanics
