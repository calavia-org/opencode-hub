# Example: GitHub Copilot MCP Server Setup

**Purpose**: Configure GitHub Copilot MCP servers for bot automation and human actions.

**Code**:
```json
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
  }
}
```

**Pattern**: Same URL, different auth tokens for bot vs. human actions.

**Reference**: https://github.com/features/copilot
**Related**: concepts/remote-mcp-config.md
