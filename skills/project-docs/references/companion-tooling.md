# Companion tooling — analysis & when to use

Evaluated for a **solo** developer doing occasional **big** multi-agent work, with Claude Code + Cursor, git `docs/`, and claude-mem.

## agentd ([obarker94/agentd](https://github.com/obarker94/agentd))

**What it is:** Go MCP server — projects, DAG tasks, claim/complete, SQLite state. Built for coordinating parallel agents (OpenCode-oriented config; usable anywhere MCP works).

**Worth it for big work?** **Yes, conditionally.**

| Use agentd | Prefer plain plans/ |
| --- | --- |
| Epic with 8+ tasks and real dependency edges | Feature with a linear checklist |
| 2+ agents claiming work without stomping | One agent at a time |
| Need a claim mutex + retry/fail | You’re fine updating markdown |

**Overlap:** worktrunk isolates *checkouts*; agentd orchestrates *task graph*. They complement: worktree per agent + agentd claims.

**Risk:** Early/small project (low stars, thin docs). Treat as optional infra — keep the source of truth in git plans so you can drop agentd without losing the epic.

**Skill rule:** Only suggest agentd when the user is starting a large parallelizable epic or explicitly asks. Never bootstrap it into every repo.

**Cursor wiring:** [agentd-cursor.md](agentd-cursor.md) (`~/.cursor/mcp.json` or `.cursor/mcp.json`).

## ECC ([affaan-m/ECC](https://github.com/affaan-m/ECC))

**What it is:** Huge Claude Code harness — dozens of agents, hundreds of skills, hooks, memory vault, AgentShield. Adapters for Cursor and others with uneven parity.

**Worth folding into project-docs?** **No — not wholesale.**

| Take | Leave |
| --- | --- |
| Mental loop: plan → test → implement → review → verify → remember | Installing 300+ skills into this pack |
| Optional full ECC install on Claude Code if you want that harness | Letting ECC memory replace `docs/last-steps` / decisions |
| | Expecting full ECC behavior inside Cursor |

**Risk:** Complexity and convention collision with our lean docs + claude-mem setup.

**Skill rule:** Mention as optional Claude Code install. Steal the loop for “big-dev protocol.” Do not depend on ECC files.

## Cloudflare security-audit ([cloudflare/security-audit-skill](https://github.com/cloudflare/security-audit-skill))

**What it is:** Multi-phase security audit skill — recon, coverage-led hunting, adversarial verification, schema-validated findings, target-neutral reports. Seeds Cloudflare’s vuln harness work.

**Worth it?** **Yes** for real products / big ships with trust boundaries.

| Use it | Skip it |
| --- | --- |
| Auth, multi-tenant, payments, public HTTP, secrets handling | Throwaway scripts, pure internal tooling with no attack surface |
| Pre-release or after a high-height security decision | Every tiny PR |

**Skill rule:** Recommend global install once. Invoke on security-audit requests and before shipping sensitive surfaces. Link reports from docs; don’t dump raw `findings.json` into product git unless asked.

## Stacking for a big epic

```text
docs plan (required)
    ├─ worktrunk          if parallel checkouts
    ├─ agentd            if DAG + claim coordination
    ├─ claude-mem        always (both hosts)
    └─ security-audit    before ship / on security ask
ECC                      optional Claude harness — orthogonal
```
