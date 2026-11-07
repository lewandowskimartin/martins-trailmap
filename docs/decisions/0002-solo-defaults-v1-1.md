# 0002. Solo defaults for project-docs v1.1

- **Status:** accepted
- **Height:** medium
- **Date:** 2026-11-07
- **Supersedes:**
- **Superseded by:**

## Context

Owner answered the open questions from the v1 skill pack. Defaults need to match solo use, mixed existing layouts, and both AI hosts.

## Options considered

### Templates vs free-form

- Free-form everywhere — flexible, inconsistent agent resumes
- **Templates for new durable files (chosen)** — consistent cross-repo structure; leave legacy notes alone

### Decision acceptance

- Always ask — too slow for medium reversible choices
- Always accept — risky for high-stakes choices
- **Height-based gate (chosen)** — low skip · medium may accept · high ask

### Worktrunk now vs later

- Install immediately — unused complexity for sequential solo work
- **Defer until parallel agents (chosen)**

### claude-mem hosts

- One host only — weak when switching AI
- **Claude Code and Cursor both (chosen)**

## Decision

Lock solo profile: personal skill install; detect/adapt `docs/` + top-level `plans/`; require templates for new durable docs; height-based decision gates; Worktrunk optional; claude-mem on both Claude and Cursor.

## Consequences

- Follow-ups: skill v1.1 + bootstrap respects top-level `plans/`
- Tradeoffs: dual plans roots allowed until user asks to merge
- Out of scope: forcing every legacy repo onto `docs/plans/active/`
