# Project docs skill

Portable **Agent Skill** so Claude Code and Cursor share one git-committed docs workflow — beside [claude-mem](https://github.com/thedotmack/claude-mem) and optional [worktrunk](https://github.com/max-sixty/worktrunk).

## Your locked-in defaults (v1.1)

| Topic | Choice |
| --- | --- |
| Audience | **Solo** — personal skill install; vendor into product repos only for Cloud Agents |
| Layout | Prefer `docs/`; **keep** existing top-level `plans/` when present |
| Templates | **Yes, use templates** for new durable files (better cross-repo agent behavior) |
| Decision gate | By **height**: low skip · medium agent may accept · high ask first |
| Worktrunk | **Optional** — skip until you run parallel agents |
| claude-mem | **Both** Claude Code and Cursor (shared local memory when switching AI) |

## Verdict

| Question | Answer |
| --- | --- |
| `docs/` in every product repo? | **Yes** (adapt if you already have `docs/` + `plans/`) |
| Skill on GitHub? | **Yes** — this pack as your workflow repo |
| Vendor skill into every app repo? | **No** for solo; **yes** when Cloud Agents must see it |
| claude-mem replace docs? | **No** |
| Install Worktrunk now? | **Not required** — adopt when you parallelize |

## Why templates

Same headings across repos → agents find goal / checklist / next action without rediscovering each repo’s note style. Free-form stays OK for tiny scratch inside an existing note; anything meant for handoff or the other AI should use a template.

## Architecture

```text
docs/ (+ optional top-level plans/)     ← intentional, in git
        ▲
Claude Code ──┐
              ├── project-docs skill (personal ~/…/skills)
Cursor ───────┘
              ▼
        claude-mem on BOTH hosts   ← automatic, local ~/.claude-mem

worktrunk: only if 2+ agents in parallel
```

## Quick install

```bash
chmod +x scripts/*.sh
./scripts/install-personal.sh          # ~/.claude + ~/.cursor + ~/.agents
./scripts/bootstrap-repo.sh ~/my-app   # respects existing plans/
npx claude-mem install                 # enable Claude Code AND Cursor
```

Cloud Agent on a product repo:

```bash
INSTALL_PROJECT_SKILL=1 ./scripts/bootstrap-repo.sh ~/my-app
```

Worktrunk later (optional):

```bash
brew install worktrunk && wt config shell install
```

## Should the skill be on GitHub?

**Yes** (private fine): version the workflow, clone on each machine, run `install-personal.sh`.

| Artifact | Where |
| --- | --- |
| This skill pack | Your GitHub |
| `docs/` (+ existing `plans/`) | Each product repo |
| Skill copy in product repo | Only if Cloud Agents need it |
| claude-mem DB | `~/.claude-mem` — not in git |

## Repo layout

```text
skills/project-docs/     # SKILL.md, references/, assets/templates/
scripts/                 # install-personal.sh, bootstrap-repo.sh
docs/                    # dogfood of the workflow
```

## Decisions in this pack

- `docs/decisions/0001-docs-plus-mem-plus-worktrunk.md` — three-layer memory
- `docs/decisions/0002-solo-defaults-v1-1.md` — answers above
