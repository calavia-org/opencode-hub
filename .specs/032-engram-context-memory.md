---
name: engram-context-memory
issue: "033"
status: approved
technology: "documentation"
agent: "opencode-implementer"
created: 2026-04-26
---

# Engram Integration for Context Memory

## Overview

Integrate Engram to provide persistent context memory for this OpenCode Hub. Engram is a brain-inspired context database that stores typed memories (episodic, semantic, procedural) and provides recall via MCP tools.

## Motivation

Currently, OpenCode sessions start fresh without context from previous conversations. This leads to:
- Repeated explanations of user preferences
- Lost project-specific knowledge
- No continuity across sessions

Engram solves this by providing persistent memory that:
- Survives sessions
- Provides semantic search
- Auto-manages memory lifecycle (hot/cold/archive)

## Requirements

- [ ] Install Engram binary (`brew install engram` or download)
- [ ] Run `engram setup opencode` to configure MCP integration
- [ ] Document installation in MCP-SETUP.md
- [ ] Verify 13 memory tools available in OpenCode

## Acceptance Criteria

- [ ] `engram setup opencode` completes without errors
- [ ] Engram MCP entry present in opencode.json
- [ ] `engram serve` starts HTTP API (default port 7437)
- [ ] Memory tools callable via MCP (mem_put, mem_search, etc.)
- [ ] Documentation updated in MCP-SETUP.md with setup instructions

## Design Decisions

| Decision | Rationale | Alternative Considered |
|----------|----------|------------------------|
| Use `engram setup opencode` | One-command full setup with plugin | Manual MCP-only config |
| Default port 7437 | Standard Engram port | Custom port |
| Enable for global config | Shared memory across repos | Per-repo config |

## Tasks

- [x] Update MCP-SETUP.md with Engram setup instructions
- [x] Document available memory tools
- [ ] Verify integration works

## Dependencies

**External:**
- Engram binary (https://github.com/softmaxdata/engram)
- OpenCode with MCP support

**Internal:**
- None (documentation-only change)

## Out of Scope

- Installing Engram binary (user responsibility)
- Setting up external Engram service
- Custom memory type configuration

## Open Questions

- Which memory types should auto-sync across sessions?
- Should we use local SQLite or cloud Engram service?
- Any specific context to exclude from memory?