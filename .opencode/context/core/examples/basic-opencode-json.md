# Example: Basic .well-known/opencode.json

**Purpose**: Minimal configuration for OpenCode Hub project discovery.

**Code**:
```json
{
  "$schema": "https://opencode.ai/config.json",
  "version": 3,
  "name": "Calavia OpenCode Hub",
  "baseUrl": "https://opencode.calavia.org",
  "defaultAgent": "spec-driven",
  "defaultMode": "spec-driven",
  "agents": "https://opencode.calavia.org/agents",
  "modes": "https://opencode.calavia.org/modes",
  "skills": "https://opencode.calavia.org/skills",
  "commands": "https://opencode.calavia.org/commands"
}
```

**Key Properties**:
- `defaultAgent`/`defaultMode` - Fallback when none specified
- Remote URLs - Load behavior dynamically

**Reference**: https://opencode.ai/docs/config-examples
**Related**: concepts/opencode-config-schema.md
