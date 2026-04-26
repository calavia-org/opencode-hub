# GitHub Workflow Rules

Fine-grained rules governing all GitHub interactions by agents and skills in this repository.

## Core Principles

All GitHub API interactions MUST use MCP tools. Direct API calls via GH CLI or curl are forbidden.

---

## Rule 1: Communication Method

**All GitHub API interactions MUST use MCP tools.**

| Allowed | Forbidden |
|---------|----------|
| github-mcp | `gh` CLI for API calls |
| Other MCP tools | `curl/wget` to api.github.com |

### Rationale
- MCP provides consistent interface
- Better error handling and retry logic
- Easier debugging and logging

---

## Rule 2: Token Separation

| Token | Usage |
|-------|-------|
| `OPENCODE_BOT_TOKEN` | Commits, PR creation, PR merge |
| `HUMAN_TOKEN` | Issue creation, PR reviews, comments |

### Rationale
- Principle of least privilege
- Security through separation
- Audit trail clarity

---

## Rule 3: Error Handling

**On MCP failure: STOP execution, do NOT fallback to forbidden methods.**

```
try:
    result = mcp_github.create_pull_request(...)
except MCPError as e:
    print(f"MCP failed: {e}")
    sys.exit(1)  # STOP - do not use gh CLI fallback
```

### Rationale
- Fail fast prevents data corruption
- Consistent error handling
- Clear problem reporting

---

## Rule 4: Copilot Review Workflow

**After PR is created, wait for Copilot comments.**

1. Create PR with `OPENCODE_BOT_TOKEN`
2. Wait for Copilot/PR review comments
3. If clear mistake → fix automatically
4. If doubt → ask for clarification in comment

### Don't
- Do NOT use `gh pr comment` as fallback
- Do NOT create manual commits to "help"

---

## Validation

To check codebase for forbidden patterns:

```bash
# Check for gh CLI usage
rg '\bgh\s+(issue|pr|api)' --type py

# Check for curl to GitHub API
rg 'curl.*api\.github\.com' --type py

# Check for prohibited patterns in scripts
rg '(gh|curl|wget).*(github|api)' scripts/
```

---

## Forbidden Patterns

```python
# WRONG - using gh CLI
os.system("gh pr create ...")

# WRONG - using curl
subprocess.run(["curl", "-H", f"Authorization: token {token}", ...])

# WRONG - direct API
requests.get("https://api.github.com/repos/...")


# CORRECT - using MCP
from github_mcp import GitHubClient
gh = GitHubClient(token=os.environ['OPENCODE_BOT_TOKEN'])
gh.create_pull_request(...)
```

---

## GitHub Actions

When running in GitHub Actions, use appropriate tokens:

```yaml
- name: Create PR
  env:
    BOT_TOKEN: ${{ secrets.OPENCODE_BOT_TOKEN }}
  run: |
    # Use MCP, not gh CLI
    python scripts/create_pr.py
```

---

## Exceptions

Any exceptions to these rules require:
1. Explicit approval in SPEC
2. Documented rationale
3. Security review

---

*Enforced by: SPEC #031 - GitHub Workflow Fine Grained*