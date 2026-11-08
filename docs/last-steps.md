# Last steps

> Living handoff for this branch. Overwrite in place. Keep to one screen.

- **Branch:** main
- **Updated:** 2026-11-08
- **Active plan:** none
- **Related decisions:** `0001`–`0005`

## Current state

Skill pack **v1.4** — lean startup: PR as done, Claude/Cursor split, living multi-plans, soft-before/full-after tests, diff review, hotfix/mini paths, skill vendored by default for Cursor Cloud.

## Just done

- Applied audit answers into v1.4
- Rewrote work-loop for instruction quality; added work-types + agentd-cursor
- Bootstrap vendors skill unless `SKIP_PROJECT_SKILL=1`

## Next action

On machines: `install-personal.sh` + `bootstrap-repo.sh` on product apps + claude-mem both hosts. Use Claude for specs, Cursor Cloud/local for implement→PR.

## Blockers / open questions

- None

## Do not redo

- Do not skip diff review or PR on code work
- Do not treat ECC/mem as replacing living plans / last-steps
