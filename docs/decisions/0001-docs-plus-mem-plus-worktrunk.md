# 0001. Three-layer memory: docs + claude-mem + worktrunk

- **Status:** accepted
- **Date:** 2026-11-07
- **Supersedes:**
- **Superseded by:**

## Context

AI coding sessions forget context across tools and machines. Automatic memory plugins help locally; parallel agents need isolated worktrees; teams and cold agents need something in git.

## Options considered

### Option A — Only claude-mem

- Pros: automatic, low friction
- Cons: local-first; not visible to every tool/teammate via the repo; poor fit for deliberate ADRs

### Option B — Only a docs/ folder

- Pros: portable, reviewable, tool-agnostic
- Cons: relies on discipline; misses “what did we try last session?” unless written down

### Option C — docs/ + claude-mem + worktrunk (chosen)

- Pros: intentional shared memory + automatic local continuity + parallel isolation
- Cons: three concepts to learn (mitigated by one skill that explains the split)

## Decision

Use a committed `docs/` tree as the shared source of truth; use claude-mem as optional automatic local memory; use worktrunk for parallel agent worktrees. Encode the protocol in a portable Agent Skill installable for both Claude Code and Cursor.

## Consequences

- Follow-ups: personal install script; optional project vendoring for cloud/teammates
- Tradeoffs we accept: agents must update `last-steps.md` deliberately
- Out of scope: full multi-skill ADR platforms, TeamBrain/cloud mem as requirements
