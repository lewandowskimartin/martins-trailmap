# Work types — lean startup

Tune ceremony to the job. Prefer the **smallest** path that still produces a trustworthy PR (or a documented learning).

## Feature / MMF

Smallest slice you’d tell a customer about.

- Height usually medium (high if trust boundary)
- Full work loop; living plan updated often
- Done = PR opened with verify + review + security

## Bugfix

Restore correct behavior.

- Low → mini-loop  
- Medium/high → full loop  
- Reproduce in baseline when possible; regression test in verify

## Spike

Learn cheaply; shipping code is optional.

- Claude-heavy research/brainstorm
- Capture outcome in `brainstorm/` or a short plan note
- PR only if exploratory code must stay
- Time-box; promote to feature plan if build is justified

## Hotfix

Production broken or severe regression for live users. “Urgent feature” is **not** a hotfix.

- Hotfix path; PR ASAP
- Lightweight security still required
- Backfill plan/decision after if high-height cause

## Chore

Deps, lint, dead code, tooling.

- Mini-loop if low risk
- Full loop if build/release/security tooling

## Choosing quickly

```text
Production on fire?     → hotfix
Only need to learn?     → spike
Customer-visible slice? → feature
Wrong behavior?         → bugfix
Else                    → chore
```
