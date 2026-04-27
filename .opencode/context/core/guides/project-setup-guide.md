<!-- Context: core/guides | Priority: high | Version: 1.0 | Updated: 2026-04-27 -->

# Project Setup Guide

**Purpose**: Set up a new project with opencode-hub SPEC-driven workflow

---

## Quick Routes

| Task | Path |
|------|------|
| **New project setup** | This file |
| **SPEC process** | `spec-process-guide.md` |
| **GitHub workflow** | `github-workflow-rules.md` |
| **Token setup** | `../openagents-repo/guides/adding-skill-basics.md` |

---

## Overview

This guide shows how to configure a **new project** to use:
- ✅ OpenAgentsControl agents (inherited via URL)
- ✅ SPEC-driven development workflow
- ✅ Conventional commits + squash merge
- ✅ Bot SSH key + Human approval separation

---

## Step 1: Create Project Repository

```bash
# Create new repo on GitHub (via UI or gh CLI)
gh repo create my-new-project --private

# Clone locally
git clone git@github.com:your-org/my-new-project.git
cd my-new-project
```

---

## Step 2: Add `.well-known/opencode.json`

Create the discovery file:

```bash
mkdir -p .well-known
```

**File**: `.well-known/opencode.json`

```json
{
  "$schema": "https://opencode.ai/config.json",
  "version": 3,
  "name": "My New Project",
  "baseUrl": "https://my-project.com",
  "defaultAgent": "spec-driven",
  "defaultMode": "spec-driven",
  "agents": "https://opencode.calavia.org/agents",
  "modes": "https://opencode.calavia.org/modes",
  "skills": "https://opencode.calavia.org/skills",
  "commands": "https://opencode.calavia.org/commands",
  "mcp": {
    "github_bot": {
      "type": "remote",
      "url": "https://api.githubcopilot.com/mcp/",
      "enabled": true,
      "description": "Bot automation - creates branches, PRs, merges after human approval",
      "requestInit": {
        "headers": {
          "Authorization": "Bearer {env:OPENCODE_BOT_TOKEN}"
        }
      }
    },
    "github_human": {
      "type": "remote",
      "url": "https://api.githubcopilot.com/mcp/",
      "enabled": true,
      "description": "Human actions - approves PRs, merges",
      "requestInit": {
        "headers": {
          "Authorization": "Bearer {env:HUMAN_TOKEN}"
        }
      }
    },
    "context7": {
      "type": "remote",
      "url": "https://mcp.context7.com/mcp",
      "enabled": true,
      "headers": {
        "CONTEXT7_API_KEY": "{env:CONTEXT7_API_KEY}"
      }
    }
  }
}
```

**Key**: This inherits ALL OpenAgentsControl agents + your `spec-driven` agent.

---

## Step 3: Set Up Bot Account + SSH Key

### 3.1 Create Bot GitHub Account

