# Last steps

> Living handoff for this branch. Overwrite in place. Keep to one screen.

- **Branch:** main
- **Updated:** 2026-11-07
- **Active plan:** none
- **Related decisions:** `0001`, `0002`

## Current state

Skill pack **v1.1** encodes solo defaults: templates on, height-based decisions, layout detection for `docs/` + top-level `plans/`, claude-mem on both hosts, Worktrunk optional.

## Just done

- Updated `skills/project-docs` to v1.1 from owner answers
- Bootstrap respects existing top-level `plans/`
- Recorded `docs/decisions/0002-solo-defaults-v1-1.md`

## Next action

On your machines: `./scripts/install-personal.sh`, then `npx claude-mem install` (enable Claude **and** Cursor). Bootstrap product repos with `./scripts/bootstrap-repo.sh ~/path/to/app`. Skip Worktrunk until you parallelize.

## Blockers / open questions

- None

## Do not redo

- Do not move a working top-level `plans/` without being asked
- Do not install Worktrunk “just because”
