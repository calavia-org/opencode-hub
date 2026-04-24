---
name: spec-driven
description: Create and manage specifications for features with full GitHub workflow.
requires:
  - github-workflow
---

# SPEC-Driven Development Skill

Create detailed specifications before implementation with complete GitHub workflow.

## When to Use

Start this skill when:
- Beginning a new feature
- Unclear requirements
- Risk of scope creep
- Need to document decisions

## Full Workflow

This skill orchestrates the complete development workflow:

### 1. SPEC Creation
Create SPEC.md following the template below.

### 2. Create GitHub Issue
After SPEC is approved, create GitHub issue:
```
github_create_issue(
  owner: "[owner]",
  repo: "[repo-name]",
  title: "SPEC: [Feature Name]",
  body: "[spec-content]",
  labels: ["spec", "approved"]
)
```

### 3. Create Branch
Create feature branch:
```
github_create_branch(
  owner: "[owner]",
  repo: "[repo-name]",
  branch: "spec/[issue-number]-[slug]",
  from_branch: "main"
)
```

### 4. Track Tasks
- Implement tasks from SPEC.md
- Update checkbox status in issue

### 5. Create PR
When all tasks complete:
```
github_create_pull_request(
  owner: "[owner]",
  repo: "[repo-name]",
  title: "Closes #[issue-number]: [feature]",
  body: "[changes summary]\n\nCloses #[issue-number]",
  head: "spec/[issue-number]",
  base: "main"
)
```

## Spec Template

```markdown
# [Feature Name]

## Overview
One-paragraph description.

## Motivation
Why is this needed? What problem does it solve?

## Requirements
- [ ] Requirement with checkbox
- [ ] Another requirement

## Acceptance Criteria
- [ ] Testable criterion
- [ ] Another criterion

## Design Decisions
- Architecture choice and rationale
- Alternative considered

## Tasks
- [ ] Implementable task
- [ ] Another task

## Dependencies
- External: Library or service
- Internal: Other features

## Out of Scope
- What this feature does NOT include
```

## Rules

1. Always link PR to issue
2. Use conventional commits
3. Squash merge preferred
4. Require reviews
5. Spec before code
6. Checkboxes track progress
7. Criteria must be testable
8. Update spec when changing requirements