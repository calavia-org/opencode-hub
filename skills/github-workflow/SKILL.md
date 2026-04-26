---
name: github-workflow
description: GitHub automation for SPEC-driven development workflow with .specs/ integration.
---

# GitHub Workflow Skill

Automate SPEC-driven development using GitHub issues, branches, and PRs, with full integration into the `/.specs/` directory structure.

## SPEC Storage Integration

All GitHub operations are tied to SPECs stored in `/.specs/`:

```
/.specs/
├── README.md
├── archived/
│   └── {issue}-{slug}.md
├── {issue}-{slug}.md      # Active SPECs
└── ...
```

### Naming Convention

| GitHub Element | Pattern | Example |
|---------------|---------|---------|
| SPEC File | `/.specs/{issue}-{slug}.md` | `/.specs/001-user-auth.md` |
| Branch | `spec/{issue}-{slug}` | `spec/001-user-auth` |
| Issue Title | `SPEC: [Feature Name]` | `SPEC: User Authentication` |

## Workflow Integration

### SPEC Creation → Issue
When a SPEC is created in `/.specs/`, automatically create a GitHub issue:

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
`/.specs/{issue}-{slug}.md`
```

### Issue → Branch
Create branch from issue number in SPEC filename:

```bash
# Branch name from SPEC: /.specs/001-user-auth.md
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
`/.specs/{issue}-{slug}.md`

## Testing
- [ ] Unit tests added
- [ ] Integration tests passed
```

### After Merge → Archive
1. Move SPEC to `/.specs/archived/`
2. Update `/.specs/README.md` status

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

## Index Maintenance

Update `/.specs/README.md` when:
- New SPEC created (add to Active table)
- Status changes (update Status column)
- SPEC completed (move to Archived table)

## Rules

1. Always link PR to issue
2. Use conventional commits
3. Squash merge preferred
4. Require reviews
5. Store all SPECs in `/.specs/` directory
6. Archive completed SPECs to `/.specs/archived/`