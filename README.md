# Calavia OpenCode Hub

Centralized OpenCode configuration for our organization.

**Unified Documentation**: All docs are `.md` files - served directly on Vercel or rendered as HTML via `marked.js`.

Stack: **Java/Kotlin, Python, Go, Terraform** + **Docker/Portainer/Kubernetes**

## Quick Start (Pure Remote Config)

OpenCode auto-loads config from `https://opencode.calavia.org/.well-known/opencode.json`:

```bash
# 1. Install OpenCode CLI (if not installed)
npm install -g opencode  # or your install method;

# 2. Add tokens to your profile
echo 'export OPENCODE_BOT_TOKEN="ghp_..."' >> ~/.zshrc;
echo 'export HUMAN_TOKEN="ghp_..."' >> ~/.zshrc;
echo 'export CONTEXT7_API_KEY="ctx7_..."' >> ~/.zshrc;

# 3. Start (auto-loads remote config)
source ~/.zshrc;
opencode;
```

**What happens:**
1. OpenCode reads `https://opencode.calavia.org/.well-known/opencode.json`
2. Auto-loads `spec-driven` agent from this Vercel deployment
3. Inherits tech-specific agents from OpenAgentsControl URLs
4. Loads SPEC files from `.opencode/context/` (if repo has them)

**What's served by this Vercel deployment:**
- ✓ 1 agent (`spec-driven` orchestrator - unique to this hub)
- ✓ 2 skills (`spec-driven`, `github-workflow`)
- ✓ SPEC files in `.opencode/context/`
- ✓ Documentation (.md files)

**Inherited from OpenAgentsControl (via URL - no local install needed):**
- • Tech-specific agents (go, python, java, etc.)
- • Tech-specific skills
- • Modes, tools, commands

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

| Agent | Description |
|-------|-------------|
| `spec-driven` | SPEC-driven development orchestrator (unique to this hub) |

**Inherited from OpenAgentsControl (via URL):**
- Tech-specific agents (go, python, java, terraform, etc.)

## Available Modes (Inherited from OpenAgentsControl via URL)

All modes are inherited from OpenAgentsControl. See: `https://opencode.calavia.org/modes`

## Available Skills

| Skill | Description |
|-------|-------------|
| `spec-driven` | Create and manage SPEC files (context files) |
| `github-workflow` | GitHub automation (issues, branches, PRs) |

**What's served by this Vercel deployment:**
- ✓ 2 skills (`spec-driven`, `github-workflow`)

**Inherited from OpenAgentsControl (via URL):**
- • Tech-specific skills

## Token Configuration

Tokens are documented in **Quick Start** section above.

**Summary:**
- `OPENCODE_BOT_TOKEN` - Bot automation (create branches, PRs, merge)
- `HUMAN_TOKEN` - Human approvals (review, approve PRs)
- `CONTEXT7_API_KEY` - Library documentation (optional)

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

## SPEC Files (Context System)

All SPEC files are stored directly in context categories (SPEC files ARE context files):

```
.opencode/context/
├── core/
│   ├── 001-spec-driven-process.md       # SPEC file (IS context)
│   └── 002-context-structure.md         # SPEC file (IS context)
├── development/
│   ├── 001-add-auth.md                  # SPEC file
│   └── 002-fix-api.md                   # SPEC file
└── ...
```

**Key**: 
- SPEC files live directly in `.opencode/context/{category}/` (no `.specs/` folder)
- No archiving - completed SPECs stay in context/{category}/ with status `completed`
- ContextScout discovers SPEC files automatically (no index needed)

### Naming Convention

- **Pattern**: `.opencode/context/{category}/{NNN-feature-slug}.md`
- **Branch**: `spec/{issue-number}-{feature-slug}`
- **Example**: `.opencode/context/development/001-add-auth.md` → branch `spec/001-add-auth`

### Workflow

1. **Create SPEC** → Save to `.opencode/context/{category}/{NNN}-{slug}.md`
2. **GitHub Issue** → Automatically created with `spec` and `approved` labels
3. **Feature Branch** → `spec/{issue}-{slug}`
4. **Implement** → Track tasks in SPEC and issue
5. **PR** → Contains "Closes #{issue}" reference
6. **Complete** → Update SPEC status to `completed` (no archiving, stays in context/{category}/)

### Quick Commands

```bash
# List all SPEC files (they're context files)
find .opencode/context -name "[0-9][0-9][0-9]-*.md"

# View SPEC files in core/
ls .opencode/context/core/[0-9]*.md

# View SPEC files in development/
ls .opencode/context/development/[0-9]*.md

# ContextScout automatically discovers SPEC files (no index needed)
```

## Structure (Minimal Hub)

```
agents/              # 1 agent (spec-driven orchestrator - unique to this hub)
skills/               # 2 skills (spec-driven, github-workflow)
.opencode/
  ├── context/       # SPEC files ARE context files
  ├── config/        # Path configuration (paths.json)
  └── ...
.github/             # PR template, workflows
SPEC.template.md      # Template for new SPEC files
docs/                 # Documentation (.md files only)
```

**Key**: 
- SPEC files live directly in `.opencode/context/{category}/` (no `.specs/` folder)
- All tech-specific agents/skills/modes/tools **inherited from OpenAgentsControl via URL** (no local copies)
- Minimal repo - only opencode-hub specific files stored locally
- Unified docs: `.md` files work on GitHub + Vercel (via marked.js)

## Documentation (Unified .md)

All documentation lives in `.md` files - single source of truth:
- **GitHub**: Rendered natively by GitHub
- **Vercel**: Dynamically loaded via `marked.js` (see `index.html`)
- **No duplication**: No `.html` duplicates - Vercel converts `.md` → HTML on the fly

### Quick Links
- [SPEC Process](docs/SPEC-process.md) - How to create and manage SPEC files
- [Workflows](docs/workflows.md) - Development workflows and patterns
- [Token Setup](docs/tokens.md) - Configure BOT_TOKEN, HUMAN_TOKEN, CONTEXT7_API_KEY
- [Project Setup](PROJECT-SETUP.md) - Pure remote config (no local clone needed)

## Deploy (Vercel)

Deployed on Vercel: **https://opencode.calavia.org/**

**How it works:**
1. Vercel serves this repo's files (`.md`, `.json`, etc.)
2. OpenCode auto-loads from `https://opencode.calavia.org/.well-known/opencode.json`
3. All tech-specific agents/skills **inherited from OpenAgentsControl via URLs** (no local copies)

### Pure Remote Config
- No local clone needed
- OpenCode auto-loads remote config on startup
- See **Quick Start** section above

### Build (Optional)
For better SEO, convert `.md` to `.html`:
```bash
./build.sh
```