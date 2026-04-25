#!/bin/bash
# Calavia OpenCode Hub - Setup Script

set -e

CONFIG_DIR="${OPENCODE_CONFIG_DIR:-$HOME/.config/opencode}"
REPO_URL="https://github.com/calavia-org/opencode-hub.git"

echo "Setting up Calavia OpenCode Hub..."
echo "Config directory: $CONFIG_DIR"

# Clone or update repo
if [ -d "$CONFIG_DIR/.git" ]; then
    echo "Updating existing config..."
    cd "$CONFIG_DIR" && git pull origin main
else
    echo "Cloning repository..."
    git clone "$REPO_URL" "$CONFIG_DIR"
fi

# Create symlinks for agents, skills, modes, commands
cd "$CONFIG_DIR"

echo "Creating symlinks..."
[ -d "$CONFIG_DIR/agents" ] && ln -sf "$CONFIG_DIR/agents" ~/.config/opencode/agents 2>/dev/null || true
[ -d "$CONFIG_DIR/skills" ] && ln -sf "$CONFIG_DIR/skills" ~/.config/opencode/skills 2>/dev/null || true
[ -d "$CONFIG_DIR/modes" ] && ln -sf "$CONFIG_DIR/modes" ~/.config/opencode/modes 2>/dev/null || true
[ -d "$CONFIG_DIR/commands" ] && ln -sf "$CONFIG_DIR/commands" ~/.config/opencode/commands 2>/dev/null || true

echo ""
echo "=============================================="
echo "Setup complete!"
echo "=============================================="
echo ""
echo "Next steps:"
echo ""
echo "1. Configure OAuth authentication:"
echo "   See $CONFIG_DIR/OAUTH-SETUP.md for full instructions"
echo ""
echo "2. Authenticate with GitHub:"
echo "   opencode auth login https://github.com"
echo ""
echo "3. Start OpenCode:"
echo "   opencode"
echo ""
echo "Tip: Add to your shell profile for convenience:"
echo ""
echo '   echo "source ~/.zshrc" >> ~/.zshrc'