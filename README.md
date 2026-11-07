# Project docs skill

Portable **Agent Skill** so Claude Code and Cursor share one git-committed docs workflow — beside [claude-mem](https://github.com/thedotmack/claude-mem) and optional [worktrunk](https://github.com/max-sixty/worktrunk).

## Your locked-in defaults (v1.3)

| Topic | Choice |
| --- | --- |
| Audience | **Solo** — personal skill install; vendor into product repos only for Cloud Agents |
| Layout | Prefer `docs/`; **keep** existing top-level `plans/` when present |
| Templates | **Yes, use templates** for new durable files (better cross-repo agent behavior) |
| Decision gate | By **height**: low skip · medium agent may accept · high ask first |
| Worktrunk | **Optional** — skip until you run parallel agents |
| claude-mem | **Both** Claude Code and Cursor (shared local memory when switching AI) |
| agentd | **Optional** — large DAG / multi-agent epics only |
| ECC | **Optional** Claude harness — do **not** merge into this skill; borrow the engineering loop |
| security-audit | **Yes** as companion skill for sensitive surfaces / pre-ship |
| Work loop | Orient → sense-check → research? → plan → parallel? → branch → baseline → **implement** → verify → brief check → security → fixes → end report |

## Verdict

| Question | Answer |
| --- | --- |
| `docs/` in every product repo? | **Yes** (adapt if you already have `docs/` + `plans/`) |
| Skill on GitHub? | **Yes** — this pack as your workflow repo |
| Vendor skill into every app repo? | **No** for solo; **yes** when Cloud Agents must see it |
| claude-mem replace docs? | **No** |
| Install Worktrunk now? | **Not required** — adopt when you parallelize |
| agentd for every repo? | **No** — only big parallel epics with real task DAGs |
| Install all of ECC into this pack? | **No** — optional Claude plugin; keep `docs/` as truth |
| Cloudflare security-audit? | **Yes** — install globally; run before shipping trust boundaries |

## Companion tooling (summary)

| Tool | Verdict |
| --- | --- |
| [obarker94/agentd](https://github.com/obarker94/agentd) | Worth it for **big** multi-agent DAG work; overkill for linear features. Complements worktrunk (checkouts) + `plans/` (human plan). |
| [affaan-m/ECC](https://github.com/affaan-m/ECC) | Powerful Claude Code harness; **don’t swallow it** into project-docs. Optional install; we only encode the plan→test→review→verify loop. |
| [cloudflare/security-audit-skill](https://github.com/cloudflare/security-audit-skill) | **Add** — best-in-class structured audits with verified findings. Install separately; link reports from docs. |

Details live in `skills/project-docs/references/companion-tooling.md`.

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

# Recommended companion (security)
npx skills add https://github.com/cloudflare/security-audit-skill \
  --skill security-audit --global
```

Cloud Agent on a product repo:

```bash
INSTALL_PROJECT_SKILL=1 ./scripts/bootstrap-repo.sh ~/my-app
```

Later, only if needed:

```bash
brew install worktrunk && wt config shell install   # parallel checkouts
# agentd: build/install MCP when you run a real multi-agent DAG epic
# ECC: /plugin install on Claude Code if you want the full harness
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
- `docs/decisions/0002-solo-defaults-v1-1.md` — solo defaults
- `docs/decisions/0003-companion-tooling.md` — agentd / ECC / security-audit
- `docs/decisions/0004-work-loop.md` — canonical feature work loop
