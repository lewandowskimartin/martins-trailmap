---
name: project-docs
description: Maintain git-committed project docs (brainstorms, plans, decisions, last-steps) so Claude Code and Cursor share the same memory. Use when starting or resuming work, brainstorming, planning, recording a decision, ending a session, or when the user mentions docs/, plans/, last-steps, handoff, ADR, or project memory. Adapts to existing docs/ or top-level plans/ layouts. Complements claude-mem (install on both Claude and Cursor) — docs are the intentional portable source of truth. Worktrunk is optional for parallel agents.
license: MIT
compatibility: Requires git. Recommended: claude-mem on Claude Code and Cursor. Optional: worktrunk (wt).
metadata:
  author: project-docs-skill
  version: "1.1"
  audience: solo
---

# Project docs

Keep durable project thinking in git so any AI (Claude Code, Cursor, …) resumes from the same place. **Owner profile: solo developer** — personal skill install is enough; vendor into a product repo only for Cloud Agents.

## Memory layers

| Layer | Where | Use for |
| --- | --- | --- |
| **Project docs** | Git (`docs/`, and/or existing `plans/`) | Intentional brainstorms, plans, decisions, handoffs |
| **claude-mem** | `~/.claude-mem` — install for **both** Claude Code and Cursor | Automatic session continuity across tools on this machine |
| **Chat history** | One product UI | Throwaway draft |

Rules:
- Prefer writing durable facts into project docs, not into chat.
- Do **not** dump claude-mem observations into markdown wholesale.
- Do **not** skip docs because mem exists.
- Install/configure claude-mem for **both** hosts so switching AI keeps one memory DB for the project.
- If mem search is available and the user asks “what did we do last time?”, search mem, then reconcile with `last-steps`.

## Layout — detect first, then normalize lightly

**Canonical target** (new repos / greenfield bootstrap):

```text
docs/
  README.md
  last-steps.md
  brainstorm/
  plans/
    active/
    done/
  decisions/
```

**Existing repos — map, do not fight:**

| If you find… | Treat as… |
| --- | --- |
| `docs/` with mixed notes | Keep `docs/`; add missing pieces (`last-steps.md`, `brainstorm/`, `decisions/`) only as needed |
| Top-level `plans/` (sibling of `docs/`) | **Keep using it** for plans; do not force-move into `docs/plans/` unless the user asks |
| `docs/plans/` | Use that for plans |
| Only `docs/` README / guides | Add `last-steps.md` + `decisions/` beside existing material; leave product docs alone |

Discovery order for plans: `docs/plans/active/` → `docs/plans/` → top-level `plans/` → ask once if ambiguous.

Always prefer the repo’s existing names over renaming for purity. Record the mapped paths in `docs/README.md` (or create a short one) so every agent uses the same map.

Details: [references/layout-detection.md](references/layout-detection.md)

## Templates (recommended)

**Use the templates** under `assets/templates/` for new brainstorm / plan / decision / last-steps files.

Why: same headings across repos → agents skim faster and miss fewer fields. Free-form is fine for tiny scratch notes inside an existing brainstorm; anything you expect another session (or the other AI) to resume from should follow a template.

Do not rewrite old free-form files just to match templates — only new files (or files you are already heavily editing).

## Decision height (acceptance gate)

Not every choice is an ADR. Gate by **height**:

| Height | Examples | Write ADR? | Accept without asking? |
| --- | --- | --- | --- |
| **Low** | Rename local var, pick obvious library default, tweak copy | No | N/A — just do it; mention in last-steps if useful |
| **Medium** | Feature approach, file/module shape, test strategy | Short plan and/or decision as `proposed` → `accepted` | **Yes**, if options were clear and tradeoff is reversible |
| **High** | Data store, auth model, public API, billing, irreversible migration | Full decision record | **No** — propose, wait for user OK, then mark `accepted` |

When unsure of height, treat as **high** and ask once.

## Session protocol

### Start

1. Detect layout (above); read the docs index / README if present.
2. Read `last-steps.md` (usually `docs/last-steps.md`).
3. Skim active plans in the mapped plans location.
4. Open relevant decisions if the task touches one.
5. Optional: claude-mem search when last-steps is thin.
6. Work — do not re-litigate settled decisions.

### During

- Update the active plan checklist as you go.
- Medium/high choices → decision file (height rules).
- Explorations → `brainstorm/`; promote survivors into plans or decisions.

### End / handoff / switch task or AI

Update `last-steps.md` (one screen): current state, just done, exact next action, blockers, pointers to plan/decisions. Commit with related code when practical.

## File rules

### `last-steps.md`

- One living file per branch; overwrite in place (git has history).
- Template: `assets/templates/last-steps.md`

### Brainstorms

- Prefer `docs/brainstorm/YYYY-MM-DD-short-slug.md`
- Status: `open` | `promoted` | `abandoned`
- Template: `assets/templates/brainstorm.md`

### Plans

- One plan per meaningful unit of work; name `short-slug.md`
- Include: goal, non-goals, checklist, success criteria, decision links
- Finish → move to `done/` (under whichever plans root the repo uses)
- Template: `assets/templates/plan.md`

### Decisions

- `docs/decisions/NNNN-short-slug.md` (contiguous zero-padded numbers)
- One decision per file; status: `proposed` → `accepted` → `implemented` | `superseded` | `rejected`
- Include **Height:** low | medium | high in the front matter list
- Never rewrite an accepted decision — supersede with a new number
- Template: `assets/templates/decision.md`

## claude-mem (both tools)

Target setup: **Claude Code and Cursor both wired to claude-mem** via `npx claude-mem install` (pick both hosts in the installer). Same local DB → better migration when switching AI.

- Let mem capture automatically; search it for past-session questions.
- Still write handoffs/decisions to git for portability and Cloud Agents.
- No secrets in mem notes or docs.

Details: [references/memory-layers.md](references/memory-layers.md)

## Worktrunk (optional — not required for solo sequential work)

Skip Worktrunk if you usually run **one agent at a time** on one branch. Plain git branches are enough.

**Adopt Worktrunk when** you want two+ agents in parallel (e.g. Cursor on feature A, Claude on feature B) without stash/checkout collisions. Then:

- `wt switch -c <branch>` per agent; `last-steps` stays branch-local
- Do not edit sibling worktrees unless asked
- Details: [references/worktrunk.md](references/worktrunk.md)

## Bootstrap

Greenfield / empty: create the canonical `docs/` tree from templates; seed `last-steps.md`; commit `docs: bootstrap project docs layout`.

Existing layout: map paths, fill gaps only, document the map in `docs/README.md`. Do not relocate top-level `plans/` unless asked.

Solo default: keep the skill personal (`install-personal.sh`). Set `INSTALL_PROJECT_SKILL=1` only when Cloud Agents must load the skill from the repo.

## Anti-patterns

- Novelizing; dual sources of truth; ADR spam for low-height choices
- Skipping last-steps; putting secrets in docs or mem
- Relying only on claude-mem for cross-tool continuity without git docs
- Renaming a working `plans/` tree “for consistency” without being asked
- Installing Worktrunk “because the skill mentions it” when you never parallelize

## Progressive detail

- [references/layout-detection.md](references/layout-detection.md)
- [references/session-protocol.md](references/session-protocol.md)
- [references/memory-layers.md](references/memory-layers.md)
- [references/worktrunk.md](references/worktrunk.md)
