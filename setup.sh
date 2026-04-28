#!/bin/bash
# OpenCode Hub - Setup Script
# Installs Calavia OpenCode Hub + inherits OpenAgents Control
# Usage: curl -sL https://raw.githubusercontent.com/calavia-org/opencode-hub/main/setup.sh | bash
#   or: ./setup.sh

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}========================================${NC}"
echo -e "${BLUE}  OpenCode Hub - Setup Script${NC}"
echo -e "${BLUE}========================================${NC}"
echo ""

# Step 1: Install OpenAgents Control (for agents, subagents, skills)
echo "Step 1: Installing OpenAgents Control..."
echo "  (provides: openagent, subagents, skills, etc.)"
echo ""

if [ -f "$(dirname "$0")/install.sh" ] && [ "$(dirname "$0")" != "." ]; then
    # Running from within opencode-hub repo - use local install.sh
    bash "$(dirname "$0")/install.sh" "${1:-}"
else
    # Not in repo - fetch and run OpenAgentsControl install.sh
    curl -sL https://raw.githubusercontent.com/darrenhinde/OpenAgentsControl/main/install.sh | bash -s -- "${1:-}"
fi

echo ""
echo -e "${GREEN}✓${NC} OpenAgents Control installed"
echo ""

# Step 2: Install OpenCode Hub specific context
echo "Step 2: Installing OpenCode Hub context..."

OPENCODE_CONFIG_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/opencode"
TARGET_DIR="${1:-$OPENCODE_CONFIG_DIR}"

# Install hub-specific context (core, project-intelligence, etc.)
if [ -d "$(dirname "$0")/.opencode/context" ]; then
    # Running from repo
    mkdir -p "$TARGET_DIR/context"
    cp -r "$(dirname "$0")/.opencode/context/core" "$TARGET_DIR/context/" 2>/dev/null || true
    cp -r "$(dirname "$0")/.opencode/context/project-intelligence" "$TARGET_DIR/context/" 2>/dev/null || true
    echo -e "${GREEN}✓${NC} Hub context installed"
else
    echo -e "${YELLOW}⚠${NC} Not running from repo - skipping hub context"
    echo "  Clone opencode-hub to install hub-specific context"
fi

echo ""
echo -e "${BLUE}========================================${NC}"
echo -e "${BLUE}  Setup Complete${NC}"
echo -e "${BLUE}========================================${NC}"
echo ""
echo "Installed:"
echo "  ✓ OpenAgents Control (agents, subagents, skills)"
echo "  ✓ OpenCode Hub context (core, project-intelligence)"
echo ""
echo "Next steps:"
echo "  1. Set up tokens:"
echo "     export OPENCODE_BOT_TOKEN=\"your_bot_token\""
echo "     export HUMAN_TOKEN=\"your_human_token\""
echo "     export CONTEXT7_API_KEY=\"your_key\""
echo "  2. Run: opencode auth login github"
echo "  3. Start: opencode (uses spec-driven by default)"
echo ""
