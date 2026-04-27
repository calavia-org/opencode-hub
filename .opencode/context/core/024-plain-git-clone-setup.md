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

## MOTIVATION

The current implementation:
1. Clones repository to a temp directory
2. Creates symbolic links to `~/.config/opencode`

This causes issues because:
- **OpenCode cannot load**: Symlinks are treated as external paths and blocked
- **Path resolution fails**: File paths resolve to symlink targets outside expected directories

## REQUIREMENTS

- [x] Remove ALL symbolic link creation from `setup.sh`
- [x] Remove ALL file copy operations from `setup.sh`
- [x] `setup.sh` only clones repository to `~/.config/opencode`
- [x] Remove directory structure creation (cloned repo already has it)
- [x] Document direct git clone workflow
- [x] Enable CONTEXT7 MCP server by default in opencode.json (already enabled)
- [x] Enable GitHub MCP server by default in opencode.json (already enabled)
- [x] Add GitHub MCP as MANDATORY RULE to all agents
- [x] Add CONTEXT7 MCP as MANDATORY RULE to all agents

## ACCEPTANCE CRITERIA

- [x] `git clone https://github.com/calavia-org/opencode-hub.git ~/.config/opencode` works directly
- [x] OpenCode loads after plain clone (no symlinks)
- [x] `setup.sh --update` runs `git pull`
- [x] `setup.sh --clean` removes directory
- [x] No symbolic links anywhere
- [x] MCP servers enabled by default
- [x] All agents have GitHub MCP + CONTEXT7 rules

## TASKS

- [x] Simplify setup.sh (226→37 lines)
- [x] Add MCP rules to spec-driven skill
- [x] Add MCP rules to spec-driven mode  
- [x] Add MCP rules to all agents (implementer, tester, verifier, deployer)
- [x] Test git clone works

## MANDATORY RULES ADDED

### GitHub MCP Rule
**RULE:** ALL GitHub interactions MUST use MCP (github_bot or github_human). Never use gh CLI or direct API calls.

### CONTEXT7 Rule
**RULE:** ALWAYS use Context7 MCP for documentation lookup. Never rely on training data alone.

Agents updated:
- python-implementer, python-tester, python-verifier, python-deployer
- go-implementer, go-tester, go-verifier, go-deployer
- java-implementer, java-tester, java-deployer
- terraform-implementer, terraform-tester, terraform-verifier
- spec-driven (primary agent)

Skills/Modes updated:
- spec-driven skill
- spec-driven mode