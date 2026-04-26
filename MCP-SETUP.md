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

## MCP Configuration (opencode.json)

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

- [ ] OPENCODE_BOT_TOKEN exported
- [ ] HUMAN_TOKEN exported
- [ ] Both MCPs responding to tools/list
- [ ] I know which MCP to use for each action

---

## Engram Integration (Context Memory)

Engram provides persistent context memory for OpenCode sessions. It stores typed memories (episodic, semantic, procedural) and provides semantic search via MCP.

### Installation

```bash
# macOS
brew install engram

# Or download binary from https://github.com/softmaxdata/engram
```

### Setup OpenCode Integration

```bash
# One-command full setup (plugin + MCP)
engram setup opencode
```

This command:
1. Copies plugin to `~/.config/opencode/plugins/engram.ts`
2. Adds MCP server entry to `opencode.json`
3. Auto-starts HTTP server when needed

### Manual MCP-Only Setup

If you only want the 13 memory tools without the plugin:

```json
{
  "mcp": {
    "engram": {
      "type": "local",
      "command": ["engram", "mcp"],
      "enabled": true
    }
  }
}
```

### Starting the Server

```bash
# Start HTTP API server (default port 7437)
engram serve

# Or run MCP server directly
engram mcp
```

### Available Memory Tools (13)

| Tool | Purpose |
|------|---------|
| `mem_put` | Save memory with type |
| `mem_search` | Vector similarity search |
| `mem_timeline` | Chronological context |
| `mem_context` | Recent session context |
| `mem_summary` | Get session summary |
| `mem_delete` | Delete memory |
| `mem_update` | Update memory |
| And more... |

### Memory Types

- **Episodic**: Conversation history, events
- **Semantic**: Facts, knowledge, preferences
- **Procedural**: How-to, workflows

### Verify Integration

```bash
# Check engram is configured
engram stats
```

Then in OpenCode, ask: "What memories do I have?"