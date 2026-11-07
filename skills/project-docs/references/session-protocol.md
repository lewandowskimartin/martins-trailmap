# Session protocol (detail)

The canonical ordered pipeline is [work-loop.md](work-loop.md). This file is the short checklist form.

## Cold start / orient

```text
[ ] Detect layout (docs/, top-level plans/, decisions paths)
[ ] Read docs/README.md map if present
[ ] Read last-steps.md
[ ] Skim active plan if any
[ ] Open relevant decisions
[ ] Optional: claude-mem search if last-steps is thin
[ ] Sense-check ask + height
```

## When to write what

| Event | Write |
| --- | --- |
| Exploring options | brainstorm (template) |
| Agreed multi-step work | plan (template) |
| Medium/high tradeoff | decision with Height field |
| Stopping mid-loop | update last-steps |
| Medium/high finished | end report + plan → done + last-steps |

## Decision height gate

| Height | Agent behavior |
| --- | --- |
| Low | No ADR; optional last-steps note; collapsed work loop OK |
| Medium | May accept after documenting; full verify + brief check + lightweight security |
| High | Propose only; wait for user; full loop + security-audit when trust boundaries |

When unsure → high.

## Templates

New durable files use `assets/templates/*`. Do not mass-convert legacy free-form notes.

## Commits

- Prefer docs with the code they describe
- Pure docs: `docs: …`
- last-steps must not claim unverified work
