---
name: spec-driven
description: Create and manage specifications for features with full GitHub workflow and .specs/ storage.
requires:
  - github-workflow
---

# SPEC-Driven Development Skill

Create detailed specifications before implementation with complete GitHub workflow.

## SPEC Storage

All SPECs are stored in the `/.specs/` directory with standardized naming:

```
/.specs/
├── README.md              # Index of all SPECs
├── archived/             # Completed/cancelled SPECs
├── 001-feature-name.md    # Active SPECs
└── ...
```

### Naming Convention

Pattern: `/{issue-number}-{feature-slug}.md`

Examples:
- `001-user-authentication.md`
- `042-api-rate-limiting.md`
- `100-payment-integration.md`

### Storage Rules

1. **Active SPECs**: Stored directly in `/.specs/`
2. **Archived SPECs**: Moved to `/.specs/archived/` after completion
3. **Template**: Use `SPEC.template.md` at repository root
4. **Current Pointer**: `SPEC.md` points to the active working SPEC

## When to Use

Start this skill when:
- Beginning a new feature
- Unclear requirements
- Risk of scope creep
- Need to document decisions

## Full Workflow

This skill orchestrates the complete development workflow:

### 1. SPEC Creation
1. Create SPEC using template in `SPEC.template.md`
2. Save to `/.specs/{issue-number}-{feature-slug}.md`
3. Update `/.specs/README.md` index

### 2. Create GitHub Issue
After SPEC is approved, create GitHub issue:
```
github_create_issue(
  owner: "[owner]",
  repo: "[repo-name]",
  title: "SPEC: [Feature Name]",
  body: "[spec-content-from-.specs]",
  labels: ["spec", "approved"]
)
```

### 3. Create Branch
Create feature branch from issue number:
```
github_create_branch(
  owner: "[owner]",
  repo: "[repo-name]",
  branch: "spec/[issue-number]-[slug]",
  from_branch: "main"
)
```

### 4. Track Tasks
- Implement tasks from SPEC in `/.specs/`
- Update checkbox status in GitHub issue
- Update `/.specs/README.md` with progress

### 5. Create PR
When all tasks complete:
```
github_create_pull_request(
  owner: "[owner]",
  repo: "[repo-name]",
  title: "Closes #[issue-number]: [feature]",
  body: "[changes summary]\n\nCloses #[issue-number]\n\nSPEC: /.specs/[issue]-[slug].md",
  head: "spec/[issue-number]-[slug]",
  base: "main"
)
```

### 6. Archive
After PR merge:
- Move SPEC to `/.specs/archived/`
- Update `/.specs/README.md` status

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
| Decision | Rationale | Alternative |
|----------|----------|------------|
| Choice A | Reason | Choice B |

## Tasks
- [ ] Implementable task
- [ ] Another task

## Dependencies
**External:** Library or service
**Internal:** Feature that must be ready first

## Out of Scope
- What this feature does NOT include
```

## Agent Integration

The spec-driven agent will:
1. Detect `/.specs/` directory structure
2. Load SPEC from `/.specs/{issue}-{slug}.md`
3. Enforce SPEC existence before implementation
4. Auto-generate branch names from SPEC issue number
5. Track task completion against SPEC
6. Maintain `/.specs/README.md` index

## Rules

1. Always link PR to issue
2. Use conventional commits
3. Squash merge preferred
4. Require reviews
5. Spec before code
6. Checkboxes track progress
7. Criteria must be testable
8. Update spec when changing requirements
9. Store all SPECs in `/.specs/` directory
10. Archive completed SPECs to `/.specs/archived/`