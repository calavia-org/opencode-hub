---
name: github-workflow-fine-grained
issue: "031"
status: approved
technology: OpenCode/Spec-Driven
agent: opencode-implementer
created: 2026-04-26
---

# GitHub Workflow Fine Grained

## Overview
Establishes explicit rules governing all GitHub interactions by agents and skills in this repository. Enforces MCP-based communication, token separation, error handling, and Copilot review workflows.

## Motivation
Currently, agents may use various methods (GH CLI, curl, direct API calls) to interact with GitHub. This creates inconsistent behavior, security risks, and makes debugging difficult. This SPEC standardizes all interactions to ensure:
1. Consistent, maintainable workflows
2. Proper token separation for security
3. Clear error handling and recovery paths
4. Human-in-the-loop reviews for quality

## Requirements
- [ ] All GitHub API interactions MUST use MCP tools (github-mcp or similar)
- [ ] GH CLI commands (gh) are forbidden for direct API calls
- [ ] curl/wget to GitHub API endpoints is forbidden
- [ ] OPENCODE_BOT_TOKEN usage: commits, PR creation, PR merge
- [ ] HUMAN_TOKEN usage: issue creation, PR reviews, comments
- [ ] On MCP failure: STOP execution, report error, do NOT fallback to forbidden methods
- [ ] After PR created: wait for Copilot comments, fix clear mistakes, ask clarification for doubts
- [ ] SPEC status updated to `completed` after merge (no archiving, stays in context/{category}/)

## Acceptance Criteria
- [ ] No gh CLI commands found in codebase for API operations
- [ ] No curl/wget calls to api.github.com in agents/skills
- [ ] Token usage follows specification (BOT vs HUMAN)
- [ ] MCP failure stops execution with clear error message
- [ ] Copilot comment handling workflow documented
- [ ] GitHub Action automates SPEC archival

## Design Decisions

| Decision | Rationale | Alternative |
|----------|----------|------------|
| MCP-only for API | Consistent interface, better error handling, retry logic | GH CLI, direct API |
| Token separation | Principle of least privilege, security | Single token |
| Stop on MCP failure | Fail fast, prevent data corruption | Fallback methods |
| Action-based archival | Automation, consistency | Manual process |

## Tasks
- [ ] Document these rules in a central location (e.g., `docs/github-workflow-rules.md`)
- [ ] Create validation script to check for forbidden patterns
- [ ] Update existing agents to use MCP instead of gh CLI
- [ ] Update existing skills to use MCP instead of curl
- [ ] Create GitHub Action workflow for SPEC archival
- [ ] Add workflow_dispatch trigger for manual archival

## Dependencies
**External:** github-mcp server, proper token configuration
**Internal:** All existing agents and skills

## Out of Scope
- Runtime token rotation (future enhancement)
- Multi-repo support (future enhancement)
- Custom MCP server development (assume existing solutions)

## Implementation Notes

### Token Configuration
```yaml
# .github/workflows/spec-archive.yml
permissions:
  contents: write
  issues: write
  pull-requests: write
```

### MCP Usage Pattern
```python
# Use MCP tool, NOT gh CLI
from github import GitHub
gh = GitHub(token=os.environ['OPENCODE_BOT_TOKEN'])
gh.create_commit(repo, message, content)
```

### Error Handling
```python
try:
    result = mcp_github.create_pull_request(...)
except MCPError as e:
    print(f"MCP failed: {e}")
    sys.exit(1)  # STOP - do not fallback
```