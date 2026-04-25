# MCP Configuration Guide

This hub uses OAuth for authentication (see [OAuth Setup Guide](OAUTH-SETUP.md)). MCP tokens are managed separately for automation.

## Two-Token System

This configuration enables proper separation between bot automation and human approval:

| MCP Connection | Token | Purpose | Can Approve |
|---------------|-------|---------|------------|
| `github_bot` | `OPENCODE_BOT_TOKEN` | I use this for automation | No |
| `github_human` | `HUMAN_TOKEN` | Human uses this for approvals | Yes |

## Prerequisites

First, complete OAuth authentication:

```bash
opencode auth login https://github.com
```

See [OAuth Setup Guide](OAUTH-SETUP.md) for full instructions.

## Generate MCP Tokens

### Bot Token (OPENCODE_BOT_TOKEN)

1. Create a GitHub Fine-grained PAT:
   - Go to GitHub **Settings** → **Developer settings** → **Personal access tokens** → **Fine-grained tokens**
   - Generate new token with:
     - Repository access: All repositories
     - Permissions:
       - Contents: Read and write
       - Pull requests: Read and write
       - Issues: Read and write
       - Commit statuses: Read and write
       - Workflows: Read and write

2. Add to environment:
   ```bash
   export OPENCODE_BOT_TOKEN="ghp_YourTokenHere"
   ```

### Human Token (HUMAN_TOKEN)

Use your personal GitHub token with full permissions:

```bash
export HUMAN_TOKEN="ghp_YourPersonalToken"
```

## Environment Setup

Add to your shell profile (`~/.zshrc`):

```bash
# OAuth authentication (automatic via opencode auth login)
# Your OAuth token is stored in ~/.local/share/opencode/auth.json

# MCP tokens (for bot/human separation)
export OPENCODE_BOT_TOKEN="YOUR_BOT_TOKEN_HERE"
export HUMAN_TOKEN="YOUR_HUMAN_TOKEN_HERE"

# Context7 for docs
export CONTEXT7_API_KEY="YOUR_CONTEXT7_KEY"
```

Apply changes:

```bash
source ~/.zshrc
```

## MCP Configuration (opencode.json)

The MCP servers are pre-configed in `.well-known/opencode.json`:

```json
{
  "mcp": {
    "github_bot": {
      "type": "remote",
      "url": "https://api.githubcopilot.com/mcp/",
      "enabled": true,
      "description": "Bot automation - creates branches, PRs, merges",
      "requestInit": {
        "headers": {
          "Authorization": "Bearer {env:OPENCODE_BOT_TOKEN}"
        }
      }
    },
    "github_human": {
      "type": "remote",
      "url": "https://api.githubcopilot.com/mcp/",
      "enabled": true,
      "description": "Human actions - approves PRs, merges",
      "requestInit": {
        "headers": {
          "Authorization": "Bearer {env:HUMAN_TOKEN}"
        }
      }
    },
    "context7": {
      "type": "remote",
      "url": "https://mcp.context7.com/mcp",
      "enabled": true,
      "headers": {
        "CONTEXT7_API_KEY": "{env:CONTEXT7_API_KEY}"
      }
    }
  }
}
```

## How I Use These Connections

### When Creating PRs, Branches, Issues
- Use: `github_bot` (OPENCODE_BOT_TOKEN)
- I create: branches, SPECs, PRs, commits

### When Human Needs to Approve or Merge
- Use: `github_human` (HUMAN_TOKEN)
- You approve: in GitHub UI or command
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

- [ ] Completed OAuth authentication (`opencode auth login`)
- [ ] OPENCODE_BOT_TOKEN exported
- [ ] HUMAN_TOKEN exported
- [ ] CONTEXT7_API_KEY exported
- [ ] Both GitHub MCPs responding to tools/list