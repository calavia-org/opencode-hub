#!/bin/bash
# Calavia OpenCode Hub - Organization Setup Script
# This script sets up OpenCode with centralized configuration from this repository

set -e

# Configuration
REPO_URL="https://github.com/calavia-org/opencode-hub.git"
CONFIG_DIR="${OPENCODE_CONFIG_DIR:-$HOME/.config/opencode}"
GLOBAL_CONFIG="$HOME/.config/opencode/opencode.json"
LOCAL_CONFIG="$HOME/.opencode.json"

echo "=============================================="
echo "  Calavia OpenCode Hub - Organization Setup"
echo "=============================================="
echo ""

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
    opencode --version
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
    echo "WARNING: OPENCODE_BOT_TOKEN not set"
fi

if [ -n "$HUMAN_TOKEN" ]; then
    echo "✓ HUMAN_TOKEN set"
else
    echo "WARNING: HUMAN_TOKEN not set"
fi

if [ -n "$CONTEXT7_API_KEY" ]; then
    echo "✓ CONTEXT7_API_KEY set"
else
    echo "WARNING: CONTEXT7_API_KEY not set (optional)"
fi

# Clone or update repository
echo ""
echo "Setting up configuration..."

if [ -d "$CONFIG_DIR/.git" ]; then
    echo "Updating existing configuration..."
    cd "$CONFIG_DIR"
    git pull origin main --quiet || echo "WARNING: Could not update (may have local changes)"
else
    echo "Cloning repository to $CONFIG_DIR..."
    git clone --depth 1 "$REPO_URL" "$CONFIG_DIR"
fi

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
  "mcp": {
    "github_bot": {
      "type": "remote",
      "url": "https://api.githubcopilot.com/mcp/",
      "enabled": false,
      "headers": {
        "Authorization": "Bearer {env:OPENCODE_BOT_TOKEN}"
      }
    },
    "github_human": {
      "type": "remote",
      "url": "https://api.githubcopilot.com/mcp/",
      "enabled": false,
      "headers": {
        "Authorization": "Bearer {env:HUMAN_TOKEN}"
      }
    },
    "context7": {
      "type": "remote",
      "url": "https://mcp.context7.com/mcp",
      "enabled": false,
      "headers": {
        "CONTEXT7_API_KEY": "{env:CONTEXT7_API_KEY}"
      }
    }
  }
}
EOF

echo "✓ Global MCP config created at $GLOBAL_CONFIG"

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
echo "To enable MCP servers, create $LOCAL_CONFIG:"
echo ""
echo '  echo "{\"mcp\":{\"github_bot\":{\"enabled\":true}}}" > ~/.opencode.json'
echo ""
echo "Then run: opencode"