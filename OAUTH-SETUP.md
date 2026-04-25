# GitHub App OAuth Setup

This guide covers how to set up a custom GitHub App to restrict access to members of the `calavia-org` organization.

## Why Use a Custom GitHub App?

- **Organization restriction**: Only `calavia-org` members can authenticate
- **Custom OAuth flow**: Your own OAuth app, not OpenCode's default
- **Token control**: Full control over token permissions

## Step 1: Create a GitHub OAuth App

1. Go to GitHub **Settings** → **Developer settings** → **OAuth Apps** → **New OAuth App**
   - Or visit: https://github.com/settings/developers

2. Fill in the details:

   | Field | Value |
   |-------|-------|
   | Application name | Calavia OpenCode |
   | Homepage URL | https://opencode.calavia.org |
   | Authorization callback URL | `http://127.0.0.1:19876/mcp/oauth/callback` |

3. Click **Register application**

4. Note the:
   - **Client ID** (e.g., `Iv1.xxxxxxxxxxxxxxx`)

5. Generate a **Client secret**:
   - Click **Generate a new client secret**
   - Note the secret value (only shown once)

## Step 2: Restrict to Organization

After creating the OAuth App:

1. Go to your OAuth App settings
2. Under **Organization access**, select:
   - "Restrict access to certain organizations"
   - Choose `calavia-org`

This ensures only organization members can authorize.

## Step 3: Configure OpenCode

Add the auth configuration to your `opencode.json`:

```json
{
  "$schema": "https://opencode.ai/config.json",
  "auth": {
    "https://github.com": {
      "type": "wellknown",
      "clientId": "YOUR_CLIENT_ID",
      "clientSecret": "YOUR_CLIENT_SECRET"
    }
  }
}
```

Replace:
- `YOUR_CLIENT_ID` with your OAuth App's Client ID
- `YOUR_CLIENT_SECRET` with the client secret

## Step 4: Authenticate

Run the authentication command:

```bash
opencode auth login https://github.com
```

This will:
1. Redirect to GitHub OAuth authorization page
2. Only calavia-org members can authorize
3. After approval, tokens are stored in `~/.local/share/opencode/auth.json`

## Alternative: Using Auth0 for Organization Control

If you need more complex organization mapping (not just GitHub org), use Auth0:

### Step 1: Create Auth0 Tenant

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

1. In Auth0 Dashboard: **Authentication** → **Social**
2. Click **GitHub** and enable it
3. Configure with your GitHub OAuth App credentials

### Step 4: Restrict Organization

In Auth0 or GitHub settings, restrict to `calavia-org` members.

### Step 5: Configure OpenCode

```json
{
  "$schema": "https://opencode.ai/config.json",
  "auth": {
    "https://your-tenant.auth0.com": {
      "type": "wellknown",
      "clientId": "YOUR_AUTH0_CLIENT_ID",
      "clientSecret": "YOUR_AUTH0_CLIENT_SECRET"
    }
  }
}
```

## Environment Variables

You can also use environment variables to avoid hardcoding secrets:

```json
{
  "$schema": "https://opencode.ai/config.json",
  "auth": {
    "https://github.com": {
      "type": "wellknown",
      "clientId": "$OPENCODE_CLIENT_ID",
      "clientSecret": "$OPENCODE_CLIENT_SECRET"
    }
  }
}
```

Then in your shell:

```bash
export OPENCODE_CLIENT_ID="Iv1.xxxxxxxxxxxxxxx"
export OPENCODE_CLIENT_SECRET="your-client-secret"
```

## Troubleshooting

### "Organization access restricted" Error

Make sure your GitHub account is a member of `calavia-org`.

### "Invalid client" Error

Verify the Client ID and Client Secret are correct.

### Token Not Stored

Check permissions: `~/.local/share/opencode/auth.json` should exist after auth.

## Security Notes

- Never commit client secrets to version control
- Use environment variables in production
- Rotate secrets periodically
- Restrict OAuth App to minimum required scopes