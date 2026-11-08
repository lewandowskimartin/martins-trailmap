#!/usr/bin/env bash
# Scaffold or adapt docs/ in the current git repo (or target directory).
# Respects an existing top-level plans/ directory (does not move it).
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
TEMPLATES="$ROOT/skills/project-docs/assets/templates"
TARGET="${1:-.}"

if [[ ! -d "$TEMPLATES" ]]; then
  echo "error: templates not found at $TEMPLATES" >&2
  exit 1
fi

cd "$TARGET"

HAS_TOP_PLANS=0
if [[ -d plans ]]; then
  HAS_TOP_PLANS=1
fi

mkdir -p docs/brainstorm docs/decisions
if [[ "$HAS_TOP_PLANS" -eq 1 ]]; then
  mkdir -p plans/done
  echo "detected: top-level plans/ — leaving it as the plans root"
else
  mkdir -p docs/plans/active docs/plans/done
fi

copy_if_missing() {
  local src="$1" dest="$2"
  if [[ -e "$dest" ]]; then
    echo "skip: $dest exists"
  else
    cp "$src" "$dest"
    echo "created: $dest"
  fi
}

copy_if_missing "$TEMPLATES/last-steps.md" "docs/last-steps.md"

# README with path map
if [[ ! -e docs/README.md ]]; then
  if [[ "$HAS_TOP_PLANS" -eq 1 ]]; then
    cat > docs/README.md <<'EOF'
# Project docs

Shared thinking for humans and AI agents (Claude, Cursor, and others).

| Artifact | Path |
| --- | --- |
| last-steps | `docs/last-steps.md` |
| brainstorm | `docs/brainstorm/` |
| plans | `plans/` (repo root — keep existing) |
| finished plans | `plans/done/` |
| decisions | `docs/decisions/` |

## Rules of thumb

1. Resume from `last-steps.md`.
2. Use templates from the `project-docs` skill for new files.
3. Decision height: low = skip ADR; medium = agent may accept; high = ask first.
4. claude-mem on Claude **and** Cursor complements this; it does not replace it.
5. Keep secrets out of this folder.

Agents: follow the `project-docs` skill.
EOF
  else
    cp "$TEMPLATES/docs-readme.md" docs/README.md
  fi
  echo "created: docs/README.md"
else
  echo "skip: docs/README.md exists"
fi

# Seed last-steps with a bootstrap note if still the stock template header only
if grep -q '^\*\*Branch:\*\*$' docs/last-steps.md 2>/dev/null; then
  branch="$(git rev-parse --abbrev-ref HEAD 2>/dev/null || echo unknown)"
  today="$(date -u +%Y-%m-%d)"
  plans_note="docs/plans/active/"
  [[ "$HAS_TOP_PLANS" -eq 1 ]] && plans_note="plans/"
  cat > docs/last-steps.md <<EOF
# Last steps

> Living handoff for this branch. Overwrite in place. Keep to one screen.

- **Branch:** ${branch}
- **Updated:** ${today}
- **Active plan:** none (${plans_note})
- **Related decisions:** none

## Current state

Bootstrapped project-docs layout. No prior handoff.

## Just done

- Created/adapted docs layout (brainstorm, decisions, last-steps; plans → ${plans_note})

## Next action

Start the next task; update this file before ending the session.

## Blockers / open questions

- None yet

## Do not redo

- None yet
EOF
  echo "seeded: docs/last-steps.md"
fi

# Vendor skill into the repo by default (Cursor Cloud needs repo skills).
# Skip with: SKIP_PROJECT_SKILL=1
SKILL_DEST=".claude/skills/project-docs"
if [[ "${SKIP_PROJECT_SKILL:-}" == "1" ]]; then
  echo "skip: project skill vendoring (SKIP_PROJECT_SKILL=1)"
else
  mkdir -p .claude/skills
  if [[ -e "$SKILL_DEST" ]]; then
    # Refresh copy when bootstrapping from an updated skill pack
    if [[ "${REFRESH_PROJECT_SKILL:-}" == "1" ]]; then
      rm -rf "$SKILL_DEST"
      cp -R "$ROOT/skills/project-docs" "$SKILL_DEST"
      echo "refreshed: $SKILL_DEST"
    else
      echo "skip: $SKILL_DEST exists (REFRESH_PROJECT_SKILL=1 to replace)"
    fi
  else
    cp -R "$ROOT/skills/project-docs" "$SKILL_DEST"
    echo "created: $SKILL_DEST"
  fi
  mkdir -p .agents/skills .cursor/skills
  if [[ ! -e .agents/skills/project-docs ]]; then
    ln -s ../../.claude/skills/project-docs .agents/skills/project-docs
    echo "linked: .agents/skills/project-docs"
  fi
  if [[ ! -e .cursor/skills/project-docs ]]; then
    ln -s ../../.claude/skills/project-docs .cursor/skills/project-docs
    echo "linked: .cursor/skills/project-docs"
  fi
fi

echo
echo "docs ready under $(pwd)"
if [[ "$HAS_TOP_PLANS" -eq 1 ]]; then
  echo "plans root: ./plans/ (unchanged)"
else
  echo "plans root: ./docs/plans/"
fi
echo "Also run: ./scripts/install-personal.sh  # local Claude + Cursor"
echo "Skip repo skill: SKIP_PROJECT_SKILL=1 $0"
echo "Refresh repo skill: REFRESH_PROJECT_SKILL=1 $0"
