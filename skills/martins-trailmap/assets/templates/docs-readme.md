# Project docs

Shared thinking for Claude (spec/brainstorm) and Cursor (implement/PR).

| Path | Purpose |
| --- | --- |
| `last-steps.md` | Living handoff — read first |
| `brainstorm/` | Explorations |
| `plans/active/` | Living plans (update often; several OK — repo or branch scope) |
| `plans/done/` | Finished plans + end reports |
| `decisions/` | Durable decisions |

If plans live at top-level `plans/`, say so in this table and keep using that root.

## Rules of thumb

1. Resume from `last-steps.md` + the living plan.
2. **Claude** specs; **Cursor** codes toward a **PR**.
3. Plan gate: medium with a clear ask → go; high → one grill round, then wait. Fog (a question you cannot state yet) stays under **Not yet specified** on the plan.
4. Soft tests before, full tests after; diff review before PR; no sloppy code.
5. claude-mem on both hosts for non-confidential work only; git docs remain source of truth.
6. Confidential / NDA repos: Trailmap docs only — add `docs/.trailmap-private` or `Trailmap privacy: confidential` in this README.
7. Never commit secrets; keep CMEM Pro / cloud sync off unless explicitly opted in.
8. Worktrunk/agentd only for real parallel work.

Agents: follow the `martins-trailmap` skill (Martin's Trailmap).
