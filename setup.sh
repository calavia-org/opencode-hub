#!/bin/bash
# Calavia OpenCode Hub - Setup Script

CONFIG_DIR="${OPENCODE_CONFIG_DIR:-$HOME/.config/opencode}"
REPO_URL="https://github.com/calavia-org/opencode-hub.git"

echo "=============================================="
echo "Calavia OpenCode Hub - Setup"
echo "=============================================="
echo ""

# Clone repo for components (agents, skills, modes, commands)
if [ -d "$CONFIG_DIR/.git" ]; then
    echo "Updating existing config..."
    cd "$CONFIG_DIR" && git pull origin main
else
    echo "Cloning repository to $CONFIG_DIR..."
    git clone "$REPO_URL" "$CONFIG_DIR"
fi

echo ""
echo "=============================================="
echo "Setup complete!"
echo "=============================================="
echo ""
echo "Next steps:"
echo ""
echo "1. Authenticate with GitHub:"
echo "   opencode auth login"
echo ""
echo "2. Start opencode:"
echo "   opencode"
echo ""
echo "Config is loaded from https://opencode.calavia.org/.well-known/opencode.json"