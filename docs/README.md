# Project docs

Shared thinking for Claude (spec/brainstorm) and Cursor (implement/PR).

| Path | Purpose |
| --- | --- |
| `last-steps.md` | Living handoff — read first |
| `brainstorm/` | Explorations |
| `plans/active/` | Living plans (update often; several OK — repo or branch scope) |
| `plans/done/` | Finished plans + end reports |
| `decisions/` | Durable decisions |

## Rules of thumb

1. Resume from `last-steps.md` + the living plan.
2. **Claude** specs; **Cursor** codes toward a **PR**.
3. Plan gate: medium → go; high → show and wait.
4. Soft tests before, full tests after; diff review before PR.
5. claude-mem on both hosts; git docs remain source of truth.
6. Worktrunk/agentd only for real parallel work.

Agents: follow the `project-docs` skill (v1.4).
