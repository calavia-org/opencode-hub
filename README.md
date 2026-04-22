# Calavia OpenCode Hub

Centralized OpenCode configuration for our organization.

Stack: **Java/Kotlin, Python, Go** + **Docker/Portainer/Kubernetes**

## Quick Start

```bash
export OPENCODE_CONFIG_URL=https://opencode.calavia.org/.well-known/opencode.json
opencode
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
| `build` | Default productive development mode |

## Available Skills

| Skill | Description |
|-------|-------------|
| `spec-driven` | Create and manage specifications |
| `container-deploy` | Docker, Kubernetes, Helm deployments |
| `root-cause-analysis` | Debug distributed systems |
| `repo-bootstrap` | Quick project setup |

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
agents/      # 7 agents
modes/       # 2 modes
skills/      # 4 skills
commands/    # /spec command
SPEC.template.md
```

## Deploy

Deployed on Vercel: https://opencode.calavia.org