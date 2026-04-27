<!-- Context: core/navigation | Priority: critical | Version: 1.0 | Updated: 2026-02-15 -->

# Core Context Navigation

**Purpose**: Universal standards and workflows for all development

---

## Structure
```
core/
├── navigation.md
├── 001-spec-driven-process.md         # SPEC file (IS a context file)
├── 002-context-structure.md           # SPEC file (IS a context file)
│
├── context-system/
│   ├── navigation.md
│   ├── overview.md
│   ├── CHANGELOG.md
│   ├── examples/
│   │   └── navigation.md
│   ├── guides/
│   │   └── navigation.md
│   ├── operations/
│   │   └── navigation.md
│   └── standards/
│       └── navigation.md
│
├── concepts/
│   ├── navigation.md
│   ├── opencode-config-schema.md
│   ├── opencode-hub-discovery.md
│   ├── remote-mcp-config.md
│   ├── agent-mode-skill-refs.md
│   ├── agent-architecture.md
│   ├── spec-driven-process.md
│   ├── skill-system.md
│   ├── command-mode-system.md
│   ├── token-system.md
│   └── workflow-system.md
│
├── examples/
│   ├── navigation.md
│   ├── basic-opencode-json.md
│   ├── github-copilot-mcp.md
│   ├── context7-mcp-config.md
│   ├── agent-json-config.md
│   ├── skill-json-config.md
│   ├── github-workflow-validation.md
│   └── spec-process-workflow.md
│
├── lookup/
│   ├── navigation.md
│   ├── opencode-config-properties.md
│   ├── agent-reference.md
│   └── skill-reference.md
│
├── guides/
│   ├── navigation.md
│   ├── resuming-sessions.md
│   ├── visual-development.md
│   ├── github-workflow-rules.md
│   ├── spec-process-guide.md
│   └── project-setup-guide.md
│
├── standards/
│   ├── navigation.md
│   ├── code-quality.md
│   ├── test-coverage.md
│   ├── documentation.md
│   ├── security-patterns.md
│   ├── code-analysis.md
│   └── essential-patterns.md
│
├── workflows/
│   ├── navigation.md
│   ├── code-review.md
│   ├── task-delegation-basics.md
│   ├── feature-breakdown.md
│   ├── session-management.md
│   └── design-iteration-overview.md
│
├── config/
│   ├── navigation.md
│   └── paths.json
│
├── task-management/
│   ├── navigation.md
│   ├── standards/
│   │   └── navigation.md
│   ├── guides/
│   │   └── navigation.md
│   └── lookup/
│       └── navigation.md
│
├── system/
│   └── context-guide.md
│
└── context-system/
    ├── navigation.md
    ├── examples/
    │   └── navigation.md
    ├── guides/
    │   └── navigation.md
    ├── operations/
    │   └── navigation.md
    └── standards/
        └── navigation.md
```
core/
├── navigation.md
├── context-system.md
├── essential-patterns.md
│
├── standards/
│   ├── navigation.md
│   ├── code-quality.md
│   ├── test-coverage.md
│   ├── documentation.md
│   ├── security-patterns.md
│   └── code-analysis.md
│
├── workflows/
│   ├── navigation.md
│   ├── code-review.md
│   ├── task-delegation-basics.md
│   ├── feature-breakdown.md
│   ├── session-management.md
│   └── design-iteration-overview.md
│
├── guides/
│   ├── navigation.md
│   └── resuming-sessions.md
│
├── task-management/
│   ├── navigation.md
│   ├── standards/
│   │   └── navigation.md
│   ├── guides/
│   │   └── navigation.md
│   └── lookup/
│       └── navigation.md
│
├── system/
│   └── context-guide.md
│
└── context-system/
    ├── navigation.md
    ├── examples/
    │   └── navigation.md
    ├── guides/
    │   └── navigation.md
    ├── operations/
    │   └── navigation.md
    └── standards/
        └── navigation.md
```

---

## Quick Routes

| Task | Path |
|------|------|
| **New project setup** | `guides/project-setup-guide.md` |
| **Write code** | `standards/code-quality.md` |
| **Write tests** | `standards/test-coverage.md` |
| **Write docs** | `standards/documentation.md` |
| **Security patterns** | `standards/security-patterns.md` |
| **Review code** | `workflows/code-review.md` |
| **Delegate task** | `workflows/task-delegation-basics.md` |
| **Break down feature** | `workflows/feature-breakdown.md` |
| **SPEC-driven dev** | `001-spec-driven-process.md` (SPEC context files) |
| **Resume session** | `guides/resuming-sessions.md` |
| **Manage tasks** | `task-management/navigation.md` |
| **Task CLI commands** | `task-management/lookup/task-commands.md` |
| **Context system** | `context-system/` |

---

## By Type

**Standards** → Code quality, testing, docs, security (critical priority)
**Workflows** → Review, delegation, task breakdown (high priority)
**Task Management** → JSON-driven task tracking with CLI (high priority)
**System** → Context management and guides (medium priority)

---

## Related Context

- **Development** → `../development/navigation.md`
- **OpenAgents Control Repo** → `../openagents-repo/navigation.md`
