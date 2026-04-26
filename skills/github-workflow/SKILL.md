---
name: github-workflow
description: GitHub automation for SPEC-driven development workflow with .specs/ integration.
---

# GitHub Workflow Skill

Automate SPEC-driven development using GitHub issues, branches, and PRs via MCP, with full integration into the `/.specs/` directory structure.

> **Important:** Use MCP tools for ALL GitHub operations. Direct API calls (curl/gh) are NOT allowed except for verification.

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
When a SPEC is created in `/.specs/`, automatically create a GitHub issue using MCP:

1. Extract issue number and slug from filename
2. Create issue with `spec` and `approved` labels via MCP
3. Link to SPEC file path

> **Token:** Use `OPENCODE_BOT_TOKEN` (MCP server: github_bot)

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

## GitHub MCP Tools

> **Important:** For verification only. Use MCP for all operations.

### Verify MCP Connection
```bash
# Test GitHub MCP endpoint (verification only)
curl -s -X POST https://api.githubcopilot.com/mcp/ \
  -H "Authorization: Bearer $OPENCODE_BOT_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{"jsonrpc":"2.0","id":1,"method":"tools/list","params":{}}'
```

### Tools Available via MCP

| Tool | Token | Purpose |
|------|-------|---------|
| `create_issue` | Bot | Create issues |
| `create_pull_request` | Bot | Create PRs |
| `merge_pull_request` | Bot | Merge after approval |
| `approve_pull_request` | Human | Approve PRs |

### Create Issue
> Use MCP tool: `create_issue` with `OPENCODE_BOT_TOKEN`

### Create Branch
> Use Git locally: `git checkout -b spec/{issue}-{slug}`

### Create PR
> Use MCP tool: `create_pull_request` with `OPENCODE_BOT_TOKEN`

### Merge PR
> Use MCP tool: `merge_pull_request` with `OPENCODE_BOT_TOKEN` (after human approval)

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