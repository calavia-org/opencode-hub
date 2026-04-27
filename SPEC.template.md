---
name: feature-slug
issue: "001"
status: draft
technology: "detected"
agent: "inferred + approved"
created: YYYY-MM-DD
---

# [Feature Name]

## Overview

Brief description of the feature. What problem does it solve?

## Motivation

Why is this needed? What user pain point does it address?

## Requirements

- [ ] Requirement 1
- [ ] Requirement 2

## Acceptance Criteria

- [ ] Criterion 1 (testable)
- [ ] Criterion 2 (testable)

## Design Decisions

| Decision | Rationale | Alternative Considered |
|---------|----------|------------------------|
| Choice A | Reason | Choice B |

## Tasks

- [ ] Task 1
- [ ] Task 2

## Dependencies

**External:**
- Library or service

**Internal:**
- Feature that must be ready first

## Out of Scope

- What this feature does NOT include

## Open Questions

- Question to resolve during implementation

---

## Storage

Place this SPEC file directly in context categories (SPEC files ARE context files):

`.opencode/context/{category}/{NNN-feature-slug}.md`

Examples:
- `.opencode/context/core/001-spec-driven-process.md`
- `.opencode/context/development/001-add-auth.md`

After completion, update status to `completed` (stays in context/{category}/, no archiving).

## Agent Assignment

The `agent:` field in frontmatter shows which specialized agent will handle implementation.
This is inferred from repository technology and approved by the user.

To change: `/change-agent [agent-name]`