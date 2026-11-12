# 0008. Fog stays on the plan; grill only when high or loose

- **Status:** accepted
- **Height:** medium
- **Date:** 2026-11-12
- **Supersedes:**
- **Superseded by:**

## Context

The owner asked to add one idea from a fog-of-war decision practice, and a thin interview slice, without splitting Martin's Trailmap into more skills.

## Options considered

### Separate grill and fog skills

- Pros: each mode stays short
- Cons: a second handoff system; Cloud must vendor more than one pack

### Full multi-round interview on every plan

- Pros: fewer silent assumptions
- Cons: undoes the medium gate (update the plan and go)

### Fog on the living plan, one grill round at high or loose asks (chosen)

- Pros: uses the existing plan and decision files; medium MMFs stay fast
- Cons: a high effort may still leave fog listed after one round

## Decision

Trailmap v1.7 keeps one skill.

- A question you can state precisely is a decision, even when the answer is open.
- An unknown you cannot yet state as a question is fog. Write it under **Not yet specified** on the living plan (or in `docs/brainstorm/` while the effort is still a spike with no plan).
- When sharp questions are settled and fog remains, medium work may start. The plan names that fog.
- One grill round when height is high, or when the ask is too loose to name outcome, type, and height. Recommended answer on each question, worded so yes accepts it. Facts are looked up by the agent. The user owns the decisions.
- Medium work with a clear ask does not get a grill round.

## Consequences

- Follow-ups: skill v1.7, plan template section, work-loop and session-protocol gates
- Tradeoffs we accept: one round can miss a later frontier; the next session picks that up from the plan
- Out of scope: issue-tracker decision tickets, background research agents, vendoring a writing-for-agents skill
