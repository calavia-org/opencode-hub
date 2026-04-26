# GitHub MCP Configuration Guide

## Two-Token System

This configuration enables proper separation between bot automation and human approval:

| MCP Connection | Token | Purpose | Can Approve |
|---------------|-------|---------|------------|
| `github_bot` | `OPENCODE_BOT_TOKEN` | I use this for automation | No |
| `github_human` | `HUMAN_TOKEN` | Human uses this for approvals | Yes |

## Environment Setup

Add to your shell profile (`~/.zshrc`):

```bash
# Bot token (for me - automation)
export OPENCODE_BOT_TOKEN="YOUR_BOT_TOKEN_HERE"

# Human token (for you - approvals)
export HUMAN_TOKEN="YOUR_HUMAN_TOKEN_HERE"

# Context7 for docs
export CONTEXT7_API_KEY="YOUR_CONTEXT7_KEY"
```

Apply changes:
```bash
source ~/.zshrc
```

## MCP Configuration

> **Important:** OpenCode config schema does NOT support custom MCP servers. MCP is auto-enabled when provider API keys are present in environment variables.

| Provider | Token Required | Auto-Enables |
|----------|--------------|-------------|
| GitHub | `GITHUB_TOKEN`, `OPENCODE_BOT_TOKEN`, or `HUMAN_TOKEN` | ✅ |
| Context7 | `CONTEXT7_API_KEY` | ✅ |

### Verification

```bash
# Check loaded MCP servers
opencode mcp list
```

## How MCP Servers Are Used

### When I Create PRs, Branches, Issues
- Use: `OPENCODE_BOT_TOKEN` environment variable
- I create: branches, SPECs, PRs, commits, merge after approval

### When Human Needs to Approve or Merge
- Use: `HUMAN_TOKEN` environment variable
- You approve: in GitHub UI
- I wait for: your approval

### When Context7 Fetches Docs
- Use: `context7` (CONTEXT7_API_KEY)
- Used by: language-specific implementers

## Verify Setup

```bash
# Test bot MCP
curl -s -X POST https://api.githubcopilot.com/mcp/ \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer $OPENCODE_BOT_TOKEN" \
  -d '{"jsonrpc":"2.0","method":"tools/list","id":1}'

# Test human MCP
curl -s -X POST https://api.githubcopilot.com/mcp/ \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer $HUMAN_TOKEN" \
  -d '{"jsonrpc":"2.0","method":"tools/list","id":1}'
```

## Checklist

- [ ] `OPENCODE_BOT_TOKEN` exported (for bot automation)
- [ ] `HUMAN_TOKEN` exported (for human approvals)
- [ ] Run `opencode mcp list` to verify MCP servers loaded