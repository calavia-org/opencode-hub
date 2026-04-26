#!/usr/bin/env python3
"""
Validate GitHub workflow rules compliance.

Checks for forbidden patterns:
- gh CLI commands for API calls
- curl/wget to api.github.com
- Direct API calls without MCP

Exit code 0 = passed, 1 = violations found
"""

import sys
import re
from pathlib import Path


# Forbidden patterns (in code, not comments)
PATTERNS = [
    (r'[^#]*\bgh\s+(issue|pr|api|repo|commit)', 'gh CLI for API operations'),
    (r'[^#]*curl.*api\.github\.com', 'curl to GitHub API'),
    (r'[^#]*wget.*api\.github\.com', 'wget to GitHub API'),
    (r'requests\.(get|post|put|patch|delete).*api\.github\.com', 'requests library to GitHub API'),
    (r'subprocess.*gh\s', 'subprocess calling gh CLI'),
]


def check_file(path: Path) -> list[tuple[int, str]]:
    """Check a file for forbidden patterns."""
    violations = []
    try:
        content = path.read_text()
    except Exception:
        return []
    
    lines = content.split('\n')
    for i, line in enumerate(lines, 1):
        # Skip comments and docstrings
        stripped = line.strip()
        if stripped.startswith('#') or stripped.startswith('"""') or stripped.startswith("'''"):
            continue
            
        for pattern, desc in PATTERNS:
            if re.search(pattern, line, re.IGNORECASE):
                violations.append((i, desc))
    
    return violations


def main():
    """Main validation function."""
    print("🔍 Checking GitHub workflow rules compliance...")
    print()
    
    extensions = {'.py', '.sh', '.yaml', '.yml', '.js', '.ts'}
    dirs = ['agents', 'skills', 'modes', 'commands', '.github']
    
    all_violations = []
    
    for dir_name in dirs:
        dir_path = Path(dir_name)
        if not dir_path.exists():
            continue
            
        for file_path in dir_path.rglob('*'):
            if file_path.is_file() and file_path.suffix in extensions:
                violations = check_file(file_path)
                if violations:
                    all_violations.append((str(file_path), violations))
    
    if all_violations:
        print("❌ VIOLATIONS FOUND:")
        print()
        for file_path, violations in all_violations:
            print(f"  📄 {file_path}")
            for line, desc in violations:
                print(f"    - Line {line}: {desc}")
            print()
        print(f"Total: {len(all_violations)} files with violations")
        return 1
    
    print("✅ No violations found!")
    print()
    print("All GitHub interactions use MCP.")
    return 0


if __name__ == '__main__':
    sys.exit(main())