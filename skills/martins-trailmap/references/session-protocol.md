# Session protocol

Canonical ordered pipeline: [work-loop.md](work-loop.md). Work shapes: [work-types.md](work-types.md).

## Orient

```text
[ ] Layout map (docs/, plans/)
[ ] last-steps.md
[ ] Living plan(s) — repo and/or branch scope
[ ] Relevant decisions
[ ] Optional mem search
[ ] Sense-check type + height
[ ] Tool: Claude (spec) vs Cursor (code) for this session?
```

## Write map

| Event | Write |
| --- | --- |
| Exploring | brainstorm |
| Agreed / in-flight work | living plan (update often) |
| Medium/high tradeoff | decision + Height |
| Spec ready for Cursor | last-steps “ready for implement” |
| Mid-loop stop | last-steps |
| After PR (medium/high) | end report + plan done |

## Plan gate

| Height | Behavior |
| --- | --- |
| Low | No formal plan |
| Medium | Update plan → go |
| High | Show plan → wait |

## Commits / PR

- Commit docs with related code
- Code work aims at **push + PR**
- last-steps must not claim unverified or un-PRed work as done
