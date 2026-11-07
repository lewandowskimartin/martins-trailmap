---
name: project-docs
description: Maintain git-committed project docs (brainstorms, plans, decisions, last-steps) so Claude Code and Cursor share the same memory. Use when starting or resuming work, running the feature work loop (orient, sense-check, research, plan, branch, implement, verify, brief-check, security, end report), brainstorming, planning, recording a decision, ending a session, big multi-agent epics, security audits, or when the user mentions docs/, plans/, last-steps, handoff, ADR, agentd, ECC, or project memory. Adapts to existing docs/ or top-level plans/ layouts. Complements claude-mem; optional companions: worktrunk, agentd, Cloudflare security-audit, ECC.
license: MIT
compatibility: Requires git. Recommended: claude-mem on Claude Code and Cursor. Optional: worktrunk, agentd MCP, Cloudflare security-audit skill, ECC plugin.
metadata:
  author: project-docs-skill
  version: "1.3"
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

## Work loop (default for feature / epic work)

Follow this order. Scale depth by height — low work may collapse steps; do not skip **verify** or **last-steps** on medium/high.

1. **Orient** — layout map → `last-steps` → active plan (if any) → relevant decisions → optional claude-mem search.
2. **Sense-check** — real ask, scope, height, constraints, risks. Stop or ask if the ask is confused.
3. **Research / facts** — only if plan missing/stale or facts uncertain. Prefer primary sources over guesses.
4. **Plan gate** — write/update plan from template; high-height decisions → propose and wait.
5. **Parallelism check** — would 2+ workers help? Default **no**. If yes → agentd and/or worktrunk; else one agent.
6. **Branch setup** — feature branch; worktrunk/worktree only when parallel or isolation is needed.
7. **Baseline** — fact-check current code; note failing/absent tests that prove the gap (before changing things).
8. **Implement** — do the work; tick plan checklist as you go. *(Do not jump from branch setup straight to “audit the code”.)*
9. **Verify** — run tests/commands; keep evidence the work is done (fact-based, not “looks fine”).
10. **Brief check** — cross-check code vs plan success criteria. Call out gaps explicitly.
11. **Security** — lightweight pass always (secrets, authz, PII logs, unsafe defaults). Full **security-audit** skill when trust boundaries / high height / pre-ship.
12. **Fixes** — only for real gaps from verify / brief / security.
13. **End report** — move plan to `done/` (or mark done), write short end report, refresh `last-steps`.

Details, gating tables, and rationale: [references/work-loop.md](references/work-loop.md). End report template: `assets/templates/end-report.md`.

### Handoff mid-loop

If stopping before the end report: update `last-steps.md` with exact next step, plan pointer, and what’s already verified. Commit docs with related code when practical.

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

## Companion tooling (big work)

Do **not** install everything by default. Layer tools only when the work shape needs them. Full analysis: [references/companion-tooling.md](references/companion-tooling.md)

| Tool | Worth it when… | Skip when… | How it fits `docs/` |
| --- | --- | --- | --- |
| **[agentd](https://github.com/obarker94/agentd)** (MCP task DAG) | Large epic with many dependent tasks and true parallel agents claiming work | Single-threaded feature; markdown plan is enough | Keep human-readable plan in `plans/`; agentd holds runtime claim/state. Mirror epic status into `last-steps.md` |
| **[worktrunk](https://worktrunk.dev/)** | Parallel agents need isolated checkouts | One agent / one branch | Branch-local `last-steps` / plans |
| **[security-audit](https://github.com/cloudflare/security-audit-skill)** | Shipping auth, payments, multi-tenant, public APIs, or any high-height security surface | Tiny internal scripts with no trust boundary | Run audit → link report path + confirmed finding IDs from `last-steps` or a decision; do not paste full findings dumps into git unless asked |
| **[ECC](https://github.com/affaan-m/ECC)** | You want a full Claude Code engineering harness (plan→test→review agents) | You want a lean Cursor+Claude docs workflow | **Optional install, not merged into this skill.** If installed, still treat git `docs/` as source of truth; do not let ECC memory replace `last-steps` / decisions |

### Big-dev protocol (when an epic is medium/high height)

1. Write/refresh a **plan** (template) with checklist + success criteria.
2. Split only if tasks are truly parallelizable → optional **agentd** DAG + **worktrunk** per worker.
3. Implement with normal session protocol (`last-steps` updates).
4. Before merge/ship of sensitive surfaces → invoke **security-audit** (Cloudflare skill).
5. Record high-height outcomes as **decisions**; update `last-steps`.

Borrowed from ECC without requiring ECC: for big work prefer **plan → test → implement → review → verify → remember (docs/last-steps + decisions)**. Do not install 300+ ECC skills just to get that loop.

### agentd specifics

- MCP server: projects, tasks with dependencies, claim/complete, parallel coordination ([obarker94/agentd](https://github.com/obarker94/agentd)).
- Worth it on **big** multi-track work where a markdown checklist cannot express blocking edges and multiple agents need a claim mutex.
- Not worth it for ordinary features — adds daemon/MCP surface area for little gain over `plans/active/*.md`.
- If used: create project from the plan; task titles/prompts should point at plan section + relevant decisions; on complete, tick the plan checklist and refresh `last-steps`.

### security-audit specifics

- Install separately (global): `npx skills add https://github.com/cloudflare/security-audit-skill --skill security-audit --global`
- Trigger phrases: “security audit”, “find vulnerabilities”, “pen-test this”.
- Prefer output outside the repo (skill default) or an ignored path; summarize confirmed items into a decision or plan note with links.
- Defense-in-depth gaps ≠ confirmed vulns — respect the skill’s verdicts (`confirmed` / `needs_validation` / `rejected`).

### ECC specifics

- Large Claude-first plugin (agents + skills + hooks). Cursor support is adapter/limited vs Claude Code.
- **Do not** vendor ECC into this skill pack or auto-bootstrap it into product repos.
- If the user already runs ECC: coexist — git docs win for intentional memory; avoid duplicate handoff systems.

## Bootstrap

Greenfield / empty: create the canonical `docs/` tree from templates; seed `last-steps.md`; commit `docs: bootstrap project docs layout`.

Existing layout: map paths, fill gaps only, document the map in `docs/README.md`. Do not relocate top-level `plans/` unless asked.

Solo default: keep the skill personal (`install-personal.sh`). Set `INSTALL_PROJECT_SKILL=1` only when Cloud Agents must load the skill from the repo.

## Anti-patterns

- Novelizing; dual sources of truth; ADR spam for low-height choices
- Skipping last-steps; putting secrets in docs or mem
- Relying only on claude-mem for cross-tool continuity without git docs
- Renaming a working `plans/` tree “for consistency” without being asked
- Installing Worktrunk / agentd / ECC “because the skill mentions them” when the work is a single linear feature
- Replacing git decisions/last-steps with ECC or agentd state alone
- Pasting full security-audit `findings.json` into the product repo by default
- Running full security-audit on every low-height chore
- Skipping **Implement** and treating the loop as audit-only
- Claiming “done” without verify evidence or brief check

## Progressive detail

- [references/work-loop.md](references/work-loop.md)
- [references/layout-detection.md](references/layout-detection.md)
- [references/session-protocol.md](references/session-protocol.md)
- [references/memory-layers.md](references/memory-layers.md)
- [references/worktrunk.md](references/worktrunk.md)
- [references/companion-tooling.md](references/companion-tooling.md)
