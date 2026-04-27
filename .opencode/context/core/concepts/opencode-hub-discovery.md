# Concept: OpenCode Hub Discovery

**Core Idea**: AI agents discover OpenCode projects by fetching 
`.well-known/opencode.json` at the project's base URL.

**Key Points**:
- Standardized discovery endpoint (RFC 8615 well-known convention)
- Agents auto-detect available modes, skills, and commands from URLs
- Enables decentralized agent ecosystems (any server can host config)
- No central registry needed - just a well-known URL

**Quick Example**:
```bash
curl https://opencode.calavia.org/.well-known/opencode.json
# Returns config → Agent loads agents/modes/skills from URLs
```

**Reference**: https://tools.ietf.org/html/rfc8615
**Related**: concepts/opencode-config-schema.md, concepts/agent-mode-skill-refs.md
