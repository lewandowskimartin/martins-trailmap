# 0005. Lean-startup v1.4 loop defaults

- **Status:** accepted
- **Height:** medium
- **Date:** 2026-11-08
- **Supersedes:**
- **Superseded by:**

## Context

Audit gaps and owner answers: PR as aim, Cursor Cloud heavy, Claude for spec / Cursor for code, living multi-plans, soft-before/full-after tests, diff review, hotfix path, vendor skill by default.

## Decision

Adopt project-docs **v1.4**:

- Work loop includes diff review + commit/push/PR; PR is definition of done for code
- Work types: feature, bugfix, spike, hotfix, chore
- Plan gate: medium go / high show
- Low mini-loop + hotfix path made explicit
- Tests: soft before, full after (acceptable lean default)
- Several living plans (repo + branch scope); update often
- Tool split: Claude spec, Cursor code
- Bootstrap vendors skill by default for Cursor Cloud (`SKIP_PROJECT_SKILL=1` to opt out)
- agentd Cursor MCP documented; work-loop refs trimmed to instruction quality

## Consequences

- Follow-ups: refresh vendored copies in product repos with `REFRESH_PROJECT_SKILL=1`
- Tradeoffs: slightly longer loop; higher shipping quality bar
- Out of scope: requiring merge/deploy as agent-done (human may merge)
