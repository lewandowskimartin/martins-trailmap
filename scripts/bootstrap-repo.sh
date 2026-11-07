#!/usr/bin/env bash
# Scaffold docs/ into the current git repo (or target directory).
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
TEMPLATES="$ROOT/skills/project-docs/assets/templates"
TARGET="${1:-.}"

if [[ ! -d "$TEMPLATES" ]]; then
  echo "error: templates not found at $TEMPLATES" >&2
  exit 1
fi

cd "$TARGET"
mkdir -p docs/brainstorm docs/plans/active docs/plans/done docs/decisions

copy_if_missing() {
  local src="$1" dest="$2"
  if [[ -e "$dest" ]]; then
    echo "skip: $dest exists"
  else
    cp "$src" "$dest"
    echo "created: $dest"
  fi
}

copy_if_missing "$TEMPLATES/docs-readme.md" "docs/README.md"
copy_if_missing "$TEMPLATES/last-steps.md" "docs/last-steps.md"

# Seed last-steps with a bootstrap note if still the stock template header only
if grep -q '^\*\*Branch:\*\*$' docs/last-steps.md 2>/dev/null; then
  branch="$(git rev-parse --abbrev-ref HEAD 2>/dev/null || echo unknown)"
  today="$(date -u +%Y-%m-%d)"
  cat > docs/last-steps.md <<EOF
# Last steps

> Living handoff for this branch. Overwrite in place. Keep to one screen.

- **Branch:** ${branch}
- **Updated:** ${today}
- **Active plan:** none
- **Related decisions:** none

## Current state

Bootstrapped \`docs/\` project-docs layout. No prior handoff.

## Just done

- Created \`docs/\` (brainstorm, plans, decisions, last-steps)

## Next action

Start the next task; update this file before ending the session.

## Blockers / open questions

- None yet

## Do not redo

- None yet
EOF
  echo "seeded: docs/last-steps.md"
fi

# Optional: install skill into this repo for teammates
SKILL_DEST=".claude/skills/project-docs"
if [[ "${INSTALL_PROJECT_SKILL:-}" == "1" ]]; then
  mkdir -p .claude/skills
  if [[ -e "$SKILL_DEST" ]]; then
    echo "skip: $SKILL_DEST exists"
  else
    cp -R "$ROOT/skills/project-docs" "$SKILL_DEST"
    # Keep templates/references; fine for project copy
    echo "created: $SKILL_DEST"
    mkdir -p .agents/skills
    if [[ ! -e .agents/skills/project-docs ]]; then
      ln -s ../../.claude/skills/project-docs .agents/skills/project-docs
      echo "linked: .agents/skills/project-docs"
    fi
  fi
fi

echo
echo "docs/ ready under $(pwd)"
echo "Tip: INSTALL_PROJECT_SKILL=1 $0  # also copy the skill into this repo"
