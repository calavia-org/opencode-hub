#!/bin/bash
# Calavia OpenCode Hub - Auto Update Script
# Run this to keep your config up to date

set -e

CONFIG_DIR="${OPENCODE_CONFIG_DIR:-$HOME/.config/opencode}"

if [ ! -d "$CONFIG_DIR/.git" ]; then
    echo "Error: $CONFIG_DIR is not a git repository"
    echo "Run: git clone https://github.com/calavia-org/opencode-hub.git ~/.config/opencode"
    exit 1
fi

cd "$CONFIG_DIR"
echo "Pulling latest changes..."
git pull origin main --quiet

echo "✓ Updated to latest"