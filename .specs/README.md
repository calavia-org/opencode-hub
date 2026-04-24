# SPEC Index

This directory contains all project specifications organized by issue number.

## Active SPECs

| # | Feature | Status | Created | Branch |
|---|---------|--------|---------|--------|
| - | - | - | - | - |

## Archived SPECs

| # | Feature | Status | Merged |
|---|---------|--------|--------|
| 001 | SPEC Tracking System | Completed | 2026-04-24 |

---

## Naming Convention

SPECs follow the pattern: `/.specs/{issue-number}-{feature-slug}.md`

Example: `/.specs/001-user-authentication.md`

## Workflow

1. **Create SPEC** → Manually create a GitHub issue with `spec` and `approved` labels
2. **Branch** → Create branch `spec/{issue}-{slug}`
3. **Implement** → Track tasks in SPEC and issue
4. **Complete** → Archive to `archived/` after PR merge

## Status States

- **Draft**: Initial creation
- **In Review**: Under stakeholder review
- **Approved**: Ready for implementation
- **In Progress**: Actively being developed
- **Completed**: Implementation finished, PR merged
- **Cancelled**: Abandoned or superseded