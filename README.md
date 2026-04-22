# Calavia OpenCode Hub

Centralized OpenCode configuration for our organization, deployed on Vercel.

## Quick Start

### Remote Config (Recommended)

```bash
export OPENCODE_CONFIG_URL=https://opencode.calavia.org/.well-known/opencode.json
opencode
```

### Clone Locally

```bash
git clone https://github.com/calavia-org/opencode-hub.git
export OPENCODE_CONFIG_DIR=$(pwd)/opencode-hub
opencode
```

## Structure

```
opencode-hub/
├── .well-known/opencode.json   # Remote config endpoint
├── agents/
│   └── *.md              # Agent definitions
├── modes/
│   └── *.md             # Mode definitions
├── skills/
│   └── */SKILL.md        # Skill definitions
└── vercel.json           # Vercel config
```

## Available Agents

| Agent | Description |
|-------|-------------|
| `spec-driven` | SPEC-driven development orchestrator |
| `python-staff` | Backend and automation engineer for Python systems |
| `typescript-staff` | Senior full-stack engineer for TypeScript/Node projects |
| `spring-staff` | Enterprise backend specialist for Java + Spring Boot |
| `docker-platform` | Container and deployment specialist |
| `architect-generalist` | Cross-stack senior architect |

## Available Modes

| Mode | Description |
|------|-------------|
| `spec-driven` | SPEC-driven development workflow |
| `build` | Default productive development mode |
| `onboarding` | Repository understanding and entry mode |
| `refactor` | Safe structural improvement mode |
| `incident` | Production incident response mode |
| `debug` | Fault isolation and debugging |
| `review` | Code review and PR analysis |

## Available Skills

| Skill | Description |
|-------|-------------|
| `spec-driven` | Create and manage specifications |
| `repo-bootstrap` | Quickly become productive in a new repository |
| `code-review` | Staff-level code review |
| `refactor-complexity` | Reduce code complexity without behavior change |
| `root-cause-analysis` | Find production issue cause quickly |
| `docker-stack` | Review Docker configurations |

## Deploy

The site is automatically deployed via Vercel on push to `main`.

Manual deploy:

```bash
vercel --prod
```

## License

MIT