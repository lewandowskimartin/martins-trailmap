# Worktrunk — when it helps (solo)

[Worktrunk](https://worktrunk.dev/) (`wt`) makes git worktrees easy for **parallel** agents.

## Do you need it?

| Working style | Recommendation |
| --- | --- |
| One agent at a time, one branch | **Skip** — normal `git switch` / PRs are enough |
| Two+ agents or two heavy features at once | **Use it** — avoids stash hell and dirty-tree blocking |
| Cloud Agent + local agent on same repo | Often helpful so each has its own worktree |

Default for this owner: Claude specs, Cursor codes — often **sequential**, so skip Worktrunk until you run two coding agents at once (or Cloud + local on the same files).

**Do not** let Claude and Cursor edit one dirty checkout in parallel without isolation.

## If you adopt it later

```bash
brew install worktrunk && wt config shell install
# or: cargo install worktrunk && wt config shell install

wt switch --create feature-auth
wt list
wt remove
wt switch -x claude -c feat -- 'prompt…'
```

- `last-steps` and active plans are branch-scoped
- Do not edit sibling worktrees unless asked
- Merge durable decisions to the default branch soon
