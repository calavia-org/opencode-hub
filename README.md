# Calavia OpenCode Hub

Centralized OpenCode configuration for our organization.

Stack: **Java/Kotlin, Python, Go, Terraform** + **Docker/Portainer/Kubernetes**

## Quick Start

```bash
# One-time setup
curl -sL https://opencode.calavia.org/setup.sh | bash

# Add to your profile
echo 'export OPENCODE_CONFIG_DIR=~/.config/opencode' >> ~/.zshrc
echo 'export GITHUB_TOKEN=ghp_your_token_here' >> ~/.zshrc

# Start
source ~/.zshrc
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

### Terraform Pipeline
| Agent | Description |
|-------|-------------|
| `terraform-implementer` | Writes Terraform infrastructure code |
| `terraform-tester` | Tests and security scans |
| `terraform-verifier` | TFLint, checkov, OPA validation |
| `terraform-deployer` | Deploys to Terraform Cloud |

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
| `context7` | Up-to-date library docs |

## Token Configuration

The system uses two tokens for proper separation of concerns:

| Token | Variable | Purpose | Can Approve | Can Merge |
|-------|----------|---------|-------------|-----------|
| Bot Token | `OPENCODE_BOT_TOKEN` | All automation tasks | ❌ No | ✅ Yes |
| Human Token | `HUMAN_TOKEN` | Human approval actions | ✅ Yes | ✅ Yes |

### Setup

1. **Bot Token** (`OPENCODE_BOT_TOKEN`):
   - Create GitHub account for bot (e.g., `opencode-bot`)
   - Add to organization with write access
   - Generate Fine-grained PAT with permissions:
     - Contents: Read and write
     - Pull requests: Read and write
     - Issues: Read and write
     - Commit statuses: Read and write
     - Workflows: Read and write
   - Add to organization secrets as `OPENCODE_BOT_TOKEN`

2. **Human Token** (`HUMAN_TOKEN`):
   - Use your personal GitHub token
   - Add to environment or secrets as `HUMAN_TOKEN`

### Environment Variables

```bash
export OPENCODE_BOT_TOKEN="ghp_..."  # Bot automation
export HUMAN_TOKEN="ghp_..."         # Human approvals
export CONTEXT7_API_KEY="ctx7_..."   # Library docs
```

## Workflow

### Human Approval Flow

```
Human defines SPEC
      ↓
Bot creates SPEC, branch, implements
      ↓
Bot opens PR
      ↓
Bot WAITS for human approval
      ↓
Human approves in GitHub UI
      ↓
Bot executes merge
      ↓
GitHub Action archives SPEC
```

## SPEC Tracking

All feature specifications are tracked in the `/.specs/` directory with full GitHub workflow integration.

### Directory Structure

```
/.specs/
├── README.md              # Index of all SPECs
├── archived/              # Completed/cancelled SPECs
├── 001-feature-name.md    # Active SPECs
└── ...
```

### Naming Convention

- **Pattern**: `/{issue-number}-{feature-slug}.md`
- **Branch**: `spec/{issue-number}-{feature-slug}`
- **Example**: `001-user-authentication.md` → branch `spec/001-user-authentication`

### Workflow

1. **Create SPEC** → Save to `/.specs/{issue}-{slug}.md`
2. **GitHub Issue** → Automatically created with `spec` and `approved` labels
3. **Feature Branch** → `spec/{issue}-{slug}`
4. **Implement** → Track tasks in SPEC and issue
5. **PR** → Contains "Closes #{issue}" reference
6. **Archive** → Move completed SPEC to `/.specs/archived/`

### SPEC Status States

| Status | Description |
|--------|-------------|
| Draft | Initial creation |
| In Review | Under stakeholder review |
| Approved | Ready for implementation |
| In Progress | Actively being developed |
| Completed | PR merged |
| Cancelled | Abandoned or superseded |

### Quick Commands

```bash
# List all SPECs
cat .specs/README.md

# View active SPECs (numeric files only)
ls .specs/[0-9]*.md

# View archived SPECs
ls .specs/archived/
```

## Structure

```
agents/          # 17 agents
modes/           # 1 mode
skills/          # 5 skills
commands/        # 1 command
.specs/          # SPEC tracking directory
.github/         # PR template
SPEC.template.md
```

## Deploy

Deployed on Vercel: https://opencode.calavia.org