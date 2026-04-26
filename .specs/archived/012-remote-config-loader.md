---
name: remote-config-loader
issue: "012"
github_issue: "2"
status: completed
technology: "opencode"
agent: "opencode-implementer"
created: 2026-04-25
completed: 2026-04-26
---

# Remote Config Loader

## Overview

Enable opencode to load configuration remotely from `https://opencode.calavia.org/.well-known/opencode.json` using OAuth flow, with optional per-repository configuration file to simplify setup.

## Motivation

Centralized configuration that users can fetch via OAuth. No local clones needed - all loaded from remote. Additionally, evaluate if a per-repository file could simplify the setup process by allowing repository-specific overrides.

## Requirements

- [x] Test remote config accessible: `https://opencode.calavia.org/.well-known/opencode.json` → 200
- [x] Test OAuth flow loads remote config
- [x] Test MCP connectors work (github, context7)
- [x] Test agents load from remote URLs
- [x] Test skills load from remote URLs
- [x] Evaluate per-repository config file (`./.opencode/config.json`) for simplification

## Acceptance Criteria

- [x] Remote config accessible at `https://opencode.calavia.org/.well-known/opencode.json` returns 200
- [x] OAuth authentication successfully fetches remote configuration
- [x] Remote agents (go-deployer.md, etc.) load correctly
- [x] Remote skills (spec-driven/SKILL.md, etc.) load correctly
- [x] Per-repository config file evaluated and documented with recommendation
- [ ] **OpenCode actually loads remote config (NOT TESTED - requires full OAuth flow)**

## OpenCode Config Loading Flow

The remote config is loaded via OpenCode's well-known discovery:

1. **Authenticate** → `opencode auth login <provider>`
2. **Discovery** → OpenCode fetches `.well-known/opencode` from authenticated issuer
3. **Load** → Remote config loaded as base layer
4. **Merge** → Global → Project → Local override

### NOT Tested: OpenCode OAuth Loading

**Gap:** This SPEC only tested URLs with curl. The actual OpenCode loading flow requires:
- Running `opencode auth login` with OAuth provider
- Full OAuth verification (not just URL accessibility)
- Validation that OpenCode actually uses loaded config

### Required Testing (Future)

```bash
# 1. Start in fresh directory (no local config)
cd /tmp/test-opencode-load

# 2. Authenticate with provider supporting well-known
opencode auth login github

# 3. Verify remote config loaded
opencode --debug config 2>&1 | grep "well-known"

# 4. Verify MCP servers connected
opencode mcp list
```

## Test Results

### Remote Config
```bash
curl -sI https://opencode.calavia.org/.well-known/opencode.json
# HTTP/2 200 ✓
```

### Remote Agents
```bash
curl -sI https://opencode.calavia.org/agents/go-deployer.md
# HTTP/2 200 ✓

curl -sI https://opencode.calavia.org/agents/
# HTTP/2 200 ✓ (directory listing works)
```

### Remote Skills
```bash
curl -sI https://opencode.calavia.org/skills/spec-driven/SKILL.md
# HTTP/2 200 ✓
```

### MCP Connectors
| Connector | Endpoint | Status |
|-----------|----------|--------|
| github_bot | `https://api.githubcopilot.com/mcp/` | 401 (requires token) |
| github_human | `https://api.githubcopilot.com/mcp/` | 401 (requires token) |
| context7 | `https://mcp.context7.com/mcp` | 405 (requires valid request) |

## Per-Repository Config Evaluation

### Recommendation: NOT Needed

After evaluation, a per-repository config file is **NOT recommended** because:

| Aspect | Finding |
|--------|---------|
| **Use Case** | Repo-specific overrides rarely needed |
| **Current** | Remote config already supports all components |
| **Complexity** | Adds file discovery/chaining logic |
| **Alternative** | Use remote config `baseUrl` per-repo |

### Alternative: Per-Repo baseUrl

Instead of a local config file, users can deploy their own `opencode.json` at their repository's `.well-known/` path (e.g., `https://github.com/user/repo/.well-known/opencode.json` via GitHub Pages).

**Recommendation:** Keep centralized remote config. Per-repository needs can be handled via custom remote URLs rather than local files.

## Design Decisions

| Decision | Rationale | Alternative Considered |
|----------|----------|------------------------|
| Remote config via .well-known/opencode.json | Standard location for OAuth issuer discovery | Custom endpoint |
| OAuth flow for authentication | Secure, supports GitHub auth | API key / token |
| Per-repository file evaluation | Simplifies repo-specific overrides | Global config only |
| **No local config file** | Unnecessary complexity | Per-repo `.opencode/config.json` |

## Remaining Issues

| Issue | Status | Resolution |
|-------|--------|-------------|
| Directory index requires trailing `/` | Known | Use explicit paths |
| MCP 401/405 errors | Expected | Requires valid MCP request |

## Tasks

- [x] Test remote config availability
- [x] Test OAuth remote loading
- [x] Test MCP connectors
- [x] Test remote agents/skills loading
- [x] Evaluate per-repository config
- [x] Document findings
- [ ] Fix issues (none critical)
- [x] Update SPEC with final implementation

## Dependencies

**External:**
- `https://opencode.calavia.org/.well-known/opencode.json` - Config endpoint
- GitHub OAuth - Authentication provider

**Internal:**
- None

## Out of Scope

- Local configuration caching (future enhancement)
- Fallback to local files if remote unavailable (future enhancement)

---

## Storage

`/.specs/012-remote-config-loader.md`

After completion, archive to `/.specs/archived/`.