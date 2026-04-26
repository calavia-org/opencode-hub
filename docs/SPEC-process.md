# SPEC-Driven Development Process

The SPEC-driven development process is a structured workflow that ensures every feature is properly specified before implementation.

## Token Requirements for GitHub Actions

This workflow uses **MCP (Model Context Protocol)** for ALL GitHub interactions. Direct API calls should NOT be used.

| Step | Token to Use | MCP Server | Action |
|------|-------------|-----------|----------|
| Create Issue | `OPENCODE_BOT_TOKEN` | `github_bot` | `create_issue` |
| Create Branch | SSH Key | Git (local) | `git checkout -b` |
| Commit | SSH Key | Git (local) | `git commit` |
| Push | SSH Key | Git (local) | `git push` |
| Create PR | `OPENCODE_BOT_TOKEN` | `github_bot` | `create_pull_request` |
| Review PR | `HUMAN_TOKEN` | `github_human` | `add_comment_to_pending_review` |
| Approve PR | `HUMAN_TOKEN` | `github_human` | `approve_pull_request` |
| Merge PR | `HUMAN_TOKEN` | `github_human` | `merge_pull_request` |

### MCP Configuration

```json
{
  "mcp": {
    "github_bot": {
      "type": "http",
      "url": "https://api.githubcopilot.com/mcp/",
      "headers": {
        "Authorization": "Bearer {env:OPENCODE_BOT_TOKEN}"
      }
    },
    "github_human": {
      "type": "http",
      "url": "https://api.githubcopilot.com/mcp/",
      "headers": {
        "Authorization": "Bearer {env:HUMAN_TOKEN}"
      }
    }
  }
}
```

### Token Setup

| Token | Variable | Required Scopes |
|-------|----------|-----------------|
| Bot | `OPENCODE_BOT_TOKEN` | Classic token with `repo` scope |
| Human | `HUMAN_TOKEN` | Classic token with `repo` scope |

**Note:** OAuth (GitHub Copilot App) is NOT required for remote config loading. Any provider API key triggers well-known loading.

### Token Verification (Required Before Each Step)

Before any GitHub action, verify the token has required capabilities. If verification fails, STOP and fix the token before proceeding.

#### Verification Commands

```bash
# Test MCP connection with bot token
curl -s -X POST https://api.githubcopilot.com/mcp/ \
  -H "Authorization: Bearer $OPENCODE_BOT_TOKEN" \
  -H "Content-Type: application/json" \
  -H "Accept: text/event-stream, application/json" \
  -d '{"jsonrpc":"2.0","id":1,"method":"tools/list","params":{}}'

# Test MCP connection with human token
curl -s -X POST https://api.githubcopilot.com/mcp/ \
  -H "Authorization: Bearer $HUMAN_TOKEN" \
  -H "Content-Type: application/json" \
  -H "Accept: text/event-stream, application/json" \
  -d '{"jsonrpc":"2.0","id":1,"method":"tools/list","params":{}}'
```

#### Verification Checklist

| Step | Token | Check | If Fails |
|------|-------|-------|----------|
| Create Issue | `OPENCODE_BOT_TOKEN` | MCP returns tools list | STOP - Fix bot token |
| Create PR | `OPENCODE_BOT_TOKEN` | MCP returns tools list | STOP - Fix bot token |
| Review PR | `HUMAN_TOKEN` | MCP returns tools list | STOP - Fix human token |
| Approve PR | `HUMAN_TOKEN` | MCP returns tools list | STOP - Fix human token |
| Merge PR | `HUMAN_TOKEN` | MCP returns tools list | STOP - Fix human token |

#### If Verification Fails

1. **401 Unauthorized** - Token invalid or expired → Regenerate token
2. **403 Forbidden** - Missing scopes → Update token scopes to include `repo`, `read:org`
3. **Empty response** - MCP server down → Wait or use fallback (NOT recommended)

> **Rule:** Never proceed with GitHub actions if token verification fails. Fix the token first.

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