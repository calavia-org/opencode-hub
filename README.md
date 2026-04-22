# Calavia OpenCode Hub

Centralized OpenCode configuration for our organization.

## Quick Start

### Option 1: Clone and Use

```bash
git clone https://github.com/calavia/opencode-hub.git
export OPENCODE_CONFIG_DIR=$(pwd)/opencode-hub
```

### Option 2: Global Install

```bash
git clone https://github.com/calavia/opencode-hub.git ~/.config/opencode
```

## Available Agents

| Agent | Description |
|-------|-------------|
| `python-staff` | Backend and automation engineer for Python systems |
| `typescript-staff` | Senior full-stack engineer for TypeScript/Node projects |
| `spring-staff` | Enterprise backend specialist for Java + Spring Boot |
| `docker-platform` | Container and deployment specialist |
| `architect-generalist` | Cross-stack senior architect |

## Available Modes

| Mode | Description |
|------|-------------|
| `build` | Default productive development mode |
| `onboarding` | Repository understanding and entry mode |
| `refactor` | Safe structural improvement mode |
| `incident` | Production incident response mode |
| `debug` | Fault isolation and debugging |
| `review` | Code review and PR analysis |

## Available Skills

| Skill | Description |
|-------|-------------|
| `repo-bootstrap` | Quickly become productive in a new repository |
| `code-review` | Staff-level code review |
| `refactor-complexity` | Reduce code complexity without behavior change |
| `root-cause-analysis` | Find production issue cause quickly |
| `docker-stack` | Review Docker configurations |

## Deploy to Vercel

```bash
npm i -g vercel
vercel --prod
```

Or connect the repository at https://vercel.com

## Structure

```
opencode-hub/
├── .well-known/
│   └── opencode          # Remote config endpoint
├── agents/
│   └── *.md             # Agent definitions (Markdown + frontmatter)
├── modes/
│   └── *.md             # Mode definitions
├── skills/
│   └── */SKILL.md       # Skill definitions (standard format)
├── commands/
├── tools/
└── themes/
```

## License

MIT