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
| SPEC File | `/{issue}-{slug}.md` | `001-user-auth.md` |
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

## GitHub API Operations

### Create Issue
```bash
curl -X POST /repos/{owner}/{repo}/issues \
  -H "Authorization: Bearer {token}" \
  -d '{
    "title": "SPEC: [Feature Name]",
    "body": "[spec-content]",
    "labels": ["spec", "approved"]
  }'
```

### Create Branch
```bash
curl -X POST /repos/{owner}/{repo}/git/refs \
  -H "Authorization: Bearer {token}" \
  -d '{
    "ref": "refs/heads/spec/{issue}-{slug}",
    "sha": "{main-branch-sha}"
  }'
```

### Create PR
```bash
curl -X POST /repos/{owner}/{repo}/pulls \
  -H "Authorization: Bearer {token}" \
  -d '{
    "title": "Closes #{issue}: [feature]",
    "body": "[changes]\n\nCloses #{issue}\n\nSPEC: /.specs/{issue}-{slug}.md",
    "head": "spec/{issue}-{slug}",
    "base": "main"
  }'
```

## Update Issue Checkboxes

After completing tasks, update issue body:

```bash
curl -X PATCH /repos/{owner}/{repo}/issues/{issue-number} \
  -H "Authorization: Bearer {token}" \
  -d '{
    "body": "[updated-body-with-checked-items]"
  }'
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