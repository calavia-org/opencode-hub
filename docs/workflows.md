# Workflows & Diagrams

Visual representations of the SPEC-driven development workflow.

## Architecture Overview

```mermaid
graph TB
    subgraph "GitHub"
        Issue[GitHub Issue]
        Branch[GitHub Branch]
        PR[GitHub PR]
    end

    subgraph "Orchestrator"
        SD[spec-driven]
    end

    subgraph "Pipeline"
        subgraph "[lang]-implementer"
            Impl[Implement]
        end
        subgraph "[lang]-tester"
            Test[Test]
        end
        subgraph "[lang]-verifier"
            Verify[Verify]
        end
        subgraph "[lang]-deployer"
            Deploy[Deploy]
        end
    end

    SD -->|1. Creates| Issue
    SD -->|2. Creates| Branch
    SD -->|3. Delegates| Impl
    Impl --> Test
    Test --> Verify
    Verify --> Deploy
    Deploy -->|5. Creates| PR
    PR -->|Closes| Issue
```

## Agent Pipeline Flow

```mermaid
sequenceDiagram
    participant User
    participant SD as spec-driven
    participant Context as Context System
    participant GitHub
    participant Impl as [lang]-implementer
    participant Test as [lang]-tester

    User->>SD: Create spec for feature
    SD->>Context: Create SPEC in context/{cat}/{NNN-feature}.md
    SD->>GitHub: MCP create_issue
    SD->>GitHub: Git branch via bot SSH
    SD->>Impl: Implement task (OpenAgentsControl)
    Impl->>Test: Run tests
    Test->>GitHub: MCP create_pull_request
    Note over GitHub: Closes #[issue]
    Note over Context: Update SPEC status to completed
```

## Human Approval Flow

```mermaid
flowchart TD
    A[Human defines SPEC] --> B[Bot creates SPEC, branch via SSH]
    B --> C[Bot implements features]
    C --> D[Bot opens PR via MCP]
    D --> E{Human reviews PR?}
    E -->|Approve| F[Human approves via MCP]
    E -->|Request Changes| G[Human requests changes]
    F --> H[Human merges via MCP]
    G --> C
    H --> I[Update SPEC status to completed]
    I --> J[SPEC stays in context/{category}/ - no archiving]
```

## Token Flow

ALL GitHub actions MUST use MCP. Direct API calls are NOT allowed.

```mermaid
sequenceDiagram
    participant Bot as Bot (MCP)
    participant Human as Human (MCP)
    participant GitHub as GitHub MCP
    participant Vercel as Vercel

    Note over Bot: OPENCODE_BOT_TOKEN
    Bot->>GitHub: MCP create_issue
    Bot->>GitHub: MCP create_pull_request
    
    Note over Human: HUMAN_TOKEN
    Human->>GitHub: MCP approve_pull_request
    Human->>GitHub: MCP merge_pull_request
    
    GitHub->>Vercel: Deploy on merge
```

## MCP Token Rules

| Step | Token | MCP Server | Tool |
|------|-------|-----------|------|
| Create Issue | `OPENCODE_BOT_TOKEN` | github_bot | `create_issue` |
| Create PR | `OPENCODE_BOT_TOKEN` | github_bot | `create_pull_request` |
| Review PR | `HUMAN_TOKEN` | github_human | `add_comment_to_pending_review` |
| Approve | `HUMAN_TOKEN` | github_human | `approve_pull_request` |
| Merge | `HUMAN_TOKEN` | github_human | `merge_pull_request` |

> **Important:** Never use direct API calls (curl) for GitHub actions. Always use MCP.

## Agent Specialization Matrix

| Stage | Java | Python | Go | Terraform |
|-------|------|--------|---|------------|
| Implement | java-implementer | python-implementer | go-implementer | terraform-implementer |
| Test | java-tester | python-tester | go-tester | terraform-tester |
| Verify | java-verifier | python-verifier | go-verifier | terraform-verifier |
| Deploy | java-deployer | python-deployer | go-deployer | terraform-deployer |

## GitHub Issue Lifecycle

```mermaid
stateDiagram-v2
    [*] --> Draft
    Draft --> InReview: Submit for review
    InReview --> Approved: Approve
    InReview --> Draft: Reject
    Approved --> InProgress: Start work
    InProgress --> Completed: Merge PR
    Completed --> [*]
    
    Draft --> Cancelled: Cancel
    InProgress --> Cancelled: Cancel
    
    note right of Completed
        SPEC status: completed
        No archiving - stays in context/{category}/
    end note
```

## Quick Reference

| Step | Command | Description |
|------|---------|-------------|
| 1 | SPEC created | Feature specified in `context/{category}/` |
| 2 | MCP `create_issue` | GitHub issue with SPEC |
| 3 | `git checkout -b spec/NNN-*` (SSH) | Feature branch (exception) |
| 4 | Implement + tests | Code with verification |
| 5 | MCP `create_pull_request` | Pull request |
| 6 | Review + merge | Human approval (MCP) |
| 7 | Complete | Update SPEC status to `completed` |

## Related

- [SPEC Process](./SPEC-process.md)
- [Token Setup](./tokens.md)
- [GitHub Repository](https://github.com/calavia-org/opencode-hub)