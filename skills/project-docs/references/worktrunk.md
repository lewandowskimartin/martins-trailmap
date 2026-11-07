# Worktrunk — when it helps (solo)

[Worktrunk](https://worktrunk.dev/) (`wt`) makes git worktrees easy for **parallel** agents.

## Do you need it?

| Working style | Recommendation |
| --- | --- |
| One agent at a time, one branch | **Skip** — normal `git switch` / PRs are enough |
| Two+ agents or two heavy features at once | **Use it** — avoids stash hell and dirty-tree blocking |
| Cloud Agent + local agent on same repo | Often helpful so each has its own worktree |

You are solo and not using it yet: **do not install until you feel the pain of parallel work.** The skill still works without `wt`.

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
