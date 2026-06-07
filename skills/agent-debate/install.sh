#!/usr/bin/env bash
# Install the agent-debate skill for Claude Code and Codex on this machine by
# symlinking this repo into their skill directories. Safe to re-run.
set -euo pipefail

SRC="$(cd "$(dirname "$0")" && pwd)"
chmod +x "$SRC/debate.sh"

for base in "$HOME/.claude/skills" "$HOME/.codex/skills" "$HOME/.agents/skills"; do
  target="$base/agent-debate"
  [ "$target" = "$SRC" ] && continue        # don't link the repo to itself
  mkdir -p "$base"
  ln -sfn "$SRC" "$target"
  echo "linked $target -> $SRC"
done

echo
echo "agent-debate installed. Start a debate by telling Claude Code and Codex:"
echo '  "Use the agent-debate skill. You are claude, peer is codex. Topic: <slug>. Start."'
