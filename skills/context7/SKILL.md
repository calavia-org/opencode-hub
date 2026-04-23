---
name: context7
description: Context7 MCP integration for up-to-date library documentation.
---

# Context7 Skill

Get up-to-date library documentation directly in your coding sessions.

## Overview

Context7 provides current, version-specific documentation for libraries via MCP. Use this skill to fetch accurate, up-to-date code examples instead of relying on training data that may be outdated.

## Setup

### 1. Get API Key

```bash
# Option 1: Interactive setup
npx ctx7 setup --opencode

# Option 2: Manual
# Visit https://context7.com and generate API key
```

### 2. Set Environment Variable

```bash
# macOS/Linux
export CONTEXT7_API_KEY="ctx7_your_api_key_here"

# Add to ~/.zshrc or ~/.bashrc for persistence
echo 'export CONTEXT7_API_KEY="ctx7_your_key"' >> ~/.zshrc
```

### 3. Verify Setup

```bash
# Test connectivity
curl -sI https://mcp.context7.com/mcp \
  -H "CONTEXT7_API_KEY: ${CONTEXT7_API_KEY}"
```

## Usage

### Basic Query

When you need documentation for a library:

```
You: "How do I use useState in React 19?"
```

The skill automatically fetches current React 19 documentation and provides the correct API usage.

### Manual Query

```bash
# Find library ID
ctx7 library react

# Get docs
ctx7 docs facebook/react docs "useState hook"
```

### MCP Tools

If Context7 MCP is configured, use these tools:

#### resolve-library-id

```python
resolve_library_id(
  library_name: "react"  # e.g., "react", "nextjs", "go"
)
# Returns: /facebook/react/docs
```

#### query-docs

```python
query_docs(
  libraryId: "/facebook/react/docs",
  query: "useState hook with initial value"
)
# Returns: Current documentation and code examples
```

## Workflows

### React Workflow

```
User: "Create a counter component with useState"
→ Context7 fetches React 19 useState docs
→ Returns proper syntax: useState<number>(0, { method: 'sync' })
```

### Go Workflow

```
User: "How to read file in Go?"
→ Context7 fetches Go os.ReadFile docs
→ Returns current best practices
```

### Python Workflow

```
User: "How to use pydantic v2?"
→ Context7 fetches Pydantic v2 docs
→ Returns model validation syntax
```

## Troubleshooting

### MCP Not Available

If Context7 MCP is down, use CLI fallback:

```bash
npx ctx7 docs facebook/react docs "useState"
```

### API Key Issues

1. Visit https://context7.com/dashboard
2. Regenerate API key
3. Update CONTEXT7_API_KEY env var

### Slow Responses

- Specify library version: `react@19` instead of `react`
- Use specific queries instead of general ones