# Work loop (canonical)

Default pipeline for feature / epic work. Scale depth by **height** (low / medium / high) — do not run the heavy path on a one-line fix.

## Pipeline

```text
1. Orient          last-steps → plan (if any) → decisions → optional mem search
2. Sense-check     scope, height, constraints, “is this the real ask?”
3. Research        only if plan missing/stale or facts uncertain
4. Plan gate       write/update plan; high-height → ask before accepting
5. Parallelism     would multiple workers help? (else stay single-threaded)
6. Branch setup    branch; worktrunk/worktree only if parallel or isolation needed
7. Baseline        fact-check current code + failing/absent proof of the gap
8. Implement       do the work (update plan checklist as you go)
9. Verify          tests / commands — evidence the work is done
10. Brief check    code vs plan/success criteria — executed to brief?
11. Security       lightweight always; full security-audit when warranted
12. Fixes          only for real gaps from 9–11
13. End report     docs: plan→done, last-steps, short report
```

## Recommendations vs the raw checklist

| Your step | Keep? | Change |
| --- | --- | --- |
| Check the plan | Yes | Also read `last-steps` + decisions first (orient) |
| Sense-check | Yes | Do **before** heavy research; re-check after research if scope shifted |
| Research / facts | Yes | **Conditional** — skip when plan is fresh and facts are clear |
| Spread to workers? | Yes | Decide **before** branch setup; default **no** for linear solo work |
| Branch / worktrunk | Yes | Plain branch by default; worktrunk only for parallel/isolation |
| Check the code | Yes | Split into **baseline (pre)** and **verify (post)** — your list skipped **Implement** |
| Cross-check vs plan | Yes | Against success criteria / checklist, not vibes |
| Full security-audit | Conditional | Always do a **lightweight** security pass; full Cloudflare skill only for trust-boundary / high-height / pre-ship |
| Fixes | Yes | Bound to findings from verify / brief / security |
| End report | Yes | Land in **git docs**, not only chat |

## Critical fix: insert Implement

Without an explicit implement step, “check the code / cross-check the plan” reads as audit-only. Order is: baseline → **implement** → verify → brief check → security → fixes → report.

## Security gating

| Surface | What to run |
| --- | --- |
| Low height, no trust boundary | Lightweight: secrets, authz guesses, unsafe defaults, logging PII |
| Medium with user data / HTTP / storage | Lightweight + targeted review of changed surfaces |
| High / auth / multi-tenant / payments / public API / pre-ship | Full **security-audit** skill; link report from end report |

Do not burn a full multi-phase audit on every chore.

## Parallelism gating

Spread work only if **all** are true:

1. Tasks are separable (weak coupling)
2. Clear ownership / file boundaries (or agentd DAG)
3. You will actually run 2+ agents
4. Merge/integration cost is acceptable

Otherwise one worker + one branch.

## End report (required for medium/high)

Use `assets/templates/end-report.md`. Store under `docs/plans/done/` next to the finished plan, or as a short section appended when moving the plan. Also refresh `last-steps.md` (even if “idle — ready for next task”).

Minimum contents:

- Goal / plan link
- What shipped (PR/commits)
- Verify evidence (commands + results)
- Brief check: criteria met / gaps
- Security: lightweight or full audit + outcome
- Follow-ups / non-goals left undone
