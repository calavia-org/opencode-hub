# Concept: Remote MCP Server Configuration

**Core Idea**: MCP servers defined in `opencode.json` with type, URL, 
auth headers, and enable toggle for dynamic tool discovery.

**Key Points**:
- `type: "remote"` connects to external MCP servers via HTTP
- `url` points to MCP endpoint (e.g., GitHub Copilot, Context7)
- `requestInit.headers` injects auth tokens from env variables
- `enabled: true/false` toggles server availability at runtime

**Quick Example**:
```json
"my_server": {
  "type": "remote",
  "url": "https://mcp.example.com/mcp",
  "enabled": true,
  "requestInit": {
    "headers": { "Authorization": "Bearer {env:MY_TOKEN}" }
  }
}
```

**Reference**: https://modelcontextprotocol.io/docs
**Related**: examples/github-copilot-mcp.md, examples/context7-mcp-config.md
