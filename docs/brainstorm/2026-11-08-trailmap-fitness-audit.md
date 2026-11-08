# Brainstorm: Trailmap fitness — speed, accuracy, safety

- **Status:** open
- **Created:** 2026-11-08
- **Work type:** spike (audit of this skill pack)
- **Promoted to:**

## Problem

Is Martin's Trailmap (v1.5) a good system for **coding speed**, **accuracy**, and **safety** for a solo lean-startup Claude+Cursor workflow?

## Verdict (summary)

| Dimension | Score (1–5) | Fit |
| --- | --- | --- |
| Speed | **4** | Strong for solo MMFs if height collapse is obeyed |
| Accuracy | **4** | Strong brief-check + verify + living plans; weak if agents skip evidence |
| Safety | **3.5 → 4 with discipline** | Good process controls; mem privacy residual risk |

**Overall: good to use** — better than ad-hoc chat coding; not a substitute for judgment on confidential/high-trust work.

## Speed

### Helps
- Low mini-loop + hotfix path avoid 15-step theater
- Medium plan gate = go (no wait)
- Claude spec → Cursor code split reduces context thrash
- Living plans + last-steps cut re-orient time across sessions/tools
- Optional tools (worktrunk/agentd/ECC) stay off by default

### Hurts / risks
- Full loop is long if agents always run all 15 steps on chores
- SKILL.md ~230 lines — token cost every activation (still under typical skill budgets)
- Dual remotes / Cloud vendoring add setup friction (one-time)

### Recommendation
Keep height discipline sacred. If agents feel slow, the bug is usually “full loop on low work,” not the skill design.

## Accuracy

### Helps
- Orient on last-steps + plan before coding
- Soft-before / full-after tests + verify evidence
- Brief check vs success criteria
- Diff review against sloppy “plan-matched” code
- Decisions + numbered ADRs reduce re-litigating settled choices
- PR as definition of done forces a reviewable artifact

### Hurts / risks
- No automated enforcement — agents can skip verify/review
- Several active plans can drift if not updated
- Soft-before tests can become “named but never written”
- Medium decisions may be accepted too casually

### Recommendation
On the first few product features, explicitly require verify commands + diff review in the PR body until habit sticks.

## Safety

### Helps
- Height gate on high decisions (auth/API/billing → wait)
- Lightweight security always; full security-audit when warranted
- Secrets ban in docs/mem/PR
- Confidential policy + `.trailmap-private` marker (v1.5)
- CMEM Pro / cloud sync opt-in only
- Diff review checklist includes secrets/authz/PII

### Hurts / residual risks
- claude-mem system-wide can still capture on “docs-only” repos (skill warns; can’t hard-block)
- Observation compression via Anthropic still leaves the machine for non-confidential work
- “Lightweight security” is checklist-based, not a real audit
- No merge/deploy gate in the skill (human merges)

### Recommendation
For NDA/client work: mark private + don’t use mem-backed sessions. For your own product: current defaults are reasonable.

## Sense-check vs alternatives

| Approach | Speed | Accuracy | Safety |
| --- | --- | --- | --- |
| Chat-only, no docs | High short-term | Low resume/accuracy | Weak |
| Full ECC harness | Medium/low (heavy) | High if followed | Mixed |
| Trailmap v1.5 | High with collapse | High with evidence | Good + privacy caveats |

## Options

### A — Use as-is (chosen for now)
Ship product work with Trailmap; revisit after 2–3 real MMFs.

### B — Slim SKILL.md further
Move more tables to references to speed activation — optional later if token cost hurts.

### C — Add hard fail rules
e.g. “refuse to open PR without verify evidence section” — consider if agents skip gates.

## Outcome

Trailmap is **fit for purpose** for solo lean coding speed/accuracy, with **safety good for own products** and **docs-only required for confidential work**. Next validation: dogfood on one real product feature end-to-end.
