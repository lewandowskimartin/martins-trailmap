#!/usr/bin/env bash
# Install Martin's Trailmap as a personal skill for Claude Code and Cursor.
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
SRC="$ROOT/skills/martins-trailmap"
NAME="martins-trailmap"

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
    # Replace stale project-docs link from earlier versions
    if [[ -L "$dest_parent/project-docs" ]]; then
      rm -f "$dest_parent/project-docs"
      echo "removed: stale $dest_parent/project-docs symlink"
    fi
    if [[ -e "$dest" || -L "$dest" ]]; then
      echo "error: $dest exists (remove or rename it, then re-run)" >&2
      exit 1
    fi
  fi
  ln -s "$SRC" "$dest"
  echo "linked: $dest -> $SRC"
  # Clean old name if present
  if [[ -L "$dest_parent/project-docs" ]]; then
    rm -f "$dest_parent/project-docs"
    echo "removed: stale $dest_parent/project-docs symlink"
  fi
}

link_skill "$HOME/.claude/skills"
link_skill "$HOME/.cursor/skills"
link_skill "$HOME/.agents/skills"

echo
echo "Martin's Trailmap personal install complete."
echo "Invoke /martins-trailmap or let the agent auto-apply from the description."
