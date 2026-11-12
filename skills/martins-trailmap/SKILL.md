---
name: martins-trailmap
description: Martin's Trailmap — lean-startup work loop and living git docs for solo Claude+Cursor. Plans, decisions, last-steps, height gates, PR as done; Claude specs, Cursor codes. Use when starting work, planning, implementing, reviewing, opening a PR, hotfixes, spikes, security checks, or mentions of trailmap, docs/, plans/, last-steps, handoff, ADR, agentd, worktrunk, or claude-mem.
license: MIT
compatibility: Requires git. Recommended: claude-mem on Claude and Cursor; vendor this skill into product repos for Cursor Cloud. Optional: worktrunk, agentd MCP, Cloudflare security-audit, ECC.
metadata:
  author: martin
  display-name: Martin's Trailmap
  version: "1.6"
  audience: solo-lean-startup
---

# Martin's Trailmap

Leave a trail in git so Claude and Cursor share one source of truth. **Profile: solo lean startup** — ship via PRs; keep ceremony proportional to height.

Skill id: `martins-trailmap` (invoke `/martins-trailmap`). Repo/brand: **martin's-trailmap**.

**Tool split (default):**
- **Claude** — brainstorm, feature spec, research, sense-check, high-height decisions
- **Cursor** (local + Cloud) — implement, verify, diff review, commit/push/PR

Hand off through `docs/` (especially the living plan + `last-steps.md`), not chat paste. Install this skill **in product repos** so Cursor Cloud sees it (`bootstrap` vendors by default).

## Memory layers

| Layer | Where | Use for |
| --- | --- | --- |
| **Project docs** | Git (`docs/`, and/or `plans/`) | Living plans, decisions, handoffs, end reports |
| **claude-mem** | `~/.claude-mem` on **both** Claude and Cursor | Automatic session continuity |
| **Chat** | One UI | Throwaway draft |

Prefer docs over chat. Do not dump mem into markdown. Mem complements docs; it does not replace them.

### Memory privacy (confidential work)

claude-mem is **not** a vault. It may store paths, code, prompts, and summaries under `~/.claude-mem`. With `--provider claude`, observation compression can send session-derived content to **Anthropic**. CMEM Pro / cloud sync can send data off-machine — keep it **OFF** unless the user explicitly opts in.

| Project sensitivity | Policy |
| --- | --- |
| Own product / non-sensitive | claude-mem OK (local; cloud sync off) |
| Client NDA, regulated, production secrets, “confidential” | **Trailmap docs only** — do not rely on claude-mem; prefer not to run mem-backed sessions on that repo |
| Unsure | Ask once; default to docs-only handoff |

Agent rules:
- Never put secrets, tokens, private keys, or raw PII into docs, plans, last-steps, end reports, PR bodies, or mem notes.
- Prefer env / secret stores; redact in examples (`REDACTED`, `***`).
- If the user marks a repo confidential (or `docs/README.md` / `CLAUDE.md` / `.trailmap-private` says so): use living plans + last-steps only; do not search or cite claude-mem; remind once that mem may still capture if the plugin is installed system-wide.
- Do not enable or recommend CMEM Pro / cloud sync for confidential work.
- Lightweight security pass includes: “no secrets landed in docs/mem/PR.”

Details: [references/memory-layers.md](references/memory-layers.md).

## Layout — detect first

Canonical:

```text
docs/
  README.md
  last-steps.md
  brainstorm/
  plans/
    active/          # living plans — update often
    done/
  decisions/
```

If top-level `plans/` already exists, **keep it** as the plans root. Map paths in `docs/README.md`. Details: [references/layout-detection.md](references/layout-detection.md).

### Plans model (several OK)

- **Living plans** in the plans root — update frequently; do not spawn a new file for every thought.
- **Several active plans allowed** (repo-level + branch-level workstreams).
- Each plan frontmatter: `Scope: repo | branch`, `Branch:` when branch-scoped.
- Cursor updates the plan during implement; Claude updates it during spec.
- Finish → `done/` (or `Status: done`) + end report + PR link.

## Templates

Use `assets/templates/` for **new** durable files. Leave legacy free-form alone unless heavily editing.

## Height gates

| Height | Examples | Plan gate | Decision accept |
| --- | --- | --- | --- |
| **Low** | Typo, copy, obvious one-file fix | Skip formal plan | N/A |
| **Medium** | Feature slice, refactor, test strategy | **Write/update plan → go** (no wait) | Agent may accept if reversible |
| **High** | Auth, data store, public API, billing, irreversible migration | **Show plan (+ decisions) → wait for OK** | Wait for user |

Unsure → high.

## Work types (lean startup)

Pick a type, then run the matching path. Details: [references/work-types.md](references/work-types.md).

| Type | Aim | Path |
| --- | --- | --- |
| **Feature / MMF** | Smallest shippable customer value | Full loop → **PR** |
| **Bugfix** | Correctness | Full or mini by height → **PR** |
| **Spike** | Learn, not ship | Orient → research → notes in brainstorm/plan; PR only if code must land |
| **Hotfix** | Production broken now | Hotfix path → **PR** fast; backfill docs after |
| **Chore** | Deps, cleanup, tooling | Mini or full by risk → **PR** |

**Definition of done (code work):** verify evidence + brief check + diff review + security pass + **PR opened** (merge may wait on you). Docs-only spikes are done when the learning is in `docs/`.

## Work loop (canonical)

This is the **one** pipeline. Ignore older “big-dev protocol” wording elsewhere — it folds into this.

### Full loop (medium / high feature or bugfix)

