# Session protocol (detail)

## Cold start checklist

```text
[ ] Detect layout (docs/, top-level plans/, decisions paths)
[ ] Read docs/README.md map if present
[ ] Read last-steps.md → resume point
[ ] Skim active plans in mapped plans root
[ ] Open relevant decisions
[ ] Optional: claude-mem search if last-steps is thin
[ ] Then work
```

## When to write what

| Event | Write |
| --- | --- |
| Exploring options | brainstorm (template) |
| Agreed multi-step work | plan (template) |
| Medium/high tradeoff | decision with Height field |
| Stopping / switching AI or task | update last-steps |
| Plan finished | move/mark done; set decision `implemented` if applicable |

## Decision height gate

| Height | Agent behavior |
| --- | --- |
| Low | No ADR; optional last-steps note |
| Medium | May accept after documenting; reversible preferred |
| High | Propose only; wait for user; then `accepted` |

When unsure → high.

## Templates

New durable files use `assets/templates/*`. Do not mass-convert legacy free-form notes.

## Commits

- Prefer docs with the code they describe
- Pure docs: `docs: …`
- last-steps must not claim uncommitted work
