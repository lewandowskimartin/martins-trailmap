# Project docs skill

A portable **Agent Skill** that makes Claude Code and Cursor share one git-committed `docs/` workspace for brainstorming, plans, decisions, and session handoffs — and situates that next to [claude-mem](https://github.com/thedotmack/claude-mem) and [worktrunk](https://github.com/max-sixty/worktrunk).

## Verdict (start here)

| Question | Answer |
| --- | --- |
| Should you use a `docs/` folder? | **Yes.** It is the only layer every AI and teammate can see without extra install. |
| Should this *skill* live on GitHub? | **Yes — as your skill pack / dotfiles-style repo** (this project). Optionally also commit a copy into product repos when teammates need the same workflow. |
| Does claude-mem replace `docs/`? | **No.** Mem = automatic local session memory. Docs = intentional, reviewable, portable project memory. |
| Does worktrunk change the layout? | **No.** It makes parallel worktrees easy; keep `last-steps` / active plans branch-local. |

## Research summary

### claude-mem

- Persistent memory plugin/worker: captures tool activity, summarizes, injects context next session.
- Install: `npx claude-mem install` (supports Claude Code, Cursor, and others).
- Data lives under `~/.claude-mem` locally; cloud sync is optional.
- Strength: continuity you did not remember to write down.
- Gap: not automatically shared via your product git repo; another tool/machine may not see it.

### worktrunk

- CLI (`wt`) for git worktrees aimed at parallel AI agents.
- Core loop: `wt switch -c <branch>`, `wt list`, `wt remove`, optional `-x` to launch an agent.
- Strength: isolation so agents do not stomp each other.
- Implication for docs: each branch has its own `docs/` checkout — treat handoffs as branch-scoped; merge durable decisions to the default branch.

### Skill format (Claude + Cursor)

Both understand the [Agent Skills](https://agentskills.io/specification) shape: a folder with `SKILL.md` + YAML `name` / `description`.

| Scope | Claude Code | Cursor |
| --- | --- | --- |
| Personal | `~/.claude/skills/<name>/` | `~/.cursor/skills/` (also reads `~/.claude/skills/`) |
| Project | `.claude/skills/<name>/` | `.cursor/skills/` or `.agents/skills/` (also reads `.claude/skills/`) |

This pack installs personally into both homes via symlink, and can optionally copy into a product repo.

## Architecture (sense check)

```text
┌─────────────────────────────────────────────────────────┐
│  docs/  (git)                                           │
│  intentional · shared · reviewable                      │
│  brainstorm · plans · decisions · last-steps            │
└─────────────────────────────────────────────────────────┘
          ▲ read/write by any agent
          │
┌─────────┴──────────┐     ┌──────────────────────────────┐
│ Claude Code        │     │ Cursor                       │
│ + project-docs     │     │ + project-docs               │
│   skill            │     │   skill                      │
└─────────┬──────────┘     └──────────────┬───────────────┘
          │                               │
          └──────────┬────────────────────┘
                     ▼
        ┌────────────────────────┐
        │ claude-mem (optional)  │
        │ automatic · local      │
        └────────────────────────┘

Parallel work: worktrunk (wt) → one worktree per agent/branch
```

**Lean by design.** Heavier systems (full ADR plugins, multi-skill docflow suites) exist; this pack stays small: four artifact types + a session protocol. Add process only when a repo needs it.

## Quick install

### 1. Personal skill (recommended default)

From this repo:

```bash
chmod +x scripts/*.sh
./scripts/install-personal.sh
```

That symlinks `skills/project-docs` into:

- `~/.claude/skills/project-docs`
- `~/.cursor/skills/project-docs`
- `~/.agents/skills/project-docs`

### 2. Scaffold `docs/` in a product repo

```bash
/path/to/this-repo/scripts/bootstrap-repo.sh /path/to/your-app
# also copy the skill into that repo for teammates:
INSTALL_PROJECT_SKILL=1 /path/to/this-repo/scripts/bootstrap-repo.sh /path/to/your-app
```

### 3. Optional tooling

```bash
npx claude-mem install          # automatic session memory
brew install worktrunk && wt config shell install
```

## Should the skill be on GitHub?

**Yes — this skill pack should be on GitHub** (private is fine). Reasons:

1. **Versioned workflow** — your protocol evolves; git history matters.
2. **Multi-machine** — clone + `install-personal.sh` on each laptop.
3. **Source of truth for the skill**, separate from any one product repo.

**Also commit into a product repo when:**

- Teammates (or CI agents / Cloud Agents) must follow the same docs protocol.
- You want Cloud Agent / Claude cloud sessions to see the skill (personal `~/` skills often do not sync to cloud).

**Do not** rely only on a personal skill if Cloud Agents should obey it — put `.claude/skills/project-docs/` (or `.agents/skills/`) in the product repo.

Suggested setup for most people:

| Artifact | Where |
| --- | --- |
| Skill pack (this repo) | Your GitHub, personal or private |
| `docs/` content | Every product repo |
| Skill copy in product repo | Optional, when sharing / cloud agents matter |
| claude-mem DB | Local (`~/.claude-mem`), not in git |

## Repo layout

```text
skills/project-docs/
  SKILL.md                 # Agent instructions
  references/              # Progressive detail
  assets/templates/        # Bootstrap templates
scripts/
  install-personal.sh
  bootstrap-repo.sh
```

## Defaults chosen (challenge these)

1. Folder name: **`docs/`** not `doc/`.
2. Living handoff: single **`last-steps.md`** (not a growing log).
3. Plans: **`active/` + `done/`** instead of status-only filenames.
4. Decisions: numbered ADRs, supersede instead of rewrite.
5. Agents update last-steps at handoff without asking; mark decisions `accepted` only with user OK unless told to decide.

## Open questions for you

Reply with preferences and we can adjust the skill:

1. **Solo or team?** (Affects whether we always vendor the skill into product repos.)
2. **Folder name** — stick with `docs/`, or do you already use `doc/`, `notes/`, `_docs/`?
3. **How strict?** Free-form markdown vs always use the templates?
4. **Decision gate** — agents may accept decisions alone, or always propose first?
5. **Worktrunk today?** Already installed, planning to, or later?
6. **claude-mem** — installing on Claude only, Cursor too, or undecided?
