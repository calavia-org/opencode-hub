---
name: spec-driven
description: SPEC-driven development workflow mode with full GitHub integration.
mode: primary
requires:
  - github-workflow
---

# SPEC-Driven Development Mode

Complete development workflow from SPEC to PR using GitHub automation.

## Behavior

1. Always spec before implementing
2. Treat SPEC.md as source of truth
3. Verify implementation against spec
4. Update spec when requirements change

## Workflow Chain

This mode orchestrates the full pipeline:

1. SPEC → Create SPEC.md
2. ISSUE → Create GitHub issue with spec content
3. BRANCH → Create feature branch (spec/{id}-{slug})
4. IMPLEMENT → Delegate to [lang]-implementer
5. TEST → Delegate to [lang]-tester
6. VERIFY → Delegate to [lang]-verifier
7. DEPLOY → Delegate to [lang]-deployer
8. PR → Create pull request, close issue

## Rules

- Never skip the spec phase
- All TODOs trace to spec
- Mark criteria done only when verified
- Always link PR to issue
- Use conventional commits

## Output Style

Concise specs with checkboxes.