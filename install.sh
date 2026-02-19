#!/bin/bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
CLAUDE_DIR="${HOME}/.claude"

echo "Installing agent-team-framework..."

# Install commands
mkdir -p "${CLAUDE_DIR}/commands"
for cmd in "${SCRIPT_DIR}/commands/"*.md; do
    name="$(basename "$cmd")"
    ln -sf "$cmd" "${CLAUDE_DIR}/commands/${name}"
    echo "  Linked command: ${name%.md}"
done

# Install skills
for skill_dir in "${SCRIPT_DIR}/skills/"*/; do
    skill_name="$(basename "$skill_dir")"
    mkdir -p "${CLAUDE_DIR}/skills/${skill_name}"
    ln -sf "${skill_dir}SKILL.md" "${CLAUDE_DIR}/skills/${skill_name}/SKILL.md"
    echo "  Linked skill: ${skill_name}"
done

# Install agents
mkdir -p "${CLAUDE_DIR}/agents"
for agent in "${SCRIPT_DIR}/agents/"*.md; do
    name="$(basename "$agent")"
    ln -sf "$agent" "${CLAUDE_DIR}/agents/${name}"
    echo "  Linked agent: ${name%.md}"
done

echo ""
echo "Done! Agent Team Framework is ready."
echo ""
echo "Usage:"
echo "  /team <project description>        — Create and launch a team"
echo "  /team-design <project description>  — Design a custom team"
echo ""
echo "Optional: Install claude-oracle for cross-model verification:"
echo "  https://github.com/wanbok/claude-oracle"
