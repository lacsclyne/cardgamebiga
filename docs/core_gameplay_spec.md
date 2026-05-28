# Core Gameplay Spec

Use this file to capture the concrete rules before implementation.

## Match Goal

Describe how a player wins or loses.

## Players

- Player count:
- Starting health:
- Starting resources:
- Starting hand size:
- Deck size:

## Turn Structure

1. Start of turn:
2. Draw step:
3. Main action step:
4. Combat or resolution step:
5. End of turn:

## Resources

- Resource name:
- How resources are gained:
- Whether resources carry over:
- Maximum resource amount:

## Card Types

- Attack:
- Skill:
- Power:
- Other:

## Board Rules

- Zones:
- Unit or card limits:
- Targeting rules:
- Timing windows:

## Card Resolution

Describe the exact sequence when a card is played:

1. Validate:
2. Pay cost:
3. Choose targets:
4. Resolve effect:
5. Move card:
6. Trigger follow-up effects:

## Randomness

- Shuffle rules:
- Random targeting:
- Seed requirements for replay or tests:

## Prototype Card List

| Id | Name | Cost | Type | Effect |
| --- | --- | ---: | --- | --- |
| strike | Strike | 1 | Attack | Deal damage. |

## Open Questions

- Which mechanics are required for the first playable prototype?
- Which mechanics should wait until the second milestone?
- What should an average match length feel like?
