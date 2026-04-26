#!/bin/bash
# Calavia OpenCode Hub - Organization Setup Script
# This script sets up OpenCode with centralized configuration from this repository
#
# Usage:
#   setup.sh           # Fresh install or update
#   setup.sh --update # Force update from repository
#   setup.sh --clean  # Remove and reinstall

set -e

# Parse arguments
ACTION="${1:-install}"

# Configuration
REPO_URL="https://github.com/calavia-org/opencode-hub.git"
CONFIG_DIR="${OPENCODE_CONFIG_DIR:-$HOME/.config/opencode}"
GLOBAL_CONFIG="$HOME/.config/opencode/opencode.json"

echo "=============================================="
echo "  Calavia OpenCode Hub - Organization Setup"
echo "=============================================="
echo ""
echo "Mode: $ACTION"
echo ""

# Handle different actions
case "$ACTION" in
    --update)
        echo "Forcing update from repository..."
        if [ -d "$CONFIG_DIR/.git" ]; then
            cd "$CONFIG_DIR" && git pull origin main --quiet
            echo "✓ Updated"
            
            # Reinstall symlinks
            echo "Reinstalling symlinks..."
            [ -d "$CONFIG_DIR/agents" ] && ln -sf "$CONFIG_DIR/agents" "$HOME/.config/opencode/agents" 2>/dev/null && echo "✓ Agents updated"
            [ -d "$CONFIG_DIR/skills" ] && ln -sf "$CONFIG_DIR/skills" "$HOME/.config/opencode/skills" 2>/dev/null && echo "✓ Skills updated"
            [ -d "$CONFIG_DIR/modes" ] && ln -sf "$CONFIG_DIR/modes" "$HOME/.config/opencode/modes" 2>/dev/null && echo "✓ Modes updated"
            [ -d "$CONFIG_DIR/commands" ] && ln -sf "$CONFIG_DIR/commands" "$HOME/.config/opencode/commands" 2>/dev/null && echo "✓ Commands updated"
            
            echo ""
            echo "Update complete!"
            exit 0
        else
            echo "ERROR: No existing installation found. Run without --update first."
            exit 1
        fi
        ;;
    --clean)
        echo "Removing existing installation..."
        rm -rf "$CONFIG_DIR"
        echo "✓ Removed"
        echo ""
        echo "Running fresh install..."
        ;;
    --help|-h)
        echo "Usage: setup.sh [--update|--clean|--help]"
        echo ""
        echo "Options:"
        echo "  (none)   Fresh install or update existing"
        echo "  --update Force update from repository"
        echo "  --clean  Remove and reinstall"
        echo "  --help  Show this help"
        exit 0
        ;;
esac

# For install mode, check if already installed
if [ -d "$CONFIG_DIR/.git" ]; then
    echo "Configuration already exists at $CONFIG_DIR"
    echo "Run 'setup.sh --update' to update"
    echo ""
    exit 0
fi

# Function to check if command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Check prerequisites
echo "Checking prerequisites..."

if ! command_exists git; then
    echo "ERROR: git is required but not installed."
    exit 1
fi

echo "✓ git found"

# Check if OpenCode is installed
if command_exists opencode; then
    opencode --version 2>/dev/null | head -1
    echo "✓ OpenCode found"
else
    echo "WARNING: OpenCode not installed. Install from: https://opencode.ai"
fi

# Check for tokens
echo ""
echo "Checking tokens..."

if [ -n "$OPENCODE_BOT_TOKEN" ]; then
    echo "✓ OPENCODE_BOT_TOKEN set"
else
    echo "⚠ OPENCODE_BOT_TOKEN not set (optional)"
fi

if [ -n "$HUMAN_TOKEN" ]; then
    echo "✓ HUMAN_TOKEN set"
else
    echo "⚠ HUMAN_TOKEN not set (optional)"
fi

if [ -n "$CONTEXT7_API_KEY" ]; then
    echo "✓ CONTEXT7_API_KEY set"
else
    echo "⚠ CONTEXT7_API_KEY not set (optional)"
fi

# Clone repository
echo ""
echo "Setting up configuration..."

echo "Cloning repository to $CONFIG_DIR..."
git clone --depth 1 "$REPO_URL" "$CONFIG_DIR"

# Create directory structure
mkdir -p "$HOME/.config/opencode"

# Copy/symlink configuration files
echo "Installing configuration..."

# Agents
if [ -d "$CONFIG_DIR/agents" ]; then
    rm -rf "$HOME/.config/opencode/agents"
    ln -sf "$CONFIG_DIR/agents" "$HOME/.config/opencode/agents"
    echo "✓ Agents installed"
fi

# Skills
if [ -d "$CONFIG_DIR/skills" ]; then
    rm -rf "$HOME/.config/opencode/skills"
    ln -sf "$CONFIG_DIR/skills" "$HOME/.config/opencode/skills"
    echo "✓ Skills installed"
fi

# Modes
if [ -d "$CONFIG_DIR/modes" ]; then
    rm -rf "$HOME/.config/opencode/modes"
    ln -sf "$CONFIG_DIR/modes" "$HOME/.config/opencode/modes"
    echo "✓ Modes installed"
fi

# Commands
if [ -d "$CONFIG_DIR/commands" ]; then
    rm -rf "$HOME/.config/opencode/commands"
    ln -sf "$CONFIG_DIR/commands" "$HOME/.config/opencode/commands"
    echo "✓ Commands installed"
fi

# Create global config with MCP servers
echo "Creating global configuration..."

cat > "$GLOBAL_CONFIG" << 'EOF'
{
  "$schema": "https://opencode.ai/config.json",
  "skills": {
    "paths": ["~/.config/opencode/skills"]
  }
}
EOF

echo "✓ Global config created (MCP auto-enabled via provider API keys)"

# Create README with setup instructions
echo ""
echo "=============================================="
echo "  Setup Complete!"
echo "=============================================="
echo ""
echo "Configuration installed to: $CONFIG_DIR"
echo "Global config: $GLOBAL_CONFIG"
echo ""
echo "Tokens required (add to your shell profile):"
echo ""
echo "  # GitHub Bot (for automation)"
echo "  export OPENCODE_BOT_TOKEN=ghp_..."
echo ""
echo "  # Human (for approvals)"
echo "  export HUMAN_TOKEN=ghp_..."
echo ""
echo "  # Context7 (for documentation lookup)"
echo "  export CONTEXT7_API_KEY=ctx7_..."
echo ""
echo "Then run: opencode"
echo ""
echo "To update later: ./setup.sh --update"