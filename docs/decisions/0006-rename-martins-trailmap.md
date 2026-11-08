# 0006. Rename to Martin's Trailmap

- **Status:** accepted
- **Height:** low
- **Date:** 2026-11-08
- **Supersedes:**
- **Superseded by:**

## Context

The skill needed a durable brand/repo name. Owner chose **martin's-trailmap**.

## Decision

- **Display / repo:** Martin's Trailmap / `martin's-trailmap` (or GitHub `martins-trailmap` if apostrophe is awkward)
- **Skill id / folder / slash command:** `martins-trailmap` (Agent Skills `name` cannot include apostrophes)
- Former working name `project-docs` is retired

## Consequences

- Re-run `install-personal.sh` and `REFRESH_PROJECT_SKILL=1` bootstrap on product repos
- Invoke `/martins-trailmap` instead of `/project-docs`
