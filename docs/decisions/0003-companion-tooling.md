# 0003. Companion tooling for big work

- **Status:** accepted
- **Height:** medium
- **Date:** 2026-11-07
- **Supersedes:**
- **Superseded by:**

## Context

Owner asked whether to adopt agentd, ECC, and Cloudflare security-audit-skill for large development efforts, and whether to encode them in the project-docs skill.

## Options considered

### agentd

- Always-on orchestration — too heavy for solo sequential work
- **Conditional for large DAG/parallel epics (chosen)**
- Never — would leave a gap when true multi-agent epics appear

### ECC

- Merge into this skill pack — conflicts with lean docs workflow; Cursor parity uneven
- **Optional Claude harness; borrow plan→test→review→verify loop only (chosen)**
- Ignore entirely — loses a useful process pattern

### security-audit-skill

- Skip — weaker shipping bar for products with trust boundaries
- **Recommend as companion skill for security/ship gates (chosen)**

## Decision

Encode all three as **companions** in project-docs v1.2 with clear when/skip rules. agentd and ECC are opt-in; security-audit is recommended for sensitive surfaces. Git `docs/` remains the intentional source of truth.

## Consequences

- Follow-ups: `references/companion-tooling.md`, big-dev protocol in SKILL.md
- Tradeoffs: more concepts in the skill; mitigated by “do not install by default”
- Out of scope: vendoring ECC or Cloudflare skill source into this repo
