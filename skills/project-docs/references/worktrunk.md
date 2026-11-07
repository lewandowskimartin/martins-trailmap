# Worktrunk + project docs

[Worktrunk](https://worktrunk.dev/) (`wt`) makes git worktrees as easy as branches so you can run parallel agents without colliding.

## Core commands

```bash
wt config shell install          # once: enable cd-from-subprocess
wt switch --create feature-auth  # new branch + worktree + cd
wt switch feature-auth           # jump to existing worktree
wt list                          # status across trunks
wt remove                        # clean up current (or named) worktree
wt switch -x claude -c feat -- 'prompt…'   # create + launch agent
```

Install: `brew install worktrunk` or `cargo install worktrunk`, then `wt config shell install`.

## How docs behave across worktrees

Each worktree is a separate checkout of a branch. `docs/` is **branch-scoped**:

| Artifact | Recommendation |
| --- | --- |
| `last-steps.md` | Per-branch living handoff |
| `plans/active/*` | Usually branch-local until merged |
| `brainstorm/*` | Branch-local unless broadly useful |
| `decisions/*` | Aim to merge accepted decisions to the default branch soon |

## Agent rules

1. Announce which branch/worktree you are in before editing docs.
2. Never `cd` into a sibling worktree to “fix” its files unless the user asked.
3. After merge / `wt remove`, refresh `last-steps.md` on the branch you land on.
4. Parallel agents = parallel plans. Prefer distinct plan filenames (`auth-middleware.md` vs `billing-webhooks.md`).

## Hooks (optional)

Use Worktrunk hooks (`pre-start`, `post-start`, etc.) for install/build — not for inventing a second docs system. Docs stay plain markdown in git.
