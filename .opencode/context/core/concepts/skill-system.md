# Concept: Skill System

**Core Idea**: Skills are reusable capabilities that extend agent behavior, 
loaded on-demand from `.opencode/skills/` or remote URLs.

**Key Points**:
- 6 skills available: spec-driven, github-workflow, context7, root-cause-analysis, repo-bootstrap, expert-config
- Each skill has `SKILL.md` with instructions and workflows
- Skills discovered via `skills` URL in opencode.json
- Loaded via task tool with `skill` parameter

**Quick Example**:
```json
{
  "name": "context7",
  "description": "Up-to-date library documentation",
  "files": ["SKILL.md"]
}
```

**Reference**: https://opencode.calavia.org/skills
**Related**: lookup/skill-reference.md, concepts/command-mode-system.md
