#!/bin/bash
set -euo pipefail

CLAUDE_DIR="${HOME}/.claude"

echo "Uninstalling agent-team-framework..."

# Remove commands
for cmd in up.md design.md; do
    target="${CLAUDE_DIR}/commands/${cmd}"
    if [ -L "$target" ]; then
        rm "$target"
        echo "  Removed command: ${cmd%.md}"
    fi
done

# Remove skills
for skill in workflow; do
    target="${CLAUDE_DIR}/skills/${skill}"
    if [ -L "${target}/SKILL.md" ]; then
        rm "${target}/SKILL.md"
        rmdir "${target}" 2>/dev/null || true
        echo "  Removed skill: ${skill}"
    fi
done

# Remove agents
for agent in reviewer.md; do
    target="${CLAUDE_DIR}/agents/${agent}"
    if [ -L "$target" ]; then
        rm "$target"
        echo "  Removed agent: ${agent%.md}"
    fi
done

echo ""
echo "Done! Agent Team Framework has been uninstalled."
