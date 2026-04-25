# Remote Config Loader

**Status**: In Progress | **Issue**: #14

## Overview

Enable opencode to load configuration remotely from `https://opencode.calavia.org/.well-known/opencode.json`. Users from calavia-org organization should be able to configure their local opencode installations from this centralized hub without manual setup.

## Motivation

Currently, users need to manually configure their opencode environment by cloning the repo, creating config files, and setting up tokens. This is error-prone and time-consuming. By hosting the config at a well-known URL, a simple setup script can fetch and apply the configuration automatically.

## Requirements

- [ ] Host config at `https://opencode.calavia.org/.well-known/opencode.json`
- [ ] setup.sh fetches config from remote URL and applies it locally
- [ ] update.sh (if already setup) can update config without full re-clone
- [ ] Users only need to set their HUMAN_TOKEN (personal token)
- [ ] Other tokens (OPENCODE_BOT_TOKEN, CONTEXT7_API_KEY) should come from organization secrets or be configurable via environment
- [ ] MCP connectors configured automatically (github, context7)
- [ ] Works on fresh environment with single command

## Acceptance Criteria

- [ ] Fresh env: `curl -sL https://opencode.calavia.org/setup.sh | bash` succeeds
- [ ] After setup, config reflects content from remote `.well-known/opencode.json`
- [ ] User can start `opencode` immediately with org configuration
- [ ] MCP GitHub and context7 connectors are enabled
- [ ] User only needs to set HUMAN_TOKEN to use MCP features

## Design Decisions

| Decision | Rationale | Alternative Considered |
|----------|----------|------------------------|
| No auth on remote config | Enable easy onboarding, optional auth later | Full OIDC with Auth0 |
| Human token user-provided | Personal access, not shared | Shared bot token |
| Org secrets optional | Flexibility for users | Require all org secrets |
| MCP servers from remote | Centralized management | Per-user MCP config |

## Tasks

- [ ] Create/update `.well-known/opencode.json` with full MCP config
- [ ] Update `setup.sh` to fetch remote config
- [ ] Update `update.sh` to fetch remote config
- [ ] Test full setup flow on fresh environment
- [ ] Verify MCP connectors work (github, context7)
- [ ] Document setup requirements

## Dependencies

**External:**
- Vercel deployment of opencode-hub

**Internal:**
- Existing hub repositories (agents, skills, modes, commands)

## Out of Scope

- OIDC authentication flow (future enhancement)
- User-specific config overrides
- Multi-org support

## Open Questions

- Where to host OPENCODE_BOT_TOKEN for org? Vercel env vars?
- How to handle token rotation?

---

## Storage

Place this SPEC file in `/.specs/` directory with naming pattern:
`/.specs/{issue-number}-{feature-slug}.md`

Example: `/.specs/012-remote-config-loader.md`

After completion, archive to `/.specs/archived/`.