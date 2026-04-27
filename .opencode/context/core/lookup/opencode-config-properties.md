# Lookup: OpenCode Config Properties

**Purpose**: Quick reference for `.well-known/opencode.json` properties.

| Property | Type | Required | Description |
|----------|------|----------|-------------|
| `$schema` | URL | No | JSON schema validation URL |
| `version` | Number | Yes | Config version (currently 3) |
| `name` | String | Yes | Project display name |
| `baseUrl` | URL | Yes | Project base URL for discovery |
| `defaultAgent` | String | No | Fallback agent name |
| `defaultMode` | String | No | Fallback mode name |
| `agents` | URL | No | JSON endpoint for agents |
| `modes` | URL | No | JSON endpoint for modes |
| `skills` | URL | No | JSON endpoint for skills |
| `commands` | URL | No | JSON endpoint for commands |
| `mcp` | Object | No | MCP server configurations |

**Reference**: https://opencode.ai/docs/config-properties
**Related**: concepts/opencode-config-schema.md
