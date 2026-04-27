---
name: fix-documents
issue: 023
status: approved
technology: opencode
agent: opencode-implementer
created: 2026-04-26
github: 023
---

# Fix Documents

## Overview

Update and reorganize all documentation to properly explain the SPEC-driven development workflow, document bot-account and HUMAN token procedures, and provide clear sequence diagrams for all workflows.

**Note**: SPECs are now context files stored in `.opencode/context/{category}/` (no `.specs/` directory)

## Motivation

The deployed documentation at opencode.calavia.org (currently only index.html) is incomplete. It only lists features without explaining the SPEC process. Additionally, token configuration for bot accounts and human approval flows needs proper documentation and testing.

## Requirements

- [ ] Reorganize documentation into specialized documents (README, workflows, API, etc.)
- [ ] Document bot-account setup procedure for OpenCode development
- [ ] Document HUMAN token setup and approval procedure
- [ ] Add sequence diagrams for all main workflows
- [ ] Ensure index.html explains SPEC-driven process end-to-end
- [ ] Test all documentation links and code examples

## Acceptance Criteria

- [ ] opencode.calavia.org explains SPEC-driven development workflow
- [ ] Bot account setup documented with step-by-step procedure
- [ ] HUMAN token procedure documented with approval flow
- [ ] All code examples in docs are tested and working
- [ ] index.html includes architecture diagram

## Design Decisions

| Decision | Rationale | Alternative |
|----------|----------|------------|
| Split docs into multiple pages | Better organization, each doc has clear purpose | Keep single page |
| Include Mermaid in index.html | Visual diagrams help understanding | Use external images |

## Tasks

- [ ] Review current README.md and index.html for gaps
- [ ] Create SPEC-process documentation page
- [ ] Create workflows/diagrams page with Mermaid sequences
- [ ] Create token-setup documentation page
- [ ] Update index.html to link to new docs and explain SPEC workflow
- [ ] Test all code examples
- [ ] Deploy and verify

## Dependencies

**External:** Mermaid.js (cdn.jsdelivr.net) - Already in use
**Internal:** None - This is a documentation-only task

## Out of Scope

- New agent implementations
- New skill development
- Infrastructure changes