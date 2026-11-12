# Plan: Fog on the plan, one grill round

- **Status:** active
- **Scope:** repo
- **Branch:** cursor/fog-and-grill-4696
- **Created:** 2026-11-12
- **Updated:** 2026-11-12
- **Completed:**
- **PR:**
- **Decisions:** `docs/decisions/0008-fog-and-grill.md`
- **Work type:** feature
- **Height:** medium

## Goal

Teach Trailmap v1.7 two rules inside the existing plan gate: record fog under **Not yet specified**, and run one grill round only when height is high or the ask is too loose to classify. Done when that behavior is in the skill, the plan template, and the gate references, and a PR is open.

## Non-goals

- Splitting the skill
- Issue-tracker decision tickets
- A grill round on every medium slice
- Background research agents

## Not yet specified

- None

## Checklist

- [x] Decision `0008`
- [x] `SKILL.md` fog + grill, version 1.7
- [x] Work-loop and session-protocol gates
- [x] Plan template **Not yet specified**
- [x] README and docs README plan-gate lines
- [ ] PR opened

## Success criteria

- [x] Fog is defined as an unknown you cannot yet state as a precise question, stored on the living plan
- [x] Grill is one round, with a recommended answer, only for high height or a loose ask
- [x] Medium work with a clear ask still updates the plan and goes
- [ ] PR opened

## Verify plan

Docs-only. Proof is a read-through that the skill, work-loop, session protocol, plan template, and READMEs agree.

- Re-read those files after the edit

## Security note

- **Expected pass:** lightweight
- **Why:** markdown only; no trust boundary, secrets, or runtime

## Notes

Claude/Cursor handoff is this plan plus `0008`. One skill stays the trail.
