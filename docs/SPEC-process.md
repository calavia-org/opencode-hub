# SPEC-Driven Development Process

The SPEC-driven development process is a structured workflow that ensures every feature is properly specified before implementation.

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
| Rework needed | Implemented correctly the first time |
| Untracked progress | Checkbox tracking |

## The Workflow

### 1. Define Feature

User provides:
- Feature name (2-4 words)
- Description (what it does)
- Motivation (why it's needed)
- Any ideas or requirements

### 2. Create SPEC

Agent creates `SPEC.md` with:
- Frontmatter (issue, status, agent, created)
- Overview (one-paragraph description)
- Motivation (problem solved)
- Requirements (checkboxes)
- Acceptance Criteria (testable checkboxes)
- Design Decisions (with rationale)
- Tasks (implementable checkboxes)
- Dependencies (external/internal)
- Out of Scope (what's NOT included)

### 3. GitHub Issue

After SPEC approval, issue created with:
- Title: `SPEC: [Feature Name]`
- Labels: `spec`, `approved`
- Body: Full SPEC content

### 4. Feature Branch

Branch created from issue number:
```
spec/{issue-number}-{feature-slug}
```

Example: `spec/023-fix-documents`

### 5. Implementation

Tasks tracked in both:
- SPEC.md (checkboxes)
- GitHub issue (checkbox comments)

### 6. Pull Request

When complete:
- Title: `Closes #[issue]: [feature]`
- Body: Changes + `Closes #[issue]`
- Labels updated
- Review requested

### 7. Archive

After PR merge:
- SPEC moved to `.specs/archived/`
- Status updated to `completed`

## SPEC Template

```markdown
---
name: feature-slug
issue: 001
status: draft
technology: [detected]
agent: [inferred + approved]
created: YYYY-MM-DD
---

# Feature Name

## Overview
One-paragraph description.

## Motivation
Why is this needed?

## Requirements
- [ ] Requirement 1
- [ ] Requirement 2

## Acceptance Criteria
- [ ] Testable criterion 1
- [ ] Testable criterion 2

## Tasks
- [ ] Task 1
- [ ] Task 2

## Dependencies
**External:** Library/Service
**Internal:** Required feature

## Out of Scope
- What's NOT included
```

## Tracking

All SPECs stored in `.specs/` directory:

```
.specs/
├── README.md              # Index
├── archived/              # Completed
├── 001-feature.md       # Active
└── ...
```

Check `.specs/README.md` for full index.

## Commands

```bash
# List all SPECs
cat .specs/README.md

# View active SPECS
ls .specs/[0-9]*.md

# View archived SPECs
ls .specs/archived/
```

## Related

- [Workflows & Diagrams](./workflows.md)
- [Token Setup](./tokens.md)
- [GitHub Repository](https://github.com/calavia-org/opencode-hub)