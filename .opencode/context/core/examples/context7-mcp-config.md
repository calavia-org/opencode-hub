# Example: Context7 MCP Server Configuration

**Purpose**: Configure Context7 MCP server with API key authentication.

**Code**:
```json
"mcp": {
  "context7": {
    "type": "remote",
    "url": "https://mcp.context7.com/mcp",
    "enabled": true,
    "headers": {
      "CONTEXT7_API_KEY": "{env:CONTEXT7_API_KEY}"
    }
  }
}
```

**Key Points**:
- Uses top-level `headers` (not nested in `requestInit`)
- API key injected from environment variable
- Context7 provides up-to-date library documentation

**Reference**: https://context7.com/docs
**Related**: concepts/remote-mcp-config.md, examples/github-copilot-mcp.md
