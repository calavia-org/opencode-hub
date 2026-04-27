# Concept: Agent/Mode/Skill/Command References

**Core Idea**: OpenCode decouples behavior from config - agents, modes, 
skills, and commands load dynamically from remote URLs at runtime.

**Key Points**:
- `agents`, `modes`, `skills`, `commands` fields are URLs, not bundled code
- Enables hot-reloading behavior without config changes
- Each URL returns JSON defining available capabilities
- Promotes modular, distributed agent architectures

**Quick Example**:
```json
{
  "agents": "https://opencode.calavia.org/agents",
  "modes": "https://opencode.calavia.org/modes",
  "skills": "https://opencode.calavia.org/skills"
}
```

**Reference**: https://opencode.ai/docs/architecture
**Related**: concepts/opencode-hub-discovery.md, lookup/opencode-config-properties.md
