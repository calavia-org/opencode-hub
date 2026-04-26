# Token Setup for OpenCode Development

This guide explains how to set up the bot account and HUMAN token for OpenCode development.

## Overview

The system uses **two tokens** for proper separation of concerns:

| Token | Variable | Purpose | Can Approve | Can Merge |
|-------|----------|---------|-------------|-----------|
| Bot Token | `OPENCODE_BOT_TOKEN` | All automation tasks | ❌ No | ✅ Yes |
| Human Token | `HUMAN_TOKEN` | Human approval actions | ✅ Yes | ✅ Yes |

## Why Two Tokens?

1. **Security**: Bot token has limited permissions
2. **Audit Trail**: Human actions are clearly attributed
3. **Approval Flow**: PRs require human approval before merge
4. **Flexibility**: Human can override bot when needed

---

## Bot Account Setup

### Step 1: Create GitHub Account

1. Go to [github.com/signup](https://github.com/signup)
2. Create account (e.g., `opencode-bot`)
3. Add to your organization with **Write** access

### Step 2: Generate Fine-Grained PAT

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

### Step 3: Add to Environment

```bash
# Add to your shell profile
echo 'export OPENCODE_BOT_TOKEN="ghp_xxxxxxxxxxxx"' >> ~/.zshrc

# Reload
source ~/.zshrc
```

Or add as GitHub Secret:
- Repository settings → Secrets and variables → Actions
- Add `OPENCODE_BOT_TOKEN`

---

## Human Token Setup

### Step 1: Use Your Personal Token

Your personal GitHub token has full permissions.

If you don't have one:
1. Go to **Settings** → **Developer settings** → **Personal access tokens** → **Tokens (classic)**
2. Click **Generate new token**
3. Select scopes:
   - `repo` (Full control of private repositories)
   - `read:user` (Read user profile data)

### Step 2: Add to Environment

```bash
# Add to your shell profile
echo 'export HUMAN_TOKEN="ghp_xxxxxxxxxxxx"' >> ~/.zshrc

# Reload
source ~/.zshrc
```

Or add as GitHub Secret:
- Add `HUMAN_TOKEN` to repository secrets

---

## Testing the Setup

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

## Environment Variables Summary

```bash
# Required
export GITHUB_TOKEN="ghp_..."           # Default token (fallback)

# Optional (recommended for two-token setup)
export OPENCODE_BOT_TOKEN="ghp_..."     # Bot automation
export HUMAN_TOKEN="ghp_..."           # Human approvals

# Additional
export CONTEXT7_API_KEY="ctx7_..."     # Library docs (optional)
```

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