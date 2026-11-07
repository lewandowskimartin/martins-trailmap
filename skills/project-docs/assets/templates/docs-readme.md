# Project docs

Shared thinking for humans and AI agents (Claude, Cursor, and others).

| Path | Purpose |
| --- | --- |
| `last-steps.md` | Living handoff for this branch — read first |
| `brainstorm/` | Explorations and option dumps |
| `plans/active/` | In-flight implementation plans |
| `plans/done/` | Finished plans (archive, do not delete) |
| `decisions/` | Durable architecture / product decisions |

## Rules of thumb

1. Resume from `last-steps.md`.
2. Update plans as you go; move finished plans to `done/`.
3. Record real tradeoffs in `decisions/` — one decision per file.
4. Keep secrets out of this folder.
5. Automatic session memory (e.g. claude-mem) complements this; it does not replace it.

Agents: follow the `project-docs` skill.
