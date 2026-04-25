# GitHub App OAuth Setup

This guide covers how to set up GitHub OAuth for the `calavia-org` organization.

## Current Limitation

OpenCode's `auth login` command uses the built-in GitHub OAuth App (by Anomaly). You **cannot** customize the OAuth App client ID via config.

To restrict access to `calavia-org` members, use the **Organization OAuth App Policy**.

## Option 1: Organization Approval (Recommended)

This restricts access to only approved members.

### Step 1: Ensure OAuth App is Owned by Organization

Transfer the Calavia OpenCode OAuth App to your organization (if not done already).

### Step 2: Enable Organization Restrictions

1. Go to: https://github.com/organizations/calavia-org/settings/oauth_application_policy
2. Click **Restrict third-party application access**
3. Now users must request approval to use OAuth apps

### Step 3: First Authentication Flow

1. A member runs: `opencode auth login` (select GitHub)
2. Authorize with their GitHub account
3. A request appears in org settings
4. You approve the app for the organization

### Step 4: Configure Member Access

In org settings, configure:
- **Members and outside collaborators**: Can request access
- Or restrict to **Members only** / **Disable app access requests**

## Option 2: Auth0 as Intermediary

If you need full control over the OAuth flow:

### Step 1: Create Auth0 Account

1. Go to https://auth0.com and sign up
2. Create a new tenant

### Step 2: Create Application

1. **Applications** → **Create Application**
2. Name: "Calavia OpenCode"
3. Type: **Regular Web Application**
4. **Settings**:
   - Callback URL: `http://127.0.0.1:19876/mcp/oauth/callback`
   - Logout URL: `http://127.0.0.1:19876`

### Step 3: Configure GitHub Connection

1. In Auth0: **Authentication** → **Social**
2. Enable GitHub and configure with your GitHub OAuth App credentials

### Step 4: Restrict Organization

In Auth0 or GitHub settings, restrict to `calavia-org` members.

### Step 5: Use Auth0 for Login

```bash
opencode auth login https://your-tenant.auth0.com
```

## Environment Variables (for MCP)

For MCP GitHub access (not login), use environment variables:

```bash
export GITHUB_TOKEN="ghp_YourTokenHere"
```

For bot/human separation (see MCP-SETUP.md):

```bash
export OPENCODE_BOT_TOKEN="ghp_YourBotToken"
export HUMAN_TOKEN="ghp_YourHumanToken"
```

## Security Notes

- Never commit tokens to version control
- Use environment variables in production
- Rotate tokens periodically
- Restrict at organization level for security