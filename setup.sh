#!/bin/bash
# Calavia OpenCode Hub - Simple Setup Script
# 
# This script clones the repository directly to ~/.config/opencode.
# That's it! No symlinks, no copies needed.
#
# Usage:
#   setup.sh           # Clone/update repository to ~/.config/opencode
#   setup.sh --update # Pull latest changes
#   setup.sh --clean  # Remove installation
#   setup.sh --help   # Show help

set -e

# Configuration
REPO_URL="https://github.com/calavia-org/opencode-hub.git"
CONFIG_DIR="${OPENCODE_CONFIG_DIR:-$HOME/.config/opencode}"

echo "=============================================="
echo "  Calavia OpenCode Hub - Setup"
echo "=============================================="
echo ""

# Handle different actions
case "$1" in
    --help|-h|"")
        echo "Usage: setup.sh [--update|--clean|--help]"
        echo ""
        echo "Options:"
        echo "  (none)   Clone or update repository to ~/.config/opencode"
        echo "  --update Pull latest changes from repository"
        echo "  --clean  Remove ~/.config/opencode directory"
        echo ""
        echo "Alternatively, simply run:"
        echo "  git clone $REPO_URL ~/.config/opencode"
        echo ""
        exit 0
        ;;
    --update)
        echo "Updating existing installation..."
        if [ -d "$CONFIG_DIR/.git" ]; then
            cd "$CONFIG_DIR" && git pull origin main --quiet
            echo "✓ Updated to latest"
        else
            echo "ERROR: No installation found at $CONFIG_DIR"
            echo "Run without --update first to install"
            exit 1
        fi
        exit 0
        ;;
    --clean)
        echo "Removing installation..."
        rm -rf "$CONFIG_DIR"
        echo "✓ Removed $CONFIG_DIR"
        exit 0
        ;;
esac

# Default: Clone or verify installation
if [ -d "$CONFIG_DIR/.git" ]; then
    echo "Installation already exists at $CONFIG_DIR"
    echo "Run 'setup.sh --update' to update"
    exit 0
fi

echo "Cloning repository to $CONFIG_DIR..."
git clone --depth 1 "$REPO_URL" "$CONFIG_DIR"

echo ""
echo "=============================================="
echo "  Setup Complete!"
echo "=============================================="
echo ""
echo "Installed to: $CONFIG_DIR"
echo ""
echo "To update later: setup.sh --update"
echo "To remove:     setup.sh --clean"
echo ""
echo "Or simply: git clone $REPO_URL ~/.config/opencode"