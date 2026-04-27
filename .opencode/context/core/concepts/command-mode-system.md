# Concept: Command & Mode System

**Core Idea**: Commands trigger specific actions (like `spec`), while modes 
define behavioral patterns (like `spec-driven`) for agents.

**Key Points**:
- Commands: Named actions users can invoke (e.g., `/spec`, `/context`)
- Modes: Behavioral contexts that persist during agent session
- `spec-driven` is both a command and a mode
- Discovered via `commands` and `modes` URLs in opencode.json

**Quick Example**:
```json
{
  "commands": [{"name": "spec", "description": "Create specs"}],
  "modes": [{"name": "spec-driven", "description": "SPEC workflow"}]
}
```

**Reference**: https://opencode.calavia.org/commands
**Related**: concepts/spec-driven-process.md, concepts/skill-system.md
