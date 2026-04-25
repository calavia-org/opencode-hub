# Remote Config Loader

## Overview

Enable opencode to load configuration remotely from `https://opencode.calavia.org/.well-known/opencode.json` using OAuth flow.

## Motivation

Centralized configuration that users can fetch via OAuth. No local clones needed - all loaded from remote.

## Testing Protocol

### Test 1: Remote Config Availability
```bash
curl -sI https://opencode.calavia.org/.well-known/opencode.json
# Expected: 200 OK
```

### Test 2: Remote Components Availability
```bash
curl -sI https://opencode.calavia.org/agents/go-deployer.md
curl -sI https://opencode.calavia.org/skills/spec-driven/SKILL.md
# Expected: 200 OK
```

### Test 3: OAuth Config Loading
```bash
# In a fresh directory
opencode auth login  # Authenticate with GitHub
# After auth, OpenCode should fetch .well-known/opencode from issuer
```

## Requirements

- [ ] Test remote config accessible: `https://opencode.calavia.org/.well-known/opencode.json` → 200
- [ ] Test OAuth flow loads remote config
- [ ] Test MCP connectors work (github, context7)
- [ ] Test agents load from remote URLs
- [ ] Test skills load from remote URLs

## Debug Steps

1. Check remote config: `curl https://opencode.calavia.org/.well-known/opencode.json`
2. Watch OpenCode logs during `opencode auth login`
3. Verify components accessible individually

## Known Issues

- `https://opencode.calavia.org/agents/` returns 404 (directory index)
- Individual `.md` files accessible but directory scan may fail
- Need to verify OAuth flow actually fetches remote

## Test Results (to be filled)

### Test 1: Remote Config
```bash
curl -sI https://opencode.calavia.org/.well-known/opencode.json
# Result: 200 OK ✓
```

### Test 2: Remote Components
```bash
curl -sI https://opencode.calavia.org/agents/go-deployer.md
# Result: 200 OK ✓

curl -sI https://opencode.calavia.org/skills/spec-driven/SKILL.md  
# Result: 200 OK ✓

curl -sI https://opencode.calavia.org/agents/
# Result: 404 (needs fix)
```

## Tasks

- [ ] Test OAuth remote loading
- [ ] Document what works / what doesn't
- [ ] Fix issues found
- [ ] Update SPEC with final implementation

---

## Storage

`/.specs/012-remote-config-loader.md`

After completion, archive to `/.specs/archived/`.