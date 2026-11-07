# Brainstorm: Where should the skill live?

- **Status:** promoted
- **Created:** 2026-11-07
- **Promoted to:** `docs/decisions/0001-docs-plus-mem-plus-worktrunk.md` + README guidance

## Problem

User asked whether the skill should live on GitHub, and needs it to work for both Claude and Cursor across many repos.

## Options

### Option A — Only personal `~/` skills

- Pros: one install, all local repos
- Cons: Cloud Agents / teammates may not see it

### Option B — Only inside each product repo

- Pros: cloud + team get it
- Cons: copy-paste drift across repos

### Option C — Skill pack repo on GitHub + personal symlinks + optional project copy (chosen)

- Pros: single upstream; easy laptop install; opt-in vendoring per product repo
- Cons: two-step mental model (pack vs product)

## Open questions

- Will Cloud Agents be a primary surface? If yes, vendor into product repos more often.

## Rejected / parked

- Publishing only to a Claude plugin marketplace — parked; keep plain Agent Skills for dual-tool portability first.

## Outcome

Ship as a GitHub skill pack with `install-personal.sh` and optional `INSTALL_PROJECT_SKILL=1` bootstrap.
