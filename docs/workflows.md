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
    participant GitHub
    participant Impl as [lang]-implementer
    participant Test as [lang]-tester
    participant Verify as [lang]-verifier
    participant Deploy as [lang]-deployer

    User->>SD: Create spec for feature
    SD->>GitHub: Create Issue
    SD->>GitHub: Create Branch spec/{id}-{slug}
    SD->>Impl: Implement task 1
    Impl->>Test: Run tests
    SD->>Impl: Implement task 2
    SD->>Test: Run tests
    Test->>Verify: Verify non-functional
    Verify->>Deploy: Prepare deployment
    Deploy->>GitHub: Create PR
    Note over GitHub: Closes #[issue]
```

## Human Approval Flow

```mermaid
flowchart TD
    A[Human defines SPEC] --> B[Bot creates SPEC, branch]
    B --> C[Bot implements features]
    C --> D[Bot opens PR]
    D --> E{Human reviews PR?}
    E -->|Approve| F[Human clicks Approve]
    E -->|Request Changes| G[Human requests changes]
    F --> H[Bot merges PR]
    G --> C
    H --> I[GitHub Action archives SPEC]
    I --> J[SPEC moved to archived/]
```

## Token Flow

```mermaid
sequenceDiagram
    participant Human
    participant Bot
    participant GitHub
    participant Vercel

    Note over Human,Bot: Bot Token (OPENCODE_BOT_TOKEN)
    Bot->>GitHub: Create issues, branches, PRs
    Bot->>GitHub: Commit code
    Bot->>GitHub: Merge after approval
    
    Note over Human,GitHub: Human Token (HUMAN_TOKEN)
    Human->>GitHub: Approve PR
    Human->>GitHub: Merge (fallback)
    
    GitHub->>Vercel: Deploy on merge
```

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
```

## Quick Reference

| Step | Command | Description |
|------|---------|-------------|
| 1 | SPEC created | Feature specified in `.specs/` |
| 2 | `gh issue create` | GitHub issue with SPEC |
| 3 | `git checkout -b spec/NNN-*` | Feature branch |
| 4 | Implement + tests | Code with verification |
| 5 | `gh pr create` | Pull request |
| 6 | Review + merge | Human approval |
| 7 | Archive | Move to `.specs/archived/` |

## Related

- [SPEC Process](./SPEC-process.md)
- [Token Setup](./tokens.md)
- [GitHub Repository](https://github.com/calavia-org/opencode-hub)