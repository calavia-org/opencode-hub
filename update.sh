#!/bin/bash
# Calavia OpenCode Hub - Auto Update Script
# Run this to keep your config up to date

set -e

CONFIG_DIR="${OPENCODE_CONFIG_DIR:-$HOME/.config/opencode}"

if [ ! -d "$CONFIG_DIR/.git" ]; then
    echo "Error: $CONFIG_DIR is not a git repository"
    echo "Run setup.sh first: curl -sL https://calavia.org/setup.sh | bash"
    exit 1
fi

cd "$CONFIG_DIR"
echo "Fetching latest changes..."
git fetch origin main
echo "Checking out latest..."
git checkout origin/main -- agents modes skills commands SPEC.template.md .well-known/opencode.json 2>/dev/null || git stash && git checkout origin/main
echo "Done!"