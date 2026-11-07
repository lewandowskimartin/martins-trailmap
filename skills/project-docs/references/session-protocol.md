# Session protocol (detail)

## Cold start checklist

```text
[ ] docs/README.md exists? skim conventions
[ ] docs/last-steps.md → resume point
[ ] docs/plans/active/ → matching plan?
[ ] docs/decisions/ → anything constraining this task?
[ ] Optional: claude-mem search if last-steps is thin
[ ] Then work
```

## When to write what

| Event | Write |
| --- | --- |
| Exploring options | `brainstorm/YYYY-MM-DD-slug.md` |
| Agreed approach, multi-step work | `plans/active/slug.md` |
| Meaningful tradeoff locked in | `decisions/NNNN-slug.md` |
| Stopping for the day / switching tasks | Update `last-steps.md` |
| Plan finished | Move plan → `plans/done/`, tick decision to `implemented` if applicable |

## Approval gates (lightweight)

Default: write brainstorms and last-steps freely; propose decisions and ask before marking `accepted` if the user is available. If the user said “just decide and document”, accept and proceed.

Avoid bureaucracy: a one-hour bugfix needs last-steps (maybe) — not an ADR.

## Commit guidance

- Prefer committing docs with the code they describe.
- Pure docs commits: `docs: …`
- Do not leave `last-steps.md` claiming work that was never committed.
