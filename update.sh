#!/bin/bash
# Calavia OpenCode Hub - Update Script
# Fetches latest config and updates local setup

set -e

CONFIG_DIR="${OPENCODE_CONFIG_DIR:-$HOME/.config/opencode}"
REMOTE_CONFIG="https://opencode.calavia.org/.well-known/opencode.json"

if [ ! -d "$CONFIG_DIR/.git" ]; then
    echo "Error: $CONFIG_DIR is not a git repository"
    echo "Run setup.sh first: curl -sL https://opencode.calavia.org/setup.sh | bash"
    exit 1
fi

cd "$CONFIG_DIR"
echo "Fetching latest changes..."
git fetch origin main

echo "Checking out latest..."
git checkout origin/main -- agents modes skills commands SPEC.template.md .well-known/opencode.json 2>/dev/null || git stash && git checkout origin/main

echo "Fetching remote configuration..."
CONFIG_RESPONSE=$(curl -sL "$REMOTE_CONFIG")
if [ $? -eq 0 ] && [ -n "$CONFIG_RESPONSE" ]; then
    echo "Applying remote configuration..."
    echo "$CONFIG_RESPONSE" > .well-known/opencode.json
    cp .well-known/opencode.json ~/.config/opencode/opencode.json
fi

echo "Done!"