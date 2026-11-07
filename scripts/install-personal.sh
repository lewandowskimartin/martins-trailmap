#!/usr/bin/env bash
# Install project-docs as a personal skill for Claude Code and Cursor.
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
SRC="$ROOT/skills/project-docs"
NAME="project-docs"

if [[ ! -f "$SRC/SKILL.md" ]]; then
  echo "error: missing $SRC/SKILL.md" >&2
  exit 1
fi

link_skill() {
  local dest_parent="$1"
  mkdir -p "$dest_parent"
  local dest="$dest_parent/$NAME"
  if [[ -e "$dest" || -L "$dest" ]]; then
    if [[ -L "$dest" && "$(readlink "$dest")" == "$SRC" ]]; then
      echo "ok: $dest already linked"
      return
    fi
    echo "error: $dest exists (remove or rename it, then re-run)" >&2
    exit 1
  fi
  ln -s "$SRC" "$dest"
  echo "linked: $dest -> $SRC"
}

link_skill "$HOME/.claude/skills"
link_skill "$HOME/.cursor/skills"

# Vendor-neutral personal path (Cursor / Codex-friendly)
link_skill "$HOME/.agents/skills"

echo
echo "Personal install complete."
echo "Claude Code and Cursor both load ~/.claude/skills/; Cursor also loads ~/.cursor/skills/."
echo "Open a repo and invoke /project-docs, or let the agent auto-apply from the description."
