# Token Setup for OpenCode Development

This guide explains how to set up the bot account and HUMAN token for OpenCode development.

## Overview

The system uses **two tokens + bot SSH key** for proper separation of concerns:

| Token | Variable | Purpose | Can Commit/Push | Can Approve | Can Merge |
|-------|----------|---------|------------------|-------------|-----------|
| Bot Token | `OPENCODE_BOT_TOKEN` | MCP API calls (issues, PRs) | ✅ Yes (SSH) | ❌ No | ❌ No |
| Bot SSH Key | SSH (bot) | Git operations (branch, commit, push) | ✅ Yes | ❌ No | ❌ No |
| Human Token | `HUMAN_TOKEN` | Reviews + approvals | ❌ No | ✅ Yes | ✅ Yes |

## Why Bot + Human Separation?

1. **Security**: Bot has limited permissions (no approval rights)
2. **Audit Trail**: Human actions clearly attributed (reviews, approvals)
3. **Approval Flow**: Bot does work → Human reviews → Human approves/merges
4. **Git Operations**: Bot SSH key for commits/pushes (bot does the work)
5. **MCP Operations**: Bot token for API calls (issues, PRs)

---

## Bot Account Setup

### Step1: Create GitHub Account + SSH Key

1. Go to [github.com/signup](https://github.com/signup)
2. Create account (e.g., `opencode-bot`)
3. Add to your organization with **Write** access
4. **Generate SSH key for bot**:
   ```bash
   ssh-keygen -t ed25519 -C "opencode-bot@github.com" -f ~/.ssh/opencode_bot
   ```
5. Add public key to bot's GitHub account: Settings → SSH and GPG keys → New SSH key

### Step2: Generate Fine-Grained PAT

1. Go to **Settings** → **Developer settings** → **Personal access tokens** → **Fine-grained tokens**
2. Click **Generate new token**
3. Configure:

| Setting | Value |
|----------|-------|
| Token name | `opencode-bot` |
| Expiration | 1 year |
| Resource owner | Your organization |
| Repository access | All repositories |

4. Set permissions:

| Permission | Access |
|------------|--------|
| Contents | Read and write |
| Pull requests | Read and write |
| Issues | Read and write |
| Commit statuses | Read and write |
| Workflows | Read and write |

### Step3: Add to Environment

```bash
# Bot token (MCP API calls)
echo 'export OPENCODE_BOT_TOKEN="ghp_xxxxxxxxxxxx"' >> ~/.zshrc

# Bot SSH key (git operations)
echo 'export GIT_SSH_COMMAND="ssh -i ~/.ssh/opencode_bot"' >> ~/.zshrc

# Reload
source ~/.zshrc
```

Or add as GitHub Secrets:
- `OPENCODE_BOT_TOKEN` (for MCP)
- `SSH_PRIVATE_KEY_BOT` (for git operations in Actions)

---

## Human Token Setup

### Step1: Use Your Personal Token

Your personal GitHub token has full permissions (reviews + approvals).

If you don't have one:
1. Go to **Settings** → **Developer settings** → **Personal access tokens** → **Tokens (classic)**
2. Click **Generate new token**
3. Select scopes:
   - `repo` (Full control of private repositories)
   - `read:org` (Read org and team membership)

### Step2: Add to Environment

```bash
# Human token (MCP reviews + approvals)
echo 'export HUMAN_TOKEN="ghp_xxxxxxxxxxxx"' >> ~/.zshrc

# Reload
source ~/.zshrc
```

Or add as GitHub Secret:
- Add `HUMAN_TOKEN` to repository secrets

---

## Alternative: Use Classic Token (Recommended)

If Fine-Grained tokens cause issues, use a **Classic token** instead:

1. Go to **Settings** → **Developer settings** → **Personal access tokens** → **Tokens (classic)**
2. Click **Generate new token**
3. Select scopes:
   - `repo` (Full control of private repositories)
   - `read:org` (Read org and team membership) ← Required for gh CLI

### Using Tokens with GitHub CLI

```bash
# Using bot token (requires read:org in Classic token)
export GITHUB_TOKEN="$OPENCODE_BOT_TOKEN"

# Using human token (has full permissions)
export GITHUB_TOKEN="$HUMAN_TOKEN"

# Verify
gh auth status
```

> **Note:** If you get `error validating token: missing required scope 'read:org'`, use your HUMAN_TOKEN instead of the Fine-Grained OPENCODE_BOT_TOKEN.

### Verify Bot Token

```bash
# Test bot token can create issues
curl -X POST -H "Authorization: token $OPENCODE_BOT_TOKEN" \
  -H "Accept: application/vnd.github.v3+json" \
  https://api.github.com/repos/calavia-org/opencode-hub/issues \
  -d '{"title":"Test issue","body":"Testing bot token"}'
```

### Verify Human Token

```bash
# Test human token can approve PRs
curl -H "Authorization: token $HUMAN_TOKEN" \
  -H "Accept: application/vnd.github.v3+json" \
  https://api.github.com/user
```

---

## MCP Configuration

### GitHub MCP Server

The system uses GitHub's official MCP server at `https://api.githubcopilot.com/mcp/` for all GitHub actions.

```json
{
  "mcp": {
    "github_bot": {
      "url": "https://api.githubcopilot.com/mcp/",
      "headers": {
        "Authorization": "Bearer {env:OPENCODE_BOT_TOKEN}"
      }
    },
    "github_human": {
      "url": "https://api.githubcopilot.com/mcp/",
      "headers": {
        "Authorization": "Bearer {env:HUMAN_TOKEN}"
      }
    }
  }
}
```

### Testing MCP Connection

```bash
# Test GitHub MCP with bot token
curl -s -X POST https://api.githubcopilot.com/mcp/ \
  -H "Authorization: Bearer $OPENCODE_BOT_TOKEN" \
  -H "Content-Type: application/json" \
  -H "Accept: text/event-stream, application/json" \
  -d '{"jsonrpc":"2.0","id":1,"method":"tools/list","params":{}}'
```

### Available MCP Tools

| Tool | Used By | Purpose |
|------|---------|---------|
| `create_issue` | Bot | Create issues |
| `create_pull_request` | Bot | Create PRs |
| `add_comment_to_pending_review` | Human | Add review comments |
| `approve_pull_request` | Human | Approve PRs |
| `merge_pull_request` | Human | Merge PRs |

---

## Environment Variables Summary

```bash
# Bot token (MCP API calls: issues, PRs)
export OPENCODE_BOT_TOKEN="ghp_..."

# Bot SSH key (git operations: branch, commit, push)
export GIT_SSH_COMMAND="ssh -i ~/.ssh/opencode_bot"

# Human token (MCP reviews + approvals)
export HUMAN_TOKEN="ghp_..."

# Additional
export CONTEXT7_API_KEY="ctx7_..."     # Library docs (optional)
```

**Who does what**:
- **Bot**: Commits/pushes via SSH → Creates PRs via MCP
- **Human**: Reviews via MCP → Approves/merges via MCP

---

## Troubleshooting

| Issue | Solution |
|-------|----------|
| Bot can't create issues | Check PAT permissions |
| Bot can't merge PRs | Ensure repo write access |
| Human can't approve | Use personal token, not bot |
| Actions fail | Verify token in GitHub secrets |

---

## Security Best Practices

1. **Never commit tokens** - Use environment variables or secrets
2. **Rotate tokens** - Set expiration dates
3. **Use minimal permissions** - Only what's needed
4. **Audit regularly** - Review token usage

---

## Related

- [SPEC Process](./SPEC-process.md)
- [Workflows & Diagrams](./workflows.md)
- [GitHub Repository](https://github.com/calavia-org/opencode-hub)