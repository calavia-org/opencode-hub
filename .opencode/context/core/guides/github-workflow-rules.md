# Guide: GitHub Workflow Rules

**Purpose**: Rules governing all GitHub interactions by agents and skills

## Rule 1: MCP-Only Communication (GitHub API)

All **GitHub API interactions** MUST use MCP tools. Forbidden: `gh` CLI, `curl`, `wget`, direct API calls.

**Git Operations Exception**: MCP does NOT provide git tools (branch, commit, push). Git operations via SSH key are allowed as a documented exception.

| Allowed | Forbidden |
|---------|-----------|
| github_bot MCP | `gh` CLI for API |
| github_human MCP | `curl/wget` to api.github.com |
| Git via SSH (exception) | `gh` CLI for git operations |

## Rule 1b: Conventional Commits (MANDATORY)

All commits MUST follow conventional format:
```
<type>(<scope>): <description> - Closes #<issue>
```

**Types**: `feat`, `fix`, `docs`, `chore`, `refactor`, `test`, `style`, `perf`

**Examples**:
```
feat(auth): add JWT - Closes #123
fix(api): resolve timeout - Closes #456
docs(readme): update guide - Closes #789
```

**Enforcement**: Branch protection requires conventional commits.

## Rule 1c: Squash Merge Only

**ALL PRs MUST use squach merge** (no merge commits allowed).

**Branch Protection**:
- Squach merge: ✅ Enabled
- Merge commits: ❌ Disabled
- Rebase: ❌ Disabled

**Why**: Clean history, CHANGELOG.md auto-generation from conventional commits.

## Rule 2: Token Separation

| Token | Usage |
|-------|-------|
| `OPENCODE_BOT_TOKEN` | Commits, PR creation, merge |
| `HUMAN_TOKEN` | Issue creation, reviews, comments |

## Rule 3: Error Handling

On MCP failure: STOP execution, do NOT fallback to forbidden methods.

```python
try:
    result = mcp_github.create_pull_request(...)
except MCPError as e:
    print(f"MCP failed: {e}")
    sys.exit(1)  # STOP
```

## Rule 4: Copilot Review

After PR creation: Wait for Copilot comments → Fix issues → Proceed.

## Validation

```bash
# Check for forbidden patterns
rg '\bgh\s+(issue|pr|api)' --type py
rg 'curl.*api\.github\.com' --type py
```

**Reference**: https://github.com/calavia-org/opencode-hub
**Related**: concepts/workflow-system.md, examples/github-workflow-validation.md
