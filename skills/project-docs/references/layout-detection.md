# Layout detection

Solo repos often already have something. Prefer adaptation over relocation.

## Probe (in order)

1. `docs/README.md`, `docs/last-steps.md`
2. Plans roots (first hit wins for *writes* unless user overrides):
   - `docs/plans/active/`
   - `docs/plans/`
   - `plans/` (repo root)
   - `plans/active/`
3. Decisions: `docs/decisions/`, else `decisions/`, else `docs/adr/`, else `adr/`
4. Brainstorms: `docs/brainstorm/`, else `docs/notes/`, else create `docs/brainstorm/`

## Mixed layout example

```text
docs/           # guides, maybe decisions later
plans/          # already used for implementation plans
```

Agent map:

| Artifact | Path |
| --- | --- |
| last-steps | `docs/last-steps.md` (create if missing) |
| plans | `plans/` (keep; optionally add `plans/done/` later) |
| decisions | `docs/decisions/` |
| brainstorm | `docs/brainstorm/` |

Write that table into `docs/README.md` so Claude and Cursor stay aligned.

## Migration

Only move `plans/` → `docs/plans/` when the user explicitly wants one tree. Until then, dual roots are fine if the README map is clear.

## Active vs done

If the plans root has no `active/` / `done/`:

- New plans: put in the plans root (or create `active/` if the user wants the canonical shape)
- Finished plans: prefer a `done/` subfolder; if that feels heavy, prefix `done-` or add a `Status: done` line and leave in place
