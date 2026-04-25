#!/bin/bash
# Calavia OpenCode Hub - Setup Script
# Fetches remote config and sets up local environment

set -e

CONFIG_DIR="${OPENCODE_CONFIG_DIR:-$HOME/.config/opencode}"
REPO_URL="https://github.com/calavia-org/opencode-hub.git"
REMOTE_CONFIG="https://opencode.calavia.org/.well-known/opencode.json"

echo "=============================================="
echo "Calavia OpenCode Hub - Setup"
echo "=============================================="
echo ""

# Fetch remote config
echo "Fetching remote configuration..."
CONFIG_RESPONSE=$(curl -sL "$REMOTE_CONFIG")
if [ $? -ne 0 ] || [ -z "$CONFIG_RESPONSE" ]; then
    echo "Error: Could not fetch remote config from $REMOTE_CONFIG"
    exit 1
fi

# Clone or update repo
if [ -d "$CONFIG_DIR/.git" ]; then
    echo "Updating existing config..."
    cd "$CONFIG_DIR" && git pull origin main
else
    echo "Cloning repository..."
    git clone "$REPO_URL" "$CONFIG_DIR"
fi

# Apply remote config
cd "$CONFIG_DIR"
echo "Applying remote configuration..."
echo "$CONFIG_RESPONSE" > .well-known/opencode.json

# Create symlinks for agents, skills, modes, commands
echo "Setting up components..."
[ -d "$CONFIG_DIR/agents" ] && ln -sf "$CONFIG_DIR/agents" ~/.config/opencode/agents 2>/dev/null || true
[ -d "$CONFIG_DIR/skills" ] && ln -sf "$CONFIG_DIR/skills" ~/.config/opencode/skills 2>/dev/null || true
[ -d "$CONFIG_DIR/modes" ] && ln -sf "$CONFIG_DIR/modes" ~/.config/opencode/modes 2>/dev/null || true
[ -d "$CONFIG_DIR/commands" ] && ln -sf "$CONFIG_DIR/commands" ~/.config/opencode/commands 2>/dev/null || true

# Save remote config for opencode
echo "Configuring opencode..."
mkdir -p ~/.config/opencode
cp "$CONFIG_DIR/.well-known/opencode.json" ~/.config/opencode/opencode.json

echo ""
echo "=============================================="
echo "Setup complete!"
echo "=============================================="
echo ""
echo "Next steps:"
echo ""
echo "1. Set your GitHub token (required):"
echo "   Run: opencode auth login"
echo "   OR manually: export GITHUB_TOKEN=ghp_..."
echo ""
echo "2. Optional tokens (for MCP):"
echo "   export CONTEXT7_API_KEY=ctx7_..."
echo ""
echo "3. Start opencode:"
echo "   opencode"
echo ""
echo "Note: Your token is personal. See MCP-SETUP.md for bot/human separation."