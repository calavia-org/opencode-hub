# Concept: OpenCode Configuration Schema

**Core Idea**: `.well-known/opencode.json` defines project settings, 
agents, modes, skills, and MCP servers for OpenCode Hub discovery.

**Key Points**:
- Schema validated via `$schema` URL (https://opencode.ai/config.json)
- Version field enables backward compatibility (currently v3)
- Defines project identity (name, baseUrl) and default behavior
- References remote resources (agents, modes, skills, commands) via URLs

**Quick Example**:
```json
{
  "$schema": "https://opencode.ai/config.json",
  "version": 3,
  "name": "My Project",
  "baseUrl": "https://myproject.com"
}
```

**Reference**: https://opencode.ai/docs/config-schema
**Related**: concepts/opencode-hub-discovery.md, examples/basic-opencode-json.md
