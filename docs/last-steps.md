# Last steps

> Living handoff for this branch. Overwrite in place. Keep to one screen.

- **Branch:** main
- **Updated:** 2026-11-07
- **Active plan:** none
- **Related decisions:** `0001`, `0002`, `0003`

## Current state

Skill pack **v1.2** adds companion tooling rules: agentd (big DAG epics only), ECC (optional Claude harness, not merged), Cloudflare security-audit (recommended companion).

## Just done

- Analysed obarker94/agentd, affaan-m/ECC, cloudflare/security-audit-skill
- Encoded when/skip rules + big-dev protocol in SKILL.md
- Added `references/companion-tooling.md` and decision `0003`

## Next action

On machines: install-personal + claude-mem (both hosts) + optional `npx skills add … security-audit --global`. Reach for agentd/worktrunk/ECC only when a real big parallel or Claude-harness need appears.

## Blockers / open questions

- None

## Do not redo

- Do not install ECC or agentd into every product repo by default
- Do not replace git `docs/` with ECC memory or agentd SQLite
