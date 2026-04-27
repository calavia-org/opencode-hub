# Concept: Token System

**Core Idea**: Two-token architecture separates bot automation 
(`OPENCODE_BOT_TOKEN`) from human approvals (`HUMAN_TOKEN`).

**Key Points**:
- Bot token: Automation (create issues, PRs) - limited permissions
- Human token: Approvals/merges - full personal token permissions
- Additional: `CONTEXT7_API_KEY` for library documentation
- All tokens injected via environment variables in MCP config

**Quick Example**:
```bash
export OPENCODE_BOT_TOKEN="ghp_..."  # Bot automation
export HUMAN_TOKEN="ghp_..."          # Human approvals
export CONTEXT7_API_KEY="ctx7_..."    # Library docs
```

**Reference**: https://github.com/settings/tokens
**Related**: examples/github-workflow-validation.md, concepts/workflow-system.md
