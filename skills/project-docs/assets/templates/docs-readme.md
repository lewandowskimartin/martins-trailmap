# Project docs

Shared thinking for humans and AI agents (Claude, Cursor, and others).

| Path | Purpose |
| --- | --- |
| `last-steps.md` | Living handoff for this branch — read first |
| `brainstorm/` | Explorations and option dumps |
| `plans/active/` | In-flight implementation plans |
| `plans/done/` | Finished plans (archive, do not delete) |
| `decisions/` | Durable architecture / product decisions |

If this repo keeps plans at top-level `plans/` instead, say so in a Path map table and use that root.

## Rules of thumb

1. Resume from `last-steps.md`.
2. **New** durable files use the `project-docs` templates (consistent across repos).
3. Decision height: **low** = no ADR; **medium** = agent may accept after documenting; **high** = propose and wait.
4. Install **claude-mem on Claude and Cursor**; it complements git docs, it does not replace them.
5. Keep secrets out of this folder.
6. Worktrunk is optional — only for parallel agents.

Agents: follow the `project-docs` skill.
