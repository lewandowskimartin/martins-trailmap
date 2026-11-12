# 0004. Canonical work loop for feature work

- **Status:** accepted
- **Height:** medium
- **Date:** 2026-11-07
- **Supersedes:**
- **Superseded by:**

## Context

Owner proposed a start-to-finish checklist (plan → sense-check → research → parallelism → branch → check code → brief check → security → fixes → end report). It needed sense-checking and encoding into the skill.

## Options considered

### Use the checklist as written

- Pros: matches owner intent
- Cons: missing explicit **Implement**; full security-audit on every task is costly; “check code” conflates baseline and post-verify

### Refined ordered loop (chosen)

- Insert Orient + Implement; split baseline vs verify; gate research, parallelism, worktrunk, and full security-audit by need/height; require end report in git for medium/high

## Decision

Adopt the 13-step work loop in project-docs v1.3 (`references/work-loop.md`) as the default feature pipeline, with height-based collapsing for low work.

## Consequences

- Follow-ups: end-report template; plan template verify/security fields
- Tradeoffs: slightly longer skill; clearer agent behavior
- Out of scope: forcing full security-audit on chores
