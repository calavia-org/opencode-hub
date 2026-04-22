---
name: github-workflow
description: GitHub automation for SPEC-driven development workflow.
---

# GitHub Workflow Skill

Automate SPEC-driven development using GitHub issues, branches, and PRs.

## Workflow Integration

### SPEC Creation → Issue
When a SPEC is created, automatically create a GitHub issue:

```markdown
---
title: SPEC: [Feature Name]
labels: ["spec", "approved"]
---

## Overview
[Brief description]

## Acceptance Criteria
- [ ] [Criterion 1]
- [ ] [Criterion 2]

## Tasks
- [ ] [Task 1]
- [ ] [Task 2]
```

### Issue → Branch
Create branch from issue:
```bash
git checkout -b spec/#[issue-number]-[short-description]
```

### Implementation → PR
When all tasks complete, create PR:
```markdown
## PR Description

Closes #[issue-number]

## Changes
- [ ] Change 1
- [ ] Change 2

## Testing
- [ ] Unit tests added
- [ ] Integration tests passed
```

## GitHub MCP Tools

Use these tools from the GitHub MCP:

### Create Issue
```
github_create_issue(
  owner: "calavia-org",
  repo: "[repo-name]",
  title: "SPEC: [feature]",
  body: "[spec-content]",
  labels: ["spec"]
)
```

### Create Branch
```
github_create_branch(
  owner: "calavia-org",
  repo: "[repo-name]",
  branch: "spec/[issue-number]-[slug]",
  from_branch: "main"
)
```

### Create PR
```
github_create_pull_request(
  owner: "calavia-org",
  repo: "[repo-name]",
  title: "SPEC #[issue]: [feature]",
  body: "[changes]",
  head: "spec/[issue-number]",
  base: "main"
)
```

## Rules

1. Always link PR to issue
2. Use conventional commits
3. Squash merge preferred
4. Require reviews