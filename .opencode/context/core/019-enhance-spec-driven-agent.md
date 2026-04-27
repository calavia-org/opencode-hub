---
name: enhance-spec-driven-agent
issue: "019"
status: in_progress
technology: javascript
agent: javascript-implementer
created: 2026-04-25
---

# SPEC: Enhance Spec-Driven Agent

## Overview

Improve the spec-driven skill with MCP-based GitHub automation, intelligent agent inference from repository, and user approval workflow.

## Motivation

The spec-driven agent needs improvements to:
- Use MCP tools for GitHub operations
- Intelligently infer the appropriate agent from repository content
- Present agent suggestion to user for approval before proceeding
- Allow override when inference is incorrect

## Requirements

- [ ] Replace `gh` CLI patterns with MCP tool-based GitHub operations
- [ ] Implement repository technology inference from file patterns
- [ ] Present inferred agent to user for confirmation
- [ ] Allow user override to select different agent
- [ ] Add explicit confirmation step before agent assignment
- [ ] Support technology override via config or prompt
- [ ] Enhance SPEC template with agent assignment tracking
- [ ] Update opencode-hub repository with enhanced skill

## Acceptance Criteria

- [ ] Repository scanned for technology indicators (package.json, go.mod, requirements.txt, etc.)
- [ ] Agent inferred based on detected technology
- [ ] User presented with: "Detected [Python]. Use [python-implementer]? [Yes/Skip/Change]"
- [ ] Override command available: `/change-agent [agent-name]`
- [ ] SPEC includes `technology:` and `agent:` fields showing selected values
- [ ] Technology detection logged for transparency

## Design Decisions

| Decision | Rationale | Alternative Considered |
|---------|----------|------------------------|
| Inferred + Approved | Intelligent but user-controlled | Fully auto or fully manual |
| File pattern detection | Fast, no parsing needed | AST analysis |
| Confirmation prompt | Explicit user control | Silent acceptance |
| Config override | Flexibility for edge cases | Hard-coded only |
| SPEC-based multi-repo | Context-aware agent selection | Global detection |
| YAML frontmatter | Structured metadata, easy parsing | JSON block |

## Technology → Agent Mapping

| Detected | Inferred Agent |
|----------|---------------|
| `package.json`, `*.ts`, `*.tsx` | javascript-implementer |
| `requirements.txt`, `*.py` | python-implementer |
| `go.mod`, `*.go` | go-implementer |
| `pom.xml`, `build.gradle`, `*.java` | java-implementer |
| `*.tf` | terraform-implementer |
| `Cargo.toml`, `*.rs` | rust-implementer |
| `SPEC.md`, `SKILL.md`, `agents/` | opencode-implementer |
| Mixed/multiple | See Multi-Repo Handling |

### Multi-Repo Handling

For repositories with multiple technologies (monorepos), the technology to detect is determined by the **SPEC context**:

1. SPEC title/description hints at the relevant technology
2. Agent inference scoped to the feature being specified
3. User confirms: "Detected [Python] for this feature. Proceed?"

**Example:** A monorepo with both `go/` and `python/` directories. Creating a SPEC titled "Add ML pipeline" would infer `python-implementer` based on `requirements.txt` in `python/`.

## Tasks

- [x] Update `skills/spec-driven/SKILL.md` to use MCP tool patterns for GitHub ops
- [x] Document technology detection logic in SKILL.md
- [x] Add agent inference + approval workflow section
- [x] Create `/change-agent [name]` override command documentation
- [x] Update `SPEC.template.md` with YAML frontmatter (agent, technology)
- [x] Add agent tracking to context/{category}/ (SPEC files are context files)
- [x] Document config override for technology detection
- [x] Create pull request for enhanced spec-driven skill

## Dependencies

**External:**
- GitHub MCP integration (uses `gh` CLI via Bash tool for operations)
- `gh` CLI installed (required by MCP integration)

**Internal:**
- None (enhances existing infrastructure)

## Out of Scope

- Custom MCP server development
- Multi-repo support (file-based only)
- AST-based language detection (file patterns only)

## Implementation Notes

Detection is scoped per-SPEC and re-run on each session. No caching needed for MVP.
Confidence level not needed - pattern matching is deterministic.
Custom mappings can be added via `.opencode/config.yml`.