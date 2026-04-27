# PR Review & Merge Workflow Enhancement

## Overview

Enhance the PR review and merge workflow with human-controlled SPEC definition and approvals, bot-assisted automation (as my identity), and automated SPEC archival through an organization-level GitHub Action. The human defines requirements and approves PRs while I handle all technical execution and follow-up tasks.

## Motivation

Current pain points:
- **Self-approval blocked**: Cannot approve own PRs, blocking merge
- **Manual SPEC archival**: Forgotten after merge, losing traceability
- **Org-level protection**: Cannot be overridden via API
- **Separation of concerns**: Human wants control, bot handles automation

**Note**: SPECs are now context files stored in `.opencode/context/{category}/` (no `.specs/` directory)

Goals:
- **Human in control** → I handle automation, human approves
- **Two identities** → My bot identity for automation, human identity for approvals
- **Org-wide automation** → Update SPEC status across all repos via org workflow
- **Copilot review** → Separate SPEC for dedicated review loop

## Architecture

### Two MCP Connections

| Connection | Identity | Purpose |
|------------|----------|---------|
| **Bot (me)** | `opencode-bot` or my identity | Execute automation tasks |
| **Human** | Human's token | Approve PRs, merge, review |

### Human Controls

- ✅ Human defines SPEC (feature name, description, requirements)
- ✅ Human approves PRs
- ✅ Human merges (via approval triggering bot)
- ✅ Human reviews architecture/strategy decisions
- ❌ Bot does NOT auto-approve

### Bot Handles

- ✅ Create SPEC file in `.opencode/context/{category}/`
- ✅ Create branch from SPEC
- ✅ Implement code
- ✅ Create PRs with proper structure
- ✅ Wait for human approval
- ✅ Execute merge after approval
- ✅ Update SPEC status to `completed` (stays in context/{category}/, no archiving)

## Requirements

### Token Management

The system uses two tokens for proper separation of concerns:

| Token | Environment Variable | Purpose | Can Approve | Can Merge |
|-------|---------------------|---------|-------------|-----------|
| Bot Token | `OPENCODE_BOT_TOKEN` | All automation tasks | ❌ No | ✅ Yes |
| Human Token | `HUMAN_TOKEN` | Human actions | ✅ Yes | ✅ Yes |

### Bot Identity (Me)

- [ ] Primary identity for all automation (OPENCODE_BOT_TOKEN)
- [ ] Has write access to repositories
- [ ] Can create branches, PRs, comments
- [ ] Cannot approve PRs (human reviews required)
- [ ] Can update SPEC status to `completed` (no archiving)

### Human Identity (Token)

- [ ] Human's GitHub token with repo permissions
- [ ] Required for actions only human can perform:
  - Approve PRs
  - Merge PRs (if using human token directly)

### OpenCode Configuration

```yaml
# opencode.json or environment configuration
{
  "github": {
    "bot_token_env": "OPENCODE_BOT_TOKEN",
    "human_token_env": "HUMAN_TOKEN",
    "bot_username": "opencode-bot"
  }
}
```

### Bot Account Creation Guide

1. **Create GitHub Account**
   - Create new GitHub account (e.g., `opencode-bot`)
   - Enable 2FA

2. **Add to Organization**
   - Go to organization settings → People
   - Invite `opencode-bot`
   - Set role: **Admin** or **Maintainer** (needs write access)

3. **Generate Personal Access Token**
   - Go to: Settings → Developer settings → Personal access tokens → Fine-grained tokens
   - Select **All repositories** or specific repos
   - Grant permissions:
     - Contents: Read and write
     - Pull requests: Read and write
     - Issues: Read and write
     - Commit statuses: Read and write
     - Workflows: Read and write
   - Generate and save token securely

4. **Add to Secrets**
   - Go to organization settings → Secrets and variables → Actions
   - Add `OPENCODE_BOT_TOKEN` with the generated token

5. **For Human Token**
   - Use your own GitHub token or generate new one
   - Add `HUMAN_TOKEN` to secrets
   - Keep separate from bot token

- [ ] Human defines SPEC (feature name, description, requirements)
- [ ] Human creates PR via bot (bot handles branch, commits, opens PR)
- [ ] Human reviews PR via GitHub UI
- [ ] Human approves PR (satisfies merge requirements)
- [ ] Bot polls/checks PR status periodically or on-demand
- [ ] Once approved, bot executes merge (squash by default)
- [ ] Bot updates SPEC status to `completed` on merge (no archiving)

### Organization Workflow (.github repository)

- [x] Repository-level GitHub Action for SPEC status update (this repo)
- [ ] Copy to .github org repository for org-wide automation
- [ ] `spec-complete` workflow: triggers on PR merge in any repo
- [ ] Status update logic:
  1. Detect merge event with `closed` + `merged: true`
  2. Parse issue number from PR title/body
  3. Find SPEC in `.opencode/context/{category}/{NNN}-{slug}.md`
  4. Update SPEC frontmatter: `status: completed`
  5. ContextScout automatically discovers updated SPEC (no index needed)
  6. Create follow-up PR if direct push blocked

### Workflow Configuration

Repository-level config in `SPEC.workflow.yml`:

```yaml
workflow:
  # Human approval required
  human_required: true
  human_reviews: 1          # Number of human approvals needed

  # Merge settings
  merge:
    method: squash           # squash, merge, rebase
    delete_branch: true
    human_triggers_merge: true  # Human comment triggers bot merge

  # SPEC handling
  spec:
    auto_archive: true       # Org workflow handles this
    archive_via: org_workflow  # or "bot_pr", "direct_push"
```
Human defines SPEC (feature, requirements)
      ↓
Bot creates SPEC file in `.opencode/context/{category}/`
      ↓
Bot creates GitHub issue linked to SPEC
      ↓
Bot creates branch, implements code
      ↓
Bot opens PR
      ↓
Bot waits / polls for human approval
      ↓
Human reviews and approves PR
      ↓
Bot detects approval
      ↓
Bot executes merge (squash)
      ↓
Org workflow archives SPEC
      ↓
Bot fallback: creates PR if blocked
```

## Design Decisions

| Decision | Rationale | Alternative |
|----------|----------|------------|
| Org workflow | One place to maintain, works across all repos | Per-repo actions - harder to maintain |
| Human triggers merge | Human stays in control, bot assists | Full auto-merge - loses human oversight |
| Bot cannot approve | Separation of concerns | Bot approves - defeats human review |
| SEPARATE Copilot SPEC | Review is complex enough to warrant its own spec | Bundle everything - scope creep |

## Out of Scope

- Auto-approval logic
- External tool integration (Jenkins, CircleCI)
- Multi-org support
- Review assignment automation

## Open Questions

1. ~~Should merge be triggered by a specific comment pattern?~~ → Human approves in UI, bot waits
2. Should the org workflow create a PR for status update or attempt direct push first?
   - **Recommendation**: Attempt direct push first, fallback to PR
3. How should we handle SPECs that don't have status updates (legacy)?
   - **Recommendation**: Skip update, log warning