---
name: spec-driven
description: Create and manage specifications for features.
---

# SPEC-Driven Development Skill

Create detailed specifications before implementation.

## When to Use

Start this skill when:
- Beginning a new feature
- Unclear requirements
- Risk of scope creep
- Need to document decisions

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

1. Spec before code
2. Checkboxes track progress
3. Criteria must be testable
4. Update spec when changing requirements
5. Spec lives in the repo