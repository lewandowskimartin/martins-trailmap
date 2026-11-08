# Memory layers

## Project docs (git)

- Portable across Claude ↔ Cursor ↔ machines ↔ Cloud Agents
- Intentional and reviewable
- Best for: brainstorms, plans, ADRs, last-steps

## claude-mem (both hosts)

**Policy for this skill owner:** install claude-mem for **Claude Code and Cursor** so both write/read the same local project memory.

```bash
npx claude-mem install
# In the installer, enable both Claude Code and Cursor (and any other hosts you use).
```

- Data: `~/.claude-mem` (optional cloud sync is separate)
- Best for: “what did we try last session?” you never wrote down
- Gap: not a replacement for git-reviewed decisions; Cloud Agents may not see your local DB

## Chat history

Bound to one UI. Promote keepers into docs.

## Tool split (this owner)

| Phase | Prefer | Persist in |
| --- | --- | --- |
| Brainstorm / spec / research | Claude | brainstorm, living plan, decisions |
| Implement / verify / PR | Cursor (+ Cloud) | plan ticks, last-steps, end report, PR |
| Switch tools | either | `last-steps` + living plan (required); mem helps |

## Practical split

| Situation | Prefer |
| --- | --- |
| End of session / switch AI | `last-steps.md` + living plan + mem |
| Choosing DB / auth / public API | `docs/decisions/` (high height → ask) |
| Multi-step feature | living plan in mapped plans root |
| “Did we already try X?” | claude-mem search, then docs |
| Secret / token | Neither |

## Hygiene

- Do not mirror full mem timelines into markdown
- Do not leave the only copy of a medium/high decision in chat or mem
- If docs and mem disagree on intent, trust docs; use mem as a clue; update docs
