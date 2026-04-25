# SPEC Index

This directory contains all project specifications organized by issue number.

## Active SPECs

| # | Feature | Agent | Status | Created | Branch |
|---|---------|-------|--------|---------|--------|
| 011 | PR Review Merge Workflow | - | - | - | - |
| 012 | Remote Config Loader | - | - | - | - |

## Archived SPECs

| # | Feature | Agent | Status | Merged |
|---|---------|-------|--------|--------|
| 019 | Enhance Spec-Driven Agent | javascript-implementer | Completed | 2026-04-25 |
| 013 | Expert Config Implementer | - | Completed | 2026-04-25 |
| 001 | SPEC Tracking System | - | Completed | 2026-04-24 |

---

## Naming Convention

SPECs follow the pattern: `/.specs/{issue-number}-{feature-slug}.md`

Example: `/.specs/001-user-authentication.md`

## Workflow

1. **Create SPEC** → Detect technology, infer agent, present for approval
2. **Issue** → Create GitHub issue with `spec` and `approved` labels
3. **Branch** → Create branch `spec/{issue}-{slug}`
4. **Implement** → Track tasks in SPEC, update checkboxes
5. **Complete** → Create PR, archive to `archived/` after merge

## Agent Inference

When creating a new SPEC:

1. Repository scanned for technology indicators
2. Agent inferred from technology mapping
3. User approves or overrides with `/change-agent [name]`
4. Agent recorded in `agent:` frontmatter field

### Technology → Agent Mapping

| Pattern | Technology | Agent |
|---------|------------|-------|
| `*.py`, `requirements.txt` | Python | python-implementer |
| `*.go`, `go.mod` | Go | go-implementer |
| `*.java`, `pom.xml` | Java | java-implementer |
| `*.tf` | Terraform | terraform-implementer |
| `*.ts`, `package.json` | JavaScript | javascript-implementer |
| `SPEC.md`, `SKILL.md`, `agents/` | OpenCode/Spec | opencode-implementer |

## Status States

- **Draft**: Initial creation, awaiting approval
- **In Review**: Under stakeholder review
- **Approved**: Ready for implementation
- **In Progress**: Actively being developed
- **Completed**: Implementation finished, PR merged
- **Cancelled**: Abandoned or superseded