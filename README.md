# Calavia OpenCode Hub

Centralized OpenCode configuration for our organization.

Stack: **Java/Kotlin, Python, Go** + **Docker/Portainer/Kubernetes**

## Quick Start

```bash
export OPENCODE_CONFIG_URL=https://opencode.calavia.org/.well-known/opencode.json
export GITHUB_TOKEN=ghp_your_token_here
opencode
```

## Architecture

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

## GitHub Workflow

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

## Available Agents

### Orchestrator
| Agent | Description |
|-------|-------------|
| `spec-driven` | SPEC-driven development orchestrator |

### Java/Kotlin Pipeline
| Agent | Description |
|-------|-------------|
| `java-implementer` | Implements Java code |
| `java-tester` | Runs JUnit tests |
| `java-verifier` | Validates non-functional |
| `java-deployer` | Deploys to Docker/K8s |

### Python Pipeline
| Agent | Description |
|-------|-------------|
| `python-implementer` | Implements Python code |
| `python-tester` | Runs pytest tests |
| `python-verifier` | Validates non-functional |
| `python-deployer` | Deploys to Docker/K8s |

### Go Pipeline
| Agent | Description |
|-------|-------------|
| `go-implementer` | Implements Go code |
| `go-tester` | Runs Go tests |
| `go-verifier` | Validates non-functional |
| `go-deployer` | Deploys to Docker/K8s |

## Available Modes

| Mode | Description |
|------|-------------|
| `spec-driven` | SPEC-driven development workflow |

## Available Skills

| Skill | Description |
|-------|-------------|
| `spec-driven` | Create specs |
| `github-workflow` | GitHub issue/branch/PR automation |
| `root-cause-analysis` | Debug distributed systems |
| `repo-bootstrap` | Project setup |

## Structure

```
agents/          # 13 agents
modes/           # 1 mode
skills/          # 4 skills
commands/        # 1 command
SPEC.template.md
```

## Deploy

Deployed on Vercel: https://opencode.calavia.org