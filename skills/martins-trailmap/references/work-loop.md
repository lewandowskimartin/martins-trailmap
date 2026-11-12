# Work loop

Canonical pipeline for this skill. Scale by **work type** and **height**.

## Full loop

```text
1  Orient         last-steps → living plan(s) → decisions → optional mem
2  Sense-check    type, height, real ask
3  Research       if plan missing/stale or facts uncertain
4  Plan gate      medium: update plan → go | high: show plan → wait
5  Parallelism    default no; else worktrunk / agentd
6  Branch         feature/hotfix branch
7  Baseline       code facts + soft test note (what proves done)
8  Implement      tick living plan
9  Verify         full tests after — keep evidence
10 Brief check    vs success criteria
11 Diff review    no sloppy code (edge cases, naming, error paths, dead code)
12 Security       lightweight always; full audit if warranted
13 Fixes          from 9–12 only
14 Ship           commit → push → open PR
15 End report     plan done + PR link + last-steps
```

## Low mini-loop

```text
orient → sense-check → branch → implement → verify
  → lightweight security → diff review → commit/push/PR → last-steps
```

## Hotfix

```text
orient → blast radius → hotfix branch → implement → verify
  → lightweight security → diff review → commit/push/PR → last-steps
```

Backfill high-height docs after the fire.

## Gates

### Plan

| Height | Behavior |
| --- | --- |
| Low | No formal plan |
| Medium | Update living plan, continue |
| High | Show plan (+ decisions); wait for OK |

### Parallelism — all must be true

1. Separable tasks  
2. Clear file/ownership boundaries  
3. Will actually run 2+ agents  
4. Merge cost acceptable  

Else one agent, one branch. Prefer **not** Claude+Cursor on the same dirty checkout.

### Security

| Surface | Pass |
| --- | --- |
| Low, no trust boundary | Lightweight |
| Medium + user data/HTTP/storage | Lightweight + changed-surface review |
| High / auth / multi-tenant / payments / public API / pre-ship | Full security-audit skill |

### Ship

Code work is not done until a **PR exists** (unless user said commit-only). PR body: goal, plan link, verify evidence, security pass type, follow-ups.

### Diff review checklist

- Diff matches brief (no drive-by refactors unless needed)
- Error/empty paths handled
- No secrets, PII logs, or wide-open authz
- Tests assert behavior (not just smoke)
- Dead code / obviously sloppy structure fixed before PR
- No OS/junk files (`.DS_Store`, `Thumbs.db`, `Desktop.ini`, `._*`, editor swap `*~` / `*.swp`)

### Ship hygiene

- Never `git add -A` blindly on a Mac without checking for `.DS_Store`
- Keep `.DS_Store` / `**/.DS_Store` (and Windows equivalents) in `.gitignore`
- Untrack already-committed junk with `git rm --cached` + keep the ignore

## Tests: soft before, full after

Lean default — **not inferior to pure TDD** when spikes and MMFs dominate.

- Soft before: write down the proof command or a cheap failing stub
- Full after: meaningful coverage of what shipped

If a failure mode is safety-critical (auth, money, data loss), bias earlier toward a failing test before implement.

## Tool split

| Phase | Prefer |
| --- | --- |
| 1–4 (orient → plan) | Claude |
| 5–6 (parallel / branch) | Either |
| 7–14 (baseline → PR) | Cursor |
| 15 (end report) | Cursor (or Claude if spec-only spike) |

## End report

Required for medium/high code work after PR. Template: `assets/templates/end-report.md`.
