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

### Sub-Agents (via task tool)
| Agent | Description |
|-------|-------------|
| `implementer` | Implements code from specifications |
| `tester` | Runs tests and validates criteria |
| `deployer` | Deploys to Docker/Portainer/K8s |

### Specialists
| Agent | Description |
|-------|-------------|
| `go-staff` | Go backend engineer |
| `python-staff` | Python backend engineer |
| `spring-staff` | Java/Kotlin backend engineer |
| `docker-platform` | Container/K8s specialist |

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