# Memory layers

## docs/ (this skill)

- Committed to git → portable, reviewable, shared.
- Intentional: someone (human or agent) chose to write it.
- Survives tool switches (Claude ↔ Cursor), machines, and teammates.
- Best for: brainstorms, plans, ADRs, last-steps handoffs.

## claude-mem

- Local worker + SQLite under `~/.claude-mem` (cloud sync optional/paid).
- Automatic: hooks capture tool activity and summarize across sessions.
- Works with Claude Code, Cursor, and other supported hosts once installed (`npx claude-mem install`).
- Best for: “what did we touch last Tuesday?”, recovering context you never wrote down.
- Not a substitute for git-reviewed decisions.

## Chat / composer history

- Bound to one product UI.
- Fine for drafting; promote keepers into `docs/`.

## Practical split

| Situation | Prefer |
| --- | --- |
| End of session handoff | `docs/last-steps.md` |
| Choosing a database / API shape | `docs/decisions/` |
| Multi-step feature checklist | `docs/plans/active/` |
| “Did we already try X?” | claude-mem search, then docs |
| Secret / token | Neither — use env / secret store |

## Hygiene

- Do not mirror full mem timelines into markdown.
- Do not leave the only copy of a decision in chat or mem.
- If docs and mem disagree, trust docs for intent; use mem as a clue, then update docs.
