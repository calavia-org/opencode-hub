<!-- Context: project-intelligence/nav | Priority: high | Version: 1.1 | Updated: 2026-04-28 -->

# Project Intelligence

> Start here for quick project understanding. These files bridge business and technical domains.

## Purpose

Provides comprehensive project context by documenting business needs, technical implementation, decision history, and current state in a function-based structure for easy discovery.

---

## Quick Navigation

### Concepts
*What the project is - core definitions and domains*

| File | Description | Priority |
|------|-------------|----------|
| `concepts/business-domain.md` | Business context, problem statement, users, value proposition | high |
| `concepts/technical-domain.md` | Stack, architecture, technical decisions, integrations | high |

### Guides
*How to understand and use this intelligence - processes and workflows*

| File | Description | Priority |
|------|-------------|----------|
| `guides/business-tech-bridge.md` | How business needs map to technical solutions | high |
| `guides/decisions-log.md` | Major decisions with rationale and alternatives | high |

### Lookup
*Quick reference - current state and active items*

| File | Description | Priority |
|------|-------------|----------|
| `lookup/living-notes.md` | Active issues, technical debt, open questions | high |

### Examples
*Working examples (none yet)*

*No examples yet. Add working code examples here as the project evolves.*

### Errors
*Common issues (none yet)*

*No errors documented yet. Add common issues and fixes here as they arise.*

---

## Loading Strategy

**New Team Member / Agent**:
1. Start with `navigation.md` (this file)
2. Read `concepts/business-domain.md` - understand the "why"
3. Read `concepts/technical-domain.md` - understand the "how"
4. Read `guides/business-tech-bridge.md` - see the connection
5. Read `guides/decisions-log.md` - know the context
6. Reference `lookup/living-notes.md` - current state

**Quick Reference**:
- Business focus → `concepts/business-domain.md`
- Technical focus → `concepts/technical-domain.md`
- Decision context → `guides/decisions-log.md`
- Current state → `lookup/living-notes.md`

**For Specific Tasks**:
- Understanding architecture → `concepts/technical-domain.md`
- Understanding business case → `concepts/business-domain.md`
- Why was X built? → `guides/decisions-log.md`
- How does business need Y map to tech? → `guides/business-tech-bridge.md`
- What's the current status? → `lookup/living-notes.md`

---

## Structure

```
.opencode/context/project-intelligence/
├── navigation.md              # This file - quick overview
├── concepts/                  # What it is (domain definitions)
│   ├── business-domain.md
│   └── technical-domain.md
├── guides/                    # How to use (processes, workflows)
│   ├── business-tech-bridge.md
│   └── decisions-log.md
├── lookup/                    # Quick reference (current state)
│   └── living-notes.md
├── examples/                  # Working code (empty - for future use)
└── errors/                    # Common issues (empty - for future use)
```

---

## Integration

This folder is referenced from:
- `.opencode/context/core/standards/project-intelligence.md` (standards and patterns)
- `.opencode/context/core/system/context-guide.md` (context loading)

See `.opencode/context/core/context-system.md` for the broader context architecture.

---

## Maintenance

Keep this folder current:
- Update `concepts/` when business or technical direction changes
- Document decisions in `guides/decisions-log.md` as they're made
- Update `lookup/living-notes.md` regularly with current state
- Review and archive resolved items periodically

**Management Guide**: See `.opencode/context/core/standards/project-intelligence-management.md` for complete lifecycle management including:
- How to update, add, and remove files
- How to create new subfolders
- Version tracking and frontmatter standards
- Quality checklists and anti-patterns
- Governance and ownership

See `.opencode/context/core/standards/project-intelligence.md` for the standard itself.
