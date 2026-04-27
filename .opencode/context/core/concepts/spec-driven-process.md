# Concept: SPEC-Driven Process

**Core Idea**: Specification-first workflow where features are fully specified 
in SPEC context files before any implementation begins.

**Key Points**:
- SPEC files ARE context files (live directly in context categories)
- Location: `.opencode/context/{category}/{NNN-feature}.md`
- SPEC defines: overview, motivation, requirements, acceptance criteria, tasks
- GitHub issue created with SPEC content (labeled `spec`, `approved`)
- Branch naming: `spec/{issue-number}-{feature-slug}`
- Documentation updates ALWAYS required after implementation
- Status tracking: `draft` → `approved` → `completed` (no archiving)

**Quick Example**:
```markdown
---
name: feature-slug
issue: 001
status: draft
category: development
---
## Requirements
- [ ] Requirement1
## Acceptance Criteria
- [ ] Testable criterion1
## Tasks
- [ ] Task1
```

**Context Integration**:
- SPEC files ARE context files (discoverable by ContextScout)
- Loaded via: `.opencode/context/{category}/{NNN-feature}.md`
- OpenAgentsControl agents can reference SPEC context.

**Reference**: https://github.com/calavia-org/opencode-hub
**Related**: guides/spec-process-guide.md, examples/spec-process-workflow.md
