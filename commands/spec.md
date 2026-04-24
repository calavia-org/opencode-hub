---
command: spec
description: Create a new specification for a feature
agent: spec-driven
mode: spec-driven
skill: spec-driven
requires:
  - github-workflow
---

Create SPEC.md for a new feature with full GitHub workflow:

1. Ask for feature name and description
2. Create spec with requirements, acceptance criteria, tasks
3. Review with user
4. Create GitHub issue with spec content
5. Create feature branch from issue
6. Track tasks and create PR when complete