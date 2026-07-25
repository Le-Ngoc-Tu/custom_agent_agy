#!/usr/bin/env bash
# Custom Agent AGY - Automated Global Setup Script for Linux/macOS (Bash)
# Installs all 8 custom agents into ~/.gemini/config/agents/ for Antigravity CLI

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_DIR="$(dirname "$SCRIPT_DIR")"
GLOBAL_AGENTS_DIR="$HOME/.gemini/config/agents"

AGENTS=(
  "ba-requirements-specialist"
  "api-db-architect"
  "qc-verification-specialist"
  "codebase-researcher"
  "dev-security-implementer"
  "logging-observability-specialist"
  "docs-readme-specialist"
  "devops-git-specialist"
)

echo "=================================================="
echo " Custom Agent AGY — Automated Global Installation "
echo "=================================================="
echo "Target Directory: $GLOBAL_AGENTS_DIR"
echo ""

for agent in "${AGENTS[@]}"; do
  src_file="$REPO_DIR/$agent.md"
  if [ ! -f "$src_file" ]; then
    echo "[ERROR] Missing source file: $src_file"
    continue
  fi

  target_dir="$GLOBAL_AGENTS_DIR/$agent"
  mkdir -p "$target_dir"
  cp "$src_file" "$target_dir/agent.md"
  echo "[OK] Installed $agent -> $target_dir/agent.md"
done

echo ""
echo "[SUCCESS] All 8 custom agents installed globally!"
echo "Launch Antigravity CLI and type '/agents' to view and switch between custom agents."
