# Calavia OpenCode Hub

Centralized OpenCode configuration for our organization.

Stack: **Java/Kotlin, Python, Go** + **Docker/Portainer/Kubernetes**

## Quick Start

```bash
export OPENCODE_CONFIG_URL=https://opencode.calavia.org/.well-known/opencode.json
export GITHUB_TOKEN=ghp_your_token_here
opencode
```

## GitHub Workflow

Automated workflow: SPEC → Issue → Branch → Implement → PR

### Flow
```bash
opencode --agent spec-driven
Create a spec for user authentication
# 1. SPEC.md created
# 2. GitHub Issue created
# 3. Branch created: spec/{issue}-{slug}
# 4. Implementation via pipeline
# 5. PR created (closes #issue)
```

### Required Environment
```bash
export GITHUB_TOKEN=ghp_your_token_here
export OPENCODE_CONFIG_URL=https://opencode.calavia.org/.well-known/opencode.json
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

## SPEC-Driven Development

```bash
opencode --agent spec-driven
Create a spec for user authentication with JWT
```

## Deployment Workflow

```bash
# Local dev with Docker Compose
opencode --agent docker-platform
Audit the docker-compose.yml

# K8s deployment
opencode --agent docker-platform
Review the Helm chart
```

## Structure

```
agents/          # 14 agents
modes/           # 1 mode
skills/          # 4 skills
commands/        # 1 command
SPEC.template.md
```

## Deploy

Deployed on Vercel: https://opencode.calavia.org