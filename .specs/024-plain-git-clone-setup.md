---
name: plain-git-clone-setup
issue: "024"
status: approved
technology: "OpenCode/Spec-Driven"
agent: "opencode-implementer"
created: 2026-04-26
---

# Plain Git Clone Setup

## Overview

Simplify `setup.sh` to only clone the repository to `~/.config/opencode`. Remove all symlink and copy operations - the user clones the repo once and it works directly without any setup steps.

## Motivation

The current implementation:
1. Clones repository to a temp directory
2. Creates symbolic links to `~/.config/opencode`

This causes issues because:
- **OpenCode cannot load**: Symlinks are treated as external paths and blocked
- **Path resolution fails**: File paths resolve to symlink targets outside expected directories
- **Security restrictions**: OpenCode has policies preventing symlinked directories from loading

Users just want to `git clone` the repository to `~/.config/opencode` and have it work immediately.

## Requirements

- [ ] Remove ALL symbolic link creation from `setup.sh`
- [ ] Remove ALL file copy operations from `setup.sh`
- [ ] `setup.sh` only clones repository to `~/.config/opencode`
- [ ] Remove directory structure creation (cloned repo already has it)
- [ ] Document direct git clone workflow in setup.sh comments
- [ ] Enable CONTEXT7 MCP server by default in opencode.json
- [ ] Enable GitHub MCP server by default in opencode.json

## Acceptance Criteria

- [x] `git clone https://github.com/calavia-org/opencode-hub.git ~/.config/opencode` works directly
- [x] OpenCode loads and recognizes all agents/skills/modes/commands after clone
- [x] `setup.sh` clones repository to `~/.config/opencode` and does nothing else
- [x] `setup.sh --update` runs `git pull` in existing installation
- [x] `setup.sh --clean` removes installation (removes ~/.config/opencode directory)
- [x] No symbolic links exist anywhere in ~/.config/opencode
- [x] CONTEXT7 MCP server enabled by default (enabled: true)
- [x] GitHub MCP server enabled by default (enabled: true)

## Design Decisions

| Decision | Rationale | Alternative Considered |
|----------|----------|------------------------|
| Remove all symlink/copy operations | OpenCode treats symlinks as external, blocking load | Keep symlinks in different form |
| Clone directly to ~/.config/opencode | Eliminates temp directory and move operations | Clone to temp, then move |
| --update does git pull | Simple way to get latest changes | Recreate clone (slower) |
| Keep opencode.json from cloned repo | Has MCP enabled by default | Create separate global config |
| Remove global config creation in setup.sh | Cloned repo already has opencode.json | Keep creating global config |

## Tasks

- [x] Read current `setup.sh` implementation
- [x] Simplify `setup.sh` to only:
  - Clone repo directly to `~/.config/opencode` (not temp dir)
  - Remove symlink creation code
  - Remove copy operations
  - Remove directory structure creation
  - Remove global config creation (cloned repo has it)
- [x] Update `--update` to do `git pull` in `~/.config/opencode`
- [x] Update `--clean` to remove `~/.config/opencode` directory
- [x] Add documentation comments for direct git clone workflow
- [x] Test that `git clone` + OpenCode load works

## Dependencies

**External:** None

**Internal:** None (this is a standalone simplification)

## Out of Scope

- Changes to OpenCode core application
- MCP server configuration
- Token handling (already works)
- Any new features beyond setup simplification

## Open Questions

- None - the approach is straightforward