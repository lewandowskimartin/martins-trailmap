# Martin's Trailmap

Lean-startup **Agent Skill** for solo Claude + Cursor: living git docs, height-gated work loop, **PR as the aim**.

- **Brand / repo:** `martin's-trailmap`
- **Skill id (folder + `/` command):** `martins-trailmap`  
  (Agent Skills disallow apostrophes in `name`)

## Defaults (v1.7)

| Topic | Choice |
| --- | --- |
| Profile | Solo lean startup |
| Tools | **Claude** = brainstorm/spec · **Cursor** = implement/PR (Cloud often) |
| Plans | Living files in `docs/plans` (or existing top-level `plans/`); **several OK** (repo + branch) |
| Plan gate | Medium (clear ask) → go · High → one grill round, then wait · Fog stays on the plan under **Not yet specified** |
| Tests | Soft before, **full after** |
| Review | Lightweight **diff review** (no sloppy code) |
| Done | **PR opened** (+ verify/review/security) |
| Skill install | Personal **and** vendored into product repos (Cloud) |
| Worktrunk / agentd / ECC | Optional |
| security-audit | Companion for trust boundaries |
| Memory privacy | Local claude-mem OK for own work; **docs-only** on confidential/NDA; CMEM Pro off; never store secrets in mem/docs |
| Git hygiene | Never commit `.DS_Store` / OS junk; bootstrap seeds `.gitignore` |

## Work loop (short)

Orient → sense-check → research? → plan gate → parallel? → branch → baseline → implement → verify → brief check → **diff review** → security → fixes → **commit/push/PR** → end report

Low/hotfix paths collapse ceremony — see the skill.

## Quick install

```bash
chmod +x scripts/*.sh
./scripts/install-personal.sh
./scripts/bootstrap-repo.sh ~/my-app          # vendors skill for Cursor Cloud
npx claude-mem install                        # Claude AND Cursor
npx skills add https://github.com/cloudflare/security-audit-skill \
  --skill security-audit --global
```

Refresh skill copy in an app after Trailmap updates:

```bash
REFRESH_PROJECT_SKILL=1 ./scripts/bootstrap-repo.sh ~/my-app
```

agentd on Cursor (big DAG epics only): `skills/martins-trailmap/references/agentd-cursor.md`.

## Why soft-before / full-after tests?

Fine for lean startup. Pure TDD on every MMF slows learning; empty tests-after lie. Name the proof early, lock behavior after implement. Bias earlier tests when auth/money/data-loss is involved.

## Decisions

- `0001`–`0007` prior · `0008` fog on the plan, grill only when high or the ask is loose