1. Go to [github.com/signup](https://github.com/signup)
2. Create account (e.g., `my-project-bot`)
3. Add to your organization with **Write** access

### 3.2 Generate SSH Key for Bot

```bash
# On your machine (or CI server)
ssh-keygen -t ed25519 -C "my-project-bot@github.com" -f ~/.ssh/my_project_bot

# Add public key to bot's GitHub account:
# Bot: Settings → SSH and GPG keys → New SSH key
# Paste contents of ~/.ssh/my_project_bot.pub
```

### 3.3 Generate Bot MCP Token

1. Log in as bot account
2. Go to **Settings** → **Developer settings** → **Personal access tokens** → **Fine-grained tokens**
3. Click **Generate new token**

| Setting | Value |
|----------|-------|
| Token name | `my-project-bot` |
| Expiration | 1 year |
| Resource owner | Your organization |
| Repository access | Only select repositories → `my-new-project` |

**Permissions**:

| Permission | Access |
|------------|--------|
| Contents | Read and write |
| Pull requests | Read and write |
| Issues | Read and write |
| Commit statuses | Read and write |
| Workflows | Read and write |

4. Copy token (e.g., `ghp_xxxxxxxx`)
5. Add to GitHub Secrets:
   - Repository settings → Secrets and variables → Actions
   - Add `OPENCODE_BOT_TOKEN` = `ghp_xxxxxxxx`
   - Add `SSH_PRIVATE_KEY_BOT` = contents of `~/.ssh/my_project_bot`

---

## Step 4: Set Up Human Token

1. Go to **Your personal account** → **Settings** → **Developer settings** → **Personal access tokens** → **Tokens (classic)**
2. Click **Generate new token**

| Setting | Value |
|----------|-------|
| Token name | `my-project-human` |
| Scopes | `repo` (Full control), `read:org` |

3. Copy token (e.g., `ghp_yyyyyyyy`)
4. Add to GitHub Secrets:
   - Add `HUMAN_TOKEN` = `ghp_yyyyyyyy`

---

## Step 5: Set Up Context System

### 5.1 Copy from opencode-hub (Recommended)

```bash
# Copy context structure from opencode-hub
cp -r /path/to/opencode-hub/.opencode/context .opencode/context/
```

### 5.2 Create Minimal Structure (Alternative)

```bash
mkdir -p .opencode/context/core/{concepts,examples,guides,lookup,standards,workflows}
mkdir -p .opencode/context/core/{specs,system,config,task-management}
mkdir -p .opencode/context/development/{specs,principles,frontend,backend,ai}
mkdir -p .opencode/context/ui/web/{design,animation}
mkdir -p .opencode/context/{project-intelligence,openagents-repo}
```

### 5.3 Add Project-Specific Context

**File**: `.opencode/context/project-intelligence/business-domain.md`

```markdown
# Business Domain

**Project**: My New Project
**Purpose**: [What your project does]
**Domain**: [e.g., E-commerce, SaaS, etc.]
```

**File**: `.opencode/context/project-intelligence/technical-domain.md`

```markdown
# Technical Domain

**Stack**: [e.g., Next.js, Python, PostgreSQL]
**Architecture**: [e.g., Microservices, Monolith]
```

---

## Step 6: Configure Branch Protection (Squash Merge Only)

1. Go to repo **Settings** → **Branches**
2. Click **Add branch protection rule**
3. Configure:

| Setting | Value |
|----------|-------|
| Branch name pattern | `main` (or `master`) |
| Restrict pushes | ✅ Enabled |
| Require pull request reviews | ✅ Enabled |
| Required approvals | 1 |
| Allow squash merges only | ✅ Enabled |
| Disable merge commits | ✅ Enabled |
| Disable rebase merges | ✅ Enabled |

**Why**: Clean history, `CHANGELOG.md` auto-generation from conventional commits.

---

## Step 7: Add Conventional Commits (Optional - for CHANGELOG.md)

### 7.1 Install commitlint (if using Node.js)

```bash
npm install --save-dev @commitlint/cli @commitlint/config-conventional
```

**File**: `.commitlintrc.json`

```json
{
  "extends": ["@commitlint/config-conventional"]
}
```

### 7.2 Add commit-msg Hook

```bash
npx husky install
npx husky add .husky/commit-msg 'npx --no -- commitlint --edit $1'
```

**Now commits must follow**:
```bash
feat(auth): add JWT - Closes #123
fix(api): resolve timeout - Closes #456
docs(readme): update guide - Closes #789
```

---

## Step 8: Test the Setup

### 8.1 Create First SPEC

```bash
# Start agent (spec-driven will be loaded automatically)
# User: "I need to add user authentication"

# Agent will:
# 1. Create .opencode/context/development/001-add-auth.md
# 2. Create GitHub Issue (via github_bot MCP)
# 3. Create branch (via bot SSH)
# 4. Delegate to {lang}-implementer (from OpenAgentsControl)
# 5. Create PR (via github_bot MCP)
# 6. Wait for human approval (via github_human MCP)
# 7. Squash merge → CHANGELOG.md auto-updated
```

### 8.2 Verify Workflow

```bash
# Check SPEC was created
ls .opencode/context/development/001-add-auth.md
# → 001-add-auth.md (status: completed)

# Check GitHub Issue
gh issue list --label spec

# Check PR
gh pr list --label spec

# Check CHANGELOG.md was updated
cat CHANGELOG.md
# → Should include "feat(auth): add JWT - Closes #123"
```

---

## Environment Variables (for local dev)

```bash
# Bot token (MCP API calls)
export OPENCODE_BOT_TOKEN="ghp_xxxxxxxx"

# Bot SSH key (git operations)
export GIT_SSH_COMMAND="ssh -i ~/.ssh/my_project_bot"

# Human token (MCP reviews + approvals)
export HUMAN_TOKEN="ghp_yyyyyyyy"

# Optional: Context7 for library docs
export CONTEXT7_API_KEY="ctx7_..."

# Reload
source ~/.zshrc
```

---

## Success Checklist

- [ ] `.well-known/opencode.json` created
- [ ] Bot account + SSH key configured
- [ ] `OPENCODE_BOT_TOKEN` added to secrets
- [ ] `SSH_PRIVATE_KEY_BOT` added to secrets
- [ ] `HUMAN_TOKEN` added to secrets
- [ ] Context system copied/created
- [ ] Branch protection: squash merge ONLY enabled
- [ ] Conventional commits enforced (optional)
- [ ] First SPEC created successfully
- [ ] First PR squashed + `CHANGELOG.md` updated

---

## Troubleshooting

### Issue: "MCP failed: Unauthorized"

**Solution**: Check bot token has correct scopes + is added to secrets.

### Issue: "SSH key permission denied"

**Solution**: Verify:
1. Public key added to bot's GitHub account
2. Private key added to repo secrets as `SSH_PRIVATE_KEY_BOT`
3. `GIT_SSH_COMMAND` uses correct key path

### Issue: "Conventional commit format invalid"

**Solution**: Ensure commits follow `<type>(<scope>): <desc> - Closes #N`:
```bash
git commit -m "feat(auth): add JWT - Closes #123"
```

### Issue: "Merge commits not allowed"

**Solution**: This is correct! Only squash merges are allowed. Click "Squash and merge" in PR.

---

## Related Context

- **SPEC Process**: `spec-process-guide.md`
- **GitHub Workflow**: `github-workflow-rules.md`
- **Token System**: `../concepts/token-system.md`
- **Agent Architecture**: `../concepts/agent-architecture.md`
- **OpenAgentsControl**: `https://github.com/calavia-org/opencode-hub`

---

**Last Updated**: 2026-04-27
**Version**: 1.0
