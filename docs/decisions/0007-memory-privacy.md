# 0007. Memory privacy controls for claude-mem

- **Status:** accepted
- **Height:** high
- **Date:** 2026-11-08
- **Supersedes:**
- **Superseded by:**

## Context

claude-mem stores session-derived context locally and may send observation compression to Anthropic. CMEM Pro adds cloud sync. Owner asked whether Trailmap should prevent misuse on confidential projects.

## Decision

Encode privacy policy in Martin's Trailmap v1.5:

- Default: local claude-mem OK for own/non-sensitive work; cloud sync / CMEM Pro off
- Confidential / NDA / regulated: docs-only handoff; do not rely on mem; optional `docs/.trailmap-private` marker
- Never put secrets in docs, mem notes, or PR bodies
- Agents must not recommend Pro sync for confidential repos

## Consequences

- Follow-ups: skill section + `references/memory-layers.md` update
- Tradeoffs: slightly more ceremony on sensitive repos; safer default
- Out of scope: automatically uninstalling system-wide claude-mem per repo
