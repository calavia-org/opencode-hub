# SPEC Index

This directory contains all project specifications organized by issue number.

## Active SPECs

| # | Feature | Status | Created | Branch |
|---|---------|--------|---------|--------|
| - | - | - | - | - |

## Archived SPECs

Completed and cancelled SPECs are moved to `archived/` for reference.

---

## Naming Convention

SPECs follow the pattern: `/{issue-number}-{feature-slug}.md`

Example: `001-user-authentication.md`

## Workflow

1. Create SPEC → Creates GitHub issue with `spec` label
2. Implement → Branch: `spec/{issue}-{slug}`
3. Complete → Archive to `archived/` after PR merge

## Status States

- **Draft**: Initial creation
- **In Review**: Under stakeholder review
- **Approved**: Ready for implementation
- **In Progress**: Actively being developed
- **Completed**: Implementation finished, PR merged
- **Cancelled**: Abandoned or superseded