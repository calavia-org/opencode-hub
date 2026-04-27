---
name: github-workflow
description: GitHub automation for SPEC-driven development workflow. SPEC files are context files stored directly in context categories.
---

# GitHub Workflow Skill

> ⚡ **Load at start**: This skill enforces [GitHub Workflow Rules](docs/github-workflow-rules.md)
> - MCP-only for GitHub API (no gh CLI, curl)
> - Token separation (BOT vs HUMAN)
> - MCP failure stops execution

Automate SPEC-driven development using GitHub issues, branches, and PRs, with full integration into the context system.

## SPEC Storage Integration

All GitHub operations are tied to SPECs stored directly in context categories (SPEC files ARE context files):

```
.opencode/context/
├── core/
│   ├── 001-spec-driven-process.md
│   └── 002-context-structure.md
├── development/
│   ├── 001-add-auth.md
│   └── 002-fix-api.md
└── ...
```

### Naming Convention

| GitHub Element | Pattern | Example |
|---------------|---------|---------|
| SPEC File | `.opencode/context/{category}/{NNN}-{slug}.md` | `.opencode/context/development/001-add-auth.md` |
| Branch | `spec/{issue}-{slug}` | `spec/001-user-auth` |
| Issue Title | `SPEC: [Feature Name]` | `SPEC: User Authentication` |

## Workflow Integration

### SPEC Creation → Issue
When a SPEC is created in `.opencode/context/{category}/`, automatically create a GitHub issue:

1. Extract issue number and slug from filename
2. Create issue with `spec` and `approved` labels
3. Link to SPEC file path

```markdown
## Overview
[Brief description from SPEC]

## Requirements
- [ ] [From SPEC requirements]

## Acceptance Criteria
- [ ] [Criterion 1]
- [ ] [Criterion 2]

## Tasks
- [ ] [Task 1]
- [ ] [Task 2]

## Linked SPEC
`.opencode/context/{category}/{NNN}-{slug}.md`
```

### Issue → Branch
Create branch from issue number in SPEC filename:

```bash
# Branch name from SPEC: .opencode/context/development/001-user-auth.md
git checkout -b spec/001-user-auth
```

### Implementation → PR
When all tasks complete:

1. Update SPEC with completion status
2. Create PR with issue reference
3. Link to SPEC file

```markdown
## PR: [Feature]

Closes #[issue-number]

## Changes
- [ ] Change 1
- [ ] Change 2

## SPEC
`.opencode/context/{category}/{NNN}-{slug}.md`

## Testing
- [ ] Unit tests added
- [ ] Integration tests passed
```

### After Merge → Update Status
1. Update SPEC status to `completed` (stays in context/{category}/)
2. No archiving - SPEC remains discoverable by ContextScout

## GitHub API Operations (MCP Required)

> ⚠️ **Rule**: All GitHub API operations MUST use MCP tools. 
> gh CLI and curl are forbidden per SPEC #031.

### Create Issue
```bash
# Use MCP - curl is forbidden
mcp_github create-issue \
  --title "SPEC: [Feature Name]" \
  --body "[spec-content]" \
  --labels "spec,approved"
```

### Create Branch
```bash
# Use git directly for branch creation (not API)
git checkout -b "spec/{issue}-{slug}"
```

### Create PR
```bash
# Use MCP - curl is forbidden
mcp_github create-pull-request \
  --title "Closes #{issue}: [feature]" \
  --body "[changes]" \
  --head "spec/{issue}-{slug}" \
  --base "main"
```

### Update Issue Checkboxes
```bash
# Use MCP
mcp_github update-issue \
  --issue-number {issue} \
  --body "[updated-body-with-checked-items]"
```

## SPEC Maintenance

Update SPEC status directly in the context file:
- New SPEC created (status: `draft`)
- Status changes (update frontmatter)
- SPEC completed (status: `completed`, stays in context/{category}/)

No index needed - ContextScout discovers SPEC files automatically.

## Rules

1. Always link PR to issue
2. Use conventional commits
3. Squash merge ONLY (enforced via branch protection)
4. Require reviews
5. Store all SPECs directly in context categories (`.opencode/context/{category}/`)
6. No archiving - SPEC stays in context with status `completed`