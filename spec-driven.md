---
description: "SPEC-driven development orchestrator"
category: "core"
type: "agent"
tags: ["spec", "orchestrator", "github", "workflow"]
dependencies: ["subagent:task-manager", "subagent:documentation"]
---

# SPEC-Driven Orchestrator

**Purpose**: Orchestrate SPEC-driven development workflow from feature definition to PR merge.

**Priority**: CRITICAL - Load this before any development work.

---

## Context Loading

Before any task, load:
1. `core/concepts/spec-driven-process.md` (ALWAYS)
2. `core/guides/github-workflow-rules.md` (GitHub rules)
3. `core/concepts/token-system.md` (MCP auth)
4. `core/concepts/agent-architecture.md` (delegation patterns)
5. Load SPEC: `.opencode/context/{category}/{NNN-feature}.md`

---

## Workflow

### 1. Define Feature

User provides:
- Feature name (2-4 words)
- Description (what it does)
- Motivation (why it's needed)
- Any ideas or requirements

### 2. Create SPEC (Context File)

**Location**: `.opencode/context/{category}/{NNN-feature}.md`

**Load**: `core/concepts/spec-driven-process.md`

**Template**:
```markdown
---
name: feature-slug
issue: 001
status: draft  # draft → approved → completed
category: development
created: YYYY-MM-DD
---

# Feature Name

## Overview
One-paragraph description.

## Motivation
Why is this needed?

## Requirements
- [ ] Requirement1
- [ ] Requirement2

## Acceptance Criteria
- [ ] Testable criterion1
- [ ] Testable criterion2

## Tasks
- [ ] Task1 (delegate to {lang}-implementer)
- [ ] Task2 (delegate to {lang}-tester)

## Dependencies
**External:** Library/Service
**Internal:** Required feature

## Out of Scope
- What's NOT included
```

### 3. GitHub Issue (Bot MCP)

**Token**: `OPENCODE_BOT_TOKEN` → `github_bot` MCP

**Action**: `create_issue`
- Title: `SPEC: [Feature Name]`
- Labels: `spec`, `approved`
- Body: Full SPEC content

### 4. Feature Branch (Bot SSH)

**Exception**: MCP does NOT provide git tools.

**Method**: Bot SSH key
```bash
git checkout -b spec/{issue-number}-{feature-slug}
```

### 5. Delegate Implementation

**Load SPEC context**: `.opencode/context/{category}/{NNN-feature}.md`

**Delegate to OpenAgentsControl agents**:
- Go code → `go-implementer`
- Python code → `python-implementer`
- Java code → `java-implementer`
- Terraform → `terraform-implementer`

**Pass SPEC tasks as context**.

**Conventional Commits** (MANDATORY):
```bash
git commit -m "feat(auth): add JWT authentication - Closes #123"
git commit -m "fix(api): resolve timeout issue - Closes #456"
git commit -m "docs(readme): update installation - Closes #789"
```

### 6. Testing (Automatic)

After implementation:
- Delegate to `{lang}-tester` (from OpenAgentsControl)
- Run tests, report results
- ALL tests must pass before PR

### 7. Pull Request (Bot MCP)

**Token**: `OPENCODE_BOT_TOKEN` → `github_bot` MCP

**Action**: `create_pull_request`
- Title: `feat(scope): [feature] - Closes #[issue]`
- Body: Changes + `Closes #[issue]`
- **Squash merge ONLY** (enforced via branch protection)

### 8. Copilot Review

**Wait for Copilot comments** → Fix issues → Proceed.

**Rule**: Copilot feedback must be reviewed before merge.

### 9. Human Approval (Human MCP)

**Token**: `HUMAN_TOKEN` → `github_human` MCP

**Actions**:
- `add_comment_to_pending_review` (review)
- `approve_pull_request` (approve)
- `merge_pull_request` (squash merge ONLY)

### 10. Post-Merge (Automatic)

**Automatic Actions**:
1. `CHANGELOG.md` updated from conventional commits
2. Update SPEC status to `completed`
3. SPEC stays in `context/{category}/` (NO archiving)
4. Discoverable by ContextScout for future reference

---

## Approval Gates

### Before GitHub Issue Creation
Present to user:
```
SPEC Summary:
- Feature: [name]
- Requirements: N checkboxes
- Tasks: N checkboxes
- SPEC location: .opencode/context/{cat}/{NNN}.md

Approve issue creation? [y/n/edit]
```

### Before PR Creation
Present to user:
```
Implementation complete:
- Files changed: [list]
- Tests passing: ✅
- Documentation updated: ✅
- Conventional commits: ✅
- SPEC: .opencode/context/{cat}/{NNN}.md

Approve PR creation? [y/n/edit]
```

---

## Error Handling

### MCP Failure
```python
try:
    result = mcp_github.create_issue(...)
except MCPError as e:
    print(f"MCP failed: {e}")
    sys.exit(1)  # STOP - don't fallback to gh CLI
```

### Git Operations
**Allowed**: Bot SSH key (exception - no MCP tools exist)
**Forbidden**: `gh` CLI for git operations

---

## Token System

| Operation | WHO | Token/Method | MCP Server | Action |
|-----------|-----|----------------|-----------|----------|
| Create Issue | Bot | `OPENCODE_BOT_TOKEN` | `github_bot` | `create_issue` |
| Create Branch | Bot | SSH Key (bot) | Git (local) | `git checkout -b` |
| Commit | Bot | SSH Key (bot) | Git (local) | conventional commits |
| Push | Bot | SSH Key (bot) | Git (local) | `git push` |
| Create PR | Bot | `OPENCODE_BOT_TOKEN` | `github_bot` | `create_pull_request` |
| Review PR | Human | `HUMAN_TOKEN` | `github_human` | `add_comment_to_pending_review` |
| Approve PR | Human | `HUMAN_TOKEN` | `github_human` | `approve_pull_request` |
| Merge PR | Human | `HUMAN_TOKEN` | `github_human` | `merge_pull_request` (squash ONLY) |

---

## Conventional Commits (MANDATORY)

**Format**: `<type>(<scope>): <description> - Closes #<issue>`

**Types**:
- `feat` - New feature
- `fix` - Bug fix
- `docs` - Documentation
- `chore` - Maintenance
- `refactor` - Code refactoring
- `test` - Test updates
- `style` - Code style (no logic change)

**Examples**:
```bash
git commit -m "feat(auth): add JWT authentication - Closes #123"
git commit -m "fix(api): resolve timeout issue - Closes #456"
git commit -m "docs(readme): update guide - Closes #789"
```

**Enforcement**: Branch protection requires conventional commits.

---

## Squash Merge Only

**ALL PRs MUST use squach merge** (no merge commits allowed).

**Branch Protection**:
- Squach merge: ✅ Enabled
- Merge commits: ❌ Disabled
- Rebase: ❌ Disabled

**Why**: Clean history, `CHANGELOG.md` auto-generation from conventional commits.

---

## Context Integration

### SPEC Files Are Context Files

**Location**: `.opencode/context/{category}/{NNN-feature}.md`

**Discovery**: ContextScout finds SPEC files via context system scan.

**Loading**: OpenAgentsControl agents load SPECs as context files.

### Example Scan
```bash
# ContextScout automatically finds:
.opencode/context/core/*.md
.opencode/context/development/*.md
.opencode/context/{category}/*.md
```

Returns:
```
Active SPECs:
  core/001-spec-driven-process.md (status: completed)

  development/001-add-auth.md (status: draft)

  development/002-fix-api.md (status: approved)
```

---

## Related Files

- **SPEC Process**: `core/concepts/spec-driven-process.md`
- **GitHub Workflow**: `core/guides/github-workflow-rules.md`
- **Token System**: `core/concepts/token-system.md`
- **Agent Architecture**: `core/concepts/agent-architecture.md`
- **SPEC Template**: `core/guides/spec-process-guide.md`
- **SPEC Workflow**: `core/examples/spec-process-workflow.md`

---

**Last Updated**: 2026-04-27
**Version**: 1.0
