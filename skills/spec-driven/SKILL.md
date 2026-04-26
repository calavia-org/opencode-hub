---
name: spec-driven
description: Create and manage specifications for features with full GitHub workflow and .specs/ storage.
requires:
  - github-workflow
  - github-workflow-rules
---

# SPEC-Driven Development Skill

> ⚡ **Load at start**: This skill enforces [GitHub Workflow Rules](docs/github-workflow-rules.md)
> - MCP-only for GitHub API (no gh CLI, curl)
> - Token separation (BOT vs HUMAN)
> - MCP failure stops execution

Create detailed specifications before implementation with complete GitHub workflow.

## SPEC Storage

All SPECs are stored in the `/.specs/` directory with standardized naming:

```
/.specs/
├── README.md              # Index of all SPECs
├── archived/             # Completed/cancelled SPECs
├── 001-feature-name.md    # Active SPECs
└── ...
```

### Naming Convention

Pattern: `/.specs/{issue-number}-{feature-slug}.md`

Examples:
- `/.specs/001-user-authentication.md`
- `/.specs/042-api-rate-limiting.md`
- `/.specs/100-payment-integration.md`

### Storage Rules

1. **Active SPECs**: Stored directly in `/.specs/`
2. **Archived SPECs**: Moved to `/.specs/archived/` after completion
3. **Template**: Use `SPEC.template.md` at repository root
4. **Current Pointer**: `SPEC.md` points to the active working SPEC

### SPEC Frontmatter

Each SPEC should include YAML frontmatter for metadata:

```yaml
---
name: feature-slug
issue: "001"
status: draft
technology: "detected"
agent: "inferred + approved"
created: YYYY-MM-DD
---
```

## When to Use

Start this skill when:
- Beginning a new feature
- Unclear requirements
- Risk of scope creep
- Need to document decisions

## Agent Inference

Before creating a SPEC, the agent is inferred from repository technology and presented to the user for approval.

### Technology Detection

Scan repository root for technology indicators:

| Pattern | Technology | Inferred Agent |
|---------|------------|----------------|
| `package.json`, `*.ts`, `*.tsx` | JavaScript/TypeScript | javascript-implementer |
| `requirements.txt`, `*.py`, `setup.py` | Python | python-implementer |
| `go.mod`, `*.go` | Go | go-implementer |
| `pom.xml`, `build.gradle`, `*.java` | Java | java-implementer |
| `*.tf`, `terraform.tfvars` | Terraform | terraform-implementer |
| `Cargo.toml`, `*.rs` | Rust | rust-implementer |
| `Gemfile`, `*.rb` | Ruby | ruby-implementer |
| `SPEC.md`, `SKILL.md`, `agents/` | OpenCode/Spec-Driven | opencode-implementer |

### Multi-Repo Handling

For monorepos with multiple technologies, detect based on **SPEC context**:

1. Parse SPEC title/description for hints (e.g., "ML pipeline" → Python)
2. Scan relevant subdirectories for technology files
3. Present inference to user for confirmation

**Example:** Monorepo with `go/` and `python/` directories. SPEC: "Add ML pipeline" → scans `python/` → infers `python-implementer`.

### Agent Approval Workflow

```
1. Detect technology from repository
2. Infer agent from technology mapping
3. Present to user:
   "Detected [Python]. Use [python-implementer]? [Yes/Skip/Change]"
4. User response:
   - Yes → proceed with inferred agent
   - Skip → agent not assigned, manual selection later
   - Change → prompt for agent selection
```

### Override Command

To change the assigned agent at any time:

```
/change-agent [agent-name]
```

Available agents: `python-implementer`, `python-tester`, `python-verifier`, `go-implementer`, `go-tester`, `go-verifier`, `java-implementer`, `javascript-implementer`, `terraform-implementer`, `opencode-implementer`, etc.

### Config Override

For explicit technology detection, add to `.opencode/config.yml`:

```yaml
technology:
  override: python  # Force Python detection regardless of files
  custom_mapping:  # Future: custom tech-to-agent mapping
    my-framework: custom-agent
```

## Full Workflow

This skill orchestrates the complete development workflow:

### 1. SPEC Creation
1. Detect repository technology
2. Infer agent and present for user approval
3. Create SPEC using template in `SPEC.template.md`
4. Save to `/.specs/{issue-number}-{feature-slug}.md`
5. Update `/.specs/README.md` index

### 2. Create GitHub Issue
After SPEC is approved, create GitHub issue using MCP tool:

```bash
# Use MCP tool - gh CLI is forbidden for API calls
mcp_github create-issue \
  --title "SPEC: [Feature Name]" \
  --body "[spec-content-from-.specs]" \
  --label "spec" --label "approved"
```

### 3. Create Branch
Create feature branch from issue number:

```bash
git checkout -b spec/{issue-number}-{slug}
```

### 4. Track Tasks
- Implement tasks from SPEC in `/.specs/`
- Update checkbox status in GitHub issue
- Update `/.specs/README.md` with progress

### 5. Create PR
When all tasks complete:

```bash
# Use MCP tool - gh CLI is forbidden
mcp_github create-pull-request \
  --title "Closes #[issue]: [feature]" \
  --body "[changes]\n\nCloses #[issue]\n\nSPEC: /.specs/[issue]-[slug].md" \
  --head "spec/[issue]-[slug]" --base "main"
```

### 6. Archive
After PR merge:
- Move SPEC to `/.specs/archived/`
- Update `/.specs/README.md` status

## Spec Template

```markdown
---
name: feature-slug
issue: 001
status: draft
technology: [detected]
agent: [inferred + approved]
created: 2026-04-25
---

# [Feature Name]

## Overview
One-paragraph description.

## Motivation
Why is this needed? What problem does it solve?

## Requirements
- [ ] Requirement with checkbox
- [ ] Another requirement

## Acceptance Criteria
- [ ] Testable criterion
- [ ] Another criterion

## Design Decisions
| Decision | Rationale | Alternative |
|----------|----------|------------|
| Choice A | Reason | Choice B |

## Tasks
- [ ] Implementable task
- [ ] Another task

## Dependencies
**External:** Library or service
**Internal:** Feature that must be ready first

## Out of Scope
- What this feature does NOT include
```

## Agent Integration

The spec-driven agent will:

1. Detect `/.specs/` directory structure
2. Load SPEC from `/.specs/{issue}-{slug}.md`
3. Enforce SPEC existence before implementation
4. Auto-generate branch names from SPEC issue number
5. Track task completion against SPEC
6. Maintain `/.specs/README.md` index
7. **Detect repository technology and infer appropriate agent**
8. **Present agent suggestion to user for approval**
9. **Support `/change-agent` override command**

## Rules

1. Always link PR to issue
2. Use conventional commits
3. Squash merge preferred
4. Require reviews
5. Spec before code
6. Checkboxes track progress
7. Criteria must be testable
8. Update spec when changing requirements
9. Store all SPECs in `/.specs/` directory
10. Archive completed SPECs to `/.specs/archived/`
11. **Infer agent from technology, present for user approval**
12. **Allow override via `/change-agent` command**