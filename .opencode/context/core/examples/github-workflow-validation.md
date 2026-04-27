# Example: GitHub Workflow Validation

**Purpose**: Python script to validate MCP-only GitHub API interactions

**Code**:
```python
#!/usr/bin/env python3
"""Validate GitHub workflow rules compliance."""
import sys, re
from pathlib import Path

PATTERNS = [
    (r'[^#]*\bgh\s+(issue|pr|api)', 'gh CLI for API operations'),
    (r'[^#]*curl.*api\.github\.com', 'curl to GitHub API'),
    (r'requests\.(get|post).*api\.github\.com', 'requests to GitHub API'),
]

def check_file(path: Path) -> list:
    violations = []
    content = path.read_text()
    for i, line in enumerate(content.split('\n'), 1):
        if line.strip().startswith('#'): continue
        for pattern, desc in PATTERNS:
            if re.search(pattern, line, re.IGNORECASE):
                violations.append((i, desc))
    return violations

# Check agents/, skills/, modes/, commands/, .github/
# NOTE: Git operations (git checkout, commit, push) are EXEMPT
#       (no MCP tools exist for git)
```

**Usage**: `python tools/validate_github_workflow.py`
**Note**: Git operations via SSH are allowed (no MCP equivalent)
**Reference**: https://github.com/calavia-org/opencode-hub
**Related**: guides/github-workflow-rules.md, concepts/workflow-system.md
