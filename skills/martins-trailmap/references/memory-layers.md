# Memory layers

## Project docs (git)

- Portable across Claude ↔ Cursor ↔ machines ↔ Cloud Agents
- Intentional and reviewable
- Best for: brainstorms, plans, ADRs, last-steps
- **Use this for confidential handoffs** — you control what is committed

## claude-mem (both hosts)

**Default for this owner (non-confidential work):** Claude Code + Cursor, local provider, cloud sync off.

```bash
npx claude-mem install --runtime worker --ide claude-code --ide cursor --provider claude
```

| Fact | Implication |
| --- | --- |
| DB under `~/.claude-mem` | Laptop disk / backups can hold project context |
| `--provider claude` | Observation compression may send session-derived content to Anthropic |
| CMEM Pro / cloud sync | Off-machine copy — **opt-in only**; avoid for confidential work |
| Auto-capture | May record paths, diffs, prompts you did not mean to “file” |

Best for: “what did we try last session?” on your own product work.  
Not for: sole source of truth; NDA/client/regulated projects; storing secrets.

## Confidential / private projects

Treat as confidential when any apply: client NDA, regulated data, production credentials in-repo, user says “private/confidential”, or a marker file exists:

- `docs/.trailmap-private`
- or a line in `docs/README.md`: `Trailmap privacy: confidential`
- or `CLAUDE.md` / `AGENTS.md`: `confidential: true`

**Then:**

1. Prefer **docs-only** continuity (living plan + `last-steps`).
2. Do not search/cite claude-mem; do not tell the user mem is a safe archive.
3. Remind once: system-wide claude-mem may still capture if installed — for hard isolation, disable mem for that session/host or work without the plugin.
4. Never recommend turning on CMEM Pro for that repo.
5. Scrub secrets from any doc you write.

## Chat history

Bound to one UI. Promote keepers into docs. Never use chat as the only copy of a medium/high decision.

## Tool split (this owner)

| Phase | Prefer | Persist in |
| --- | --- | --- |
| Brainstorm / spec / research | Claude | brainstorm, living plan, decisions |
| Implement / verify / PR | Cursor (+ Cloud) | plan ticks, last-steps, end report, PR |
| Switch tools | either | `last-steps` + living plan (required); mem only if non-confidential |

## Practical split

| Situation | Prefer |
| --- | --- |
| End of session / switch AI | `last-steps.md` + living plan (+ mem if allowed) |
| Choosing DB / auth / public API | `docs/decisions/` (high height → ask) |
| Multi-step feature | living plan in mapped plans root |
| “Did we already try X?” | docs first; mem search only if non-confidential |
| Secret / token / NDA material | Neither mem nor docs — secret store / redact |

## Hygiene

- Do not mirror full mem timelines into markdown
- Do not leave the only copy of a medium/high decision in chat or mem
- If docs and mem disagree on intent, trust docs; use mem as a clue; update docs
- Redact secrets everywhere; enable claude-mem auto-redaction if available and you use mem
- Keep cloud sync OFF unless the user explicitly wants CMEM Pro
