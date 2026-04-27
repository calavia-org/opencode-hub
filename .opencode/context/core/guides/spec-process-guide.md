# Guide: SPEC Process

**Purpose**: Detailed SPEC-driven development workflow

## Overview

```
┌─────────┐    ┌─────────┐    ┌─────────┐    ┌─────────┐
│  SPEC   │───▶│ ISSUE  │───▶│ BRANCH  │───▶│   PR    │
└─────────┘    └─────────┘    └─────────┘    └─────────┘
```

## Why SPEC First?

| Without SPEC | With SPEC |
|--------------|-----------|
| Scope creep | Clear boundaries |
| Unclear requirements | Testable criteria |
| Rework needed | Implemented correctly |
| Untracked progress | Checkbox tracking |

## Workflow Steps

1. **Define Feature**: Name, description, motivation, requirements
2. **Create SPEC**: `.opencode/context/{category}/{NNN-feature}.md` with frontmatter, overview, tasks
3. **GitHub Issue**: Title `SPEC: [Feature]`, labels `spec`, `approved`
4. **Feature Branch**: `spec/{issue-number}-{feature-slug}` (bot SSH)
5. **Implementation**: Code + tests, update docs, check Copilot comments
6. **Pull Request**: Title `Closes #[issue]: [feature]` (bot MCP)
7. **Complete**: Update SPEC status to `completed` (no archiving)

## SPEC Files ARE Context Files

```
.opencode/context/
├── core/
│   ├── 001-spec-driven-process.md      # SPEC file (IS a context file)
│   ├── 002-context-structure.md        # SPEC file (IS a context file)
│   └── concepts/                        # Regular context folder
│       └── spec-driven-process.md
│
├── development/
│   ├── 001-add-auth.md                # SPEC file (IS a context file)
│   ├── 002-fix-api.md                  # SPEC file (IS a context file)
│   └── concepts/                        # Regular context folder
│       └── ...
│
└── {category}/
    ├── NNN-feature.md                 # SPEC file (IS a context file)
    └── concepts/                        # Regular context folder
        └── ...
```

**Key**: SPEC files live directly in category root (they ARE context files).
**Discovery**: ContextScout finds them via context system scan.

**Reference**: https://github.com/calavia-org/opencode-hub
**Related**: concepts/spec-driven-process.md, examples/spec-process-workflow.md