1. **Orient** — map → `last-steps` → living plan(s) → decisions → optional mem
2. **Sense-check** — real ask, type, height, constraints
3. **Research** — only if plan missing/stale or facts uncertain (Claude-heavy)
4. **Plan gate** — update living plan; **medium → go**; **high → show and wait**
5. **Parallelism** — default **no**. If yes → worktrunk and/or agentd
6. **Branch** — feature/hotfix branch; worktrunk only if parallel/isolation
7. **Baseline** — current code facts; **soft test note** (what will prove done)
8. **Implement** — Cursor-heavy; tick plan as you go
9. **Verify** — **full tests after** implement; keep command evidence
10. **Brief check** — code vs plan success criteria
11. **Diff review** — fresh pass on the diff: clarity, edge cases, no sloppy code
12. **Security** — lightweight always; full security-audit if trust boundary / high / pre-ship
13. **Fixes** — only gaps from 9–12
14. **Ship** — commit → push → **open PR** (aim of the loop). Never stage junk files (see below).
15. **End report** — plan → done (or update), end report + PR link, refresh `last-steps`

### Do not commit junk / OS noise

Never add or commit machine/OS clutter. Before every `git add` / commit:

- Reject: `.DS_Store`, `._*`, `.AppleDouble`, `Thumbs.db`, `Desktop.ini`, `*~`, `*.swp`, `.vscode/` settings that are personal-only (unless the repo already tracks shared editor config on purpose)
- Ensure root `.gitignore` includes at least:

```gitignore
.DS_Store
**/.DS_Store
Thumbs.db
Desktop.ini
```

- If a junk file is already tracked: `git rm --cached` it and keep the ignore rule
- Diff review / ship checklist includes: “no `.DS_Store` or OS junk in the commit”

### Low mini-loop

`orient → quick sense-check → branch → implement → verify → lightweight security → quick diff review → commit/push/PR → last-steps`

Skip formal plan/end-report unless something surprising was learned (then one short note).

### Hotfix path

`orient → confirm blast radius → hotfix branch → implement → verify → lightweight security → diff review → commit/push/PR → last-steps`  
Backfill plan/decision after the fire if height was high.

### Tests (soft before, full after)

**Not bad for lean startup.** Full TDD on every slice slows learning; meaningless tests-after also fail you.

- **Soft before (baseline):** name the proof (test file/command) or add a minimal failing stub only if cheap
- **Full after (verify):** real tests/assertions that lock the behavior you shipped

### Handoff Claude → Cursor

Claude writes/updates plan + decisions + `last-steps` (“ready for implement”). Cursor orients on those files and runs implement→PR. Do not rely on chat transcript alone.

Mid-loop stop: update `last-steps` with next action + plan pointer + what’s verified.

Details: [references/work-loop.md](references/work-loop.md).

## File rules

### `last-steps.md`

One living handoff per branch; overwrite in place. After merge, refresh on default branch (or clear stale WIP). Template: `assets/templates/last-steps.md`.

### Brainstorms

`docs/brainstorm/YYYY-MM-DD-slug.md` — Claude-heavy. Status: `open` | `promoted` | `abandoned`.

### Plans

Living files in plans root; `Scope: repo | branch`. Template: `assets/templates/plan.md`.

### Decisions

`docs/decisions/NNNN-slug.md`; supersede, don’t rewrite. Template: `assets/templates/decision.md`.

### End reports

Medium/high after PR: `assets/templates/end-report.md` beside done plan (include PR URL).

## claude-mem

Install for **Claude and Cursor** when the work is non-confidential:

```bash
npx claude-mem install --runtime worker --ide claude-code --ide cursor --provider claude
```

Prefer **local provider**, **cloud sync OFF**, no CMEM Pro unless the user wants paid sync. Same local DB when switching tools. Still write intentional facts to git (required for Cloud Agents). On confidential repos, skip mem — Trailmap docs are enough.

## Tooling (optional layers)

Do not install by default. [references/companion-tooling.md](references/companion-tooling.md)

| Tool | When |
| --- | --- |
| worktrunk | Parallel checkouts (e.g. Cursor coding + another agent) |
| agentd | Large DAG + multi-agent claims — Cursor MCP: [references/agentd-cursor.md](references/agentd-cursor.md) |
| security-audit | Trust boundaries / high / pre-ship |
| ECC | Optional Claude harness only — do not replace git docs |

## Bootstrap

Greenfield: create docs tree from templates; seed `last-steps`; commit.

Existing: map, fill gaps, don’t relocate `plans/` unless asked.

**Cursor Cloud:** vendor skill into the product repo by default (`bootstrap-repo.sh` copies unless `SKIP_PROJECT_SKILL=1`). Also keep personal symlinks via `install-personal.sh` for local Claude/Cursor.

## Anti-patterns

- Sloppy code that “matches the plan”
- Claiming done without PR (for code work)
- Full security-audit on every chore
- Skipping verify or diff review on medium/high
- Dual handoff systems (ECC/mem replacing last-steps)
- Stale plans never updated; or a new plan file per idle thought
- Claude and Cursor editing the same checkout without isolation
- Novelizing docs; secrets in docs/mem/PR bodies
- Assuming claude-mem is safe for NDA/client/regulated repos
- Enabling CMEM Pro / cloud sync “for convenience” on confidential work
- Pasting production secrets into chat “so mem remembers them”
- Committing `.DS_Store`, `Thumbs.db`, editor swap files, or other OS/junk noise

## Progressive detail

- [references/work-loop.md](references/work-loop.md)
- [references/work-types.md](references/work-types.md)
- [references/layout-detection.md](references/layout-detection.md)
- [references/session-protocol.md](references/session-protocol.md)
- [references/memory-layers.md](references/memory-layers.md)
- [references/worktrunk.md](references/worktrunk.md)
- [references/companion-tooling.md](references/companion-tooling.md)
- [references/agentd-cursor.md](references/agentd-cursor.md)
