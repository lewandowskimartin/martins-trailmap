# Session protocol

Canonical ordered pipeline: [work-loop.md](work-loop.md). Work shapes: [work-types.md](work-types.md).

## Orient

```text
[ ] Layout map (docs/, plans/)
[ ] last-steps.md
[ ] Living plan(s) — repo and/or branch scope
[ ] Relevant decisions
[ ] Optional mem search
[ ] Sense-check type + height (loose ask → one grill round, then wait)
[ ] Tool: Claude (spec) vs Cursor (code) for this session?
```

## Write map

| Event | Write |
| --- | --- |
| Exploring | brainstorm |
| Fog (cannot state the question yet) | **Not yet specified** on the living plan (brainstorm if no plan yet) |
| Agreed / in-flight work | living plan (update often) |
| Medium/high tradeoff | decision + Height |
| Spec ready for Cursor | last-steps “ready for implement” |
| Mid-loop stop | last-steps |
| After PR (medium/high) | end report + plan done |

## Plan gate

| Height | Behavior |
| --- | --- |
| Low | No formal plan |
| Medium | Update plan, including fog → go |
| High | One grill round → show plan → wait |
| Loose ask | One grill round before type and height are fixed |

## Commits / PR

- Commit docs with related code
- Code work aims at **push + PR**
- last-steps must not claim unverified or un-PRed work as done
