# opencode-hub — Agent Instructions

> **MANDATORY READ**: This repository is governed by [`~/Development/Github/AGENTS.md`](../AGENTS.md) (organization-wide rules). Per-repo rules below provide project-specific details but **cannot override** organization rules.

## Project Overview

Centralized OpenCode configuration hub for calavia-org. Served statically on Vercel at `https://opencode.calavia.org/`; OpenCode auto-loads agents, skills, commands, and modes from `/.well-known/opencode.json`, inheriting tech-specific config remotely from OpenAgentsControl.

## Repository Layout

```
.
├── .well-known/
│   └── opencode.json        # Remote config entry point consumed by OpenCode
├── agents/                  # Hub-local agents (spec-driven orchestrator)
├── skills/                  # Hub-local skills (spec-driven, github-workflow)
├── commands/                # Hub-local commands (spec)
├── api/
│   └── markdown.js          # Vercel serverless function rendering .md as HTML
├── docs/                    # Documentation (.md source + generated .html)
├── .opencode/
│   ├── config/              # paths.json (remote inheritance), agent metadata
│   └── context/             # SPEC files and hub context (core/, guides/, concepts/)
├── .github/workflows/       # PR checks + SPEC archive automation
├── index.html               # Landing page (loads docs via marked.js)
├── vercel.json              # Vercel rewrites/headers for .well-known and .md
├── spec-driven.md           # spec-driven agent definition
└── SPEC.template.md         # Template for new SPEC files
```

## Tech Stack

- **Content**: Markdown (docs, agents, skills, commands), JSON (config)
- **Hosting**: Vercel static site + one Node.js serverless function (`api/markdown.js`)
- **Tooling**: pre-commit (markdownlint, actionlint, YAML/JSON checks)
- **No build step**: files are served statically; `vercel.json` handles rewrites

## Environment Setup

```bash
# Install pre-commit hooks (commit-msg + pre-commit stages)
pre-commit install --install-hooks
pre-commit install --hook-type commit-msg

# No dependencies to install; edit files and push.
```

## Linting & Formatting

```bash
# Run all hooks against the whole repo
pre-commit run --all-files
```

## Testing

There is no unit, integration, or build test suite. Validation is:

```bash
# Pre-commit hooks (markdownlint, actionlint, check-yaml, ...)
pre-commit run --all-files

# GitHub Actions syntax
actionlint .github/workflows/*.yml
```

## CI/CD

- **PR checks**: `.github/workflows/pr-check-and-test.yml` calls the reusable workflow `calavia-org/workflows-lib/.github/workflows/pr-check-and-test.yml@v0` with all build/test stages disabled (docs + config only).
- **SPEC archive**: `.github/workflows/spec-archive.yml` runs weekly (and via `workflow_dispatch`) to archive completed SPEC files.
- **Release**: none — this repo publishes no versioned artifact; merging to `main` redeploys Vercel.

## Key Commands

| Task | Command |
|------|---------|
| Run all lint hooks | `pre-commit run --all-files` |
| Lint GitHub Actions | `actionlint .github/workflows/*.yml` |
| List SPEC files | `find .opencode/context -name "[0-9][0-9][0-9]-*.md"` |
| Preview deployment | push to a branch and open a PR (Vercel preview) |

## Commits & Branches

- All commits follow [Conventional Commits](https://www.conventionalcommits.org/) (`feat:`, `fix:`, `chore:`, `docs:`, ...).
- Branches use conventional prefixes: `feat/`, `fix/`, `chore/`, `docs/`, `refactor/`, `ci/`.
- Never commit directly to `main` — every change goes through a PR (squash merge only).

## Gotchas & Special Cases

- SPEC files live directly in `.opencode/context/{category}/{NNN}-{slug}.md` — there is no `.specs/` folder, and completed SPECs are not moved.
- Tech-specific agents/skills/modes are **not** stored here; they are inherited remotely from OpenAgentsControl via `.opencode/config/paths.json`. Do not add local copies.
- `docs/` contains both `.md` sources and generated `.html` files; edit the `.md` files only.
- `vercel.json` rewrites `/**/*.md` to `/api/markdown` — keep the `Content-Type` headers for `/.well-known/*` intact when editing.
- Tokens (`OPENCODE_BOT_TOKEN`, `HUMAN_TOKEN`, `CONTEXT7_API_KEY`) are user environment variables; never commit them.

## References

- **README.md**: hub usage, quick start, and SPEC workflow
- **docs/SPEC-process.md**: how to create and manage SPEC files
- **docs/tokens.md**: token configuration
- **workflows-lib**: `calavia-org/workflows-lib` — reusable CI workflows
- **org-standards**: `calavia-org/org-standards` — organization-wide harness and templates

---

**Last Updated**: 2026-10-12
**Maintained By**: calavia-org
