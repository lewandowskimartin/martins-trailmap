---
name: project-docs
description: Maintain a git-committed docs/ workspace for brainstorming, plans, decisions, and session handoffs so any agent (Claude Code, Cursor, or others) shares the same project memory. Use when starting work in a repo, resuming after a break, brainstorming, planning, recording a decision, ending a session, switching worktrees with worktrunk, or when the user mentions docs/, last-steps, handoff, ADR, or project memory. Complements claude-mem (automatic local memory) — docs/ is the intentional, portable source of truth.
license: MIT
compatibility: Requires git. Optional: worktrunk (wt), claude-mem. Works in Claude Code and Cursor.
metadata:
  author: project-docs-skill
  version: "1.0"
---

# Project docs

Keep durable project thinking in a committed `docs/` folder. Any AI (or human) that opens the repo can read the same brainstorms, plans, decisions, and last steps.

## Memory layers (do not confuse them)

| Layer | Where | Who sees it | Use for |
| --- | --- | --- | --- |
| **docs/** | Git repo | Everyone with the repo; every agent | Intentional brainstorms, plans, decisions, handoffs |
| **claude-mem** | `~/.claude-mem` (local) | You, on machines where it is installed | Automatic session continuity, search of past tool activity |
| **Tool chat history** | Claude / Cursor UI | That tool only | Throwaway conversation |

Rules:
- Prefer writing durable facts into `docs/`, not into chat.
- Do **not** dump claude-mem observations into `docs/` wholesale.
- Do **not** skip `docs/` because claude-mem exists — mem is local and automatic; docs are shared and deliberate.
- If claude-mem search is available and the user asks “what did we do last time?”, search mem first, then reconcile with `docs/last-steps.md`.

## Layout

```text
docs/
  README.md                 # Index + conventions for humans and agents
  last-steps.md             # Living handoff — always current for this branch
  brainstorm/               # Explorations (dated or named)
  plans/                    # Active and archived implementation plans
    active/                 # One file per in-flight plan
    done/                   # Completed plans (move here, do not delete)
  decisions/                # Architecture / product decisions (ADRs)
```

If `docs/` is missing and this skill is in play, create it with the templates under `assets/templates/` before doing substantial work — or ask once if the user wants a different root name.

Default root is **`docs/`** (not `doc/`). Only use another name if the repo already has an established convention.

## Session protocol

### On starting work in a repo

1. Read `docs/README.md` if present.
2. Read `docs/last-steps.md` if present — this is the resume point.
3. Skim `docs/plans/active/` for anything matching the current task.
4. If a decision is in scope, open the relevant file under `docs/decisions/`.
5. Then start coding. Do not re-brainstorm settled decisions.

### While working

- Update the active plan checklist as tasks complete.
- When a real choice is made (stack, API shape, tradeoff), write or update a decision record — do not bury it only in chat.
- Keep brainstorms in `docs/brainstorm/`; promote survivors into plans or decisions.

### Before ending a session / handing off / switching tasks

Update `docs/last-steps.md` so a cold agent can resume in under two minutes:

- What changed
- What is in progress
- Exact next action
- Blockers / open questions
- Pointers to the active plan and relevant decisions

Commit docs updates with the related code when practical (`docs: …` or include in the feature commit).

## File rules

### `last-steps.md`

- One living file per branch (worktrunk-friendly).
- Overwrite in place; do not append endless history (git already has history).
- Short: aim for one screen.
- Template: `assets/templates/last-steps.md`

### Brainstorms (`docs/brainstorm/`)

- Name: `YYYY-MM-DD-short-slug.md` or `short-slug.md` if dated folders feel heavy.
- Capture options, open questions, rejected ideas.
- Mark status: `open` | `promoted` | `abandoned`.
- When promoted, link to the plan or decision that replaced it.
- Template: `assets/templates/brainstorm.md`

### Plans (`docs/plans/active/`)

- One plan per meaningful unit of work (feature, migration, investigation).
- Name: `short-slug.md`.
- Must include: goal, non-goals, checklist, success criteria, links to decisions.
- Move to `docs/plans/done/` when finished; add completion date and PR/commit ref.
- Template: `assets/templates/plan.md`

### Decisions (`docs/decisions/`)

- Name: `NNNN-short-slug.md` with contiguous zero-padded numbers (`0001-…`).
- One decision per file.
- Status lifecycle: `proposed` → `accepted` → `implemented` | `superseded` | `rejected`.
- Include context, options considered, decision, consequences, and (when useful) a short implementation plan.
- Never rewrite history of an accepted decision — supersede with a new numbered file.
- Template: `assets/templates/decision.md`

## Worktrunk

When [worktrunk](https://worktrunk.dev/) / `wt` is available:

- Treat each worktree/branch as its own working context. `docs/last-steps.md` and active plans travel with the branch.
- Start parallel work with `wt switch -c <branch>` (optionally `-x claude` / agent command).
- Do not edit another worktree’s files “to help” — update docs on the current branch and merge via PR.
- Shared durable decisions should land on the default branch through normal review; feature-branch brainstorms/plans can stay branch-local until merged.
- On `wt remove` / merge cleanup, ensure `last-steps.md` on the surviving branch reflects reality (or clear stale in-progress notes).
- If `wt list` shows multiple active trunks, say which branch’s docs you are using.

Details: [references/worktrunk.md](references/worktrunk.md)

## claude-mem

When [claude-mem](https://github.com/thedotmack/claude-mem) is installed:

- Let it capture session telemetry automatically.
- Use mem search for “what happened in past sessions?”.
- Still write handoffs and decisions to `docs/` so agents without mem (or on another machine) stay aligned.
- Never put secrets into either layer. Prefer redaction; do not paste API keys into docs.

Details: [references/memory-layers.md](references/memory-layers.md)

## Bootstrap (missing docs/)

If the repo has no `docs/` layout and the user wants this workflow:

1. Create the directories above.
2. Copy templates from `assets/templates/` (adapt names).
3. Write a short `docs/README.md` from the template.
4. Seed `last-steps.md` with “Bootstrapped project-docs layout. No prior handoff.”
5. Commit as `docs: bootstrap project docs layout`.

Do not bootstrap unsolicited in a repo that already has a different docs system — adapt to what exists and map brainstorm/plans/decisions/last-steps onto it.

## Anti-patterns

- Novelizing: multi-page essays nobody will re-read.
- Dual sources of truth: plan says one thing, last-steps another.
- Decision spam: logging every tiny choice as an ADR.
- Skipping last-steps because “the PR description is enough”.
- Putting secrets, tokens, or personal data in `docs/`.
- Relying only on claude-mem for team-visible or cross-tool continuity.

## Progressive detail

- Session checklist detail: [references/session-protocol.md](references/session-protocol.md)
- Memory layering: [references/memory-layers.md](references/memory-layers.md)
- Worktrunk patterns: [references/worktrunk.md](references/worktrunk.md)
