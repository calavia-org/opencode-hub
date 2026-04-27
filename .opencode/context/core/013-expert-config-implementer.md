# Expert Implementer for Opencode Configuration

## Overview
A new specialized skill/agent that writes, validates, and optimizes opencode configuration files, with support for historical spec tracking from context files. Uses Context7 for documentation lookup during implementation.

## Motivation
Ensure opencode configuration is properly validated and optimized for context-aware operations. The agent should use Context7 to look up library documentation and understand historical specs implemented in the `.opencode/context/` folders.

## Requirements
- [ ] Create new skill file at `~/.config/opencode/skills/expert-config/SKILL.md`
- [ ] Use Context7 for library/API documentation lookup
- [ ] Implement historical spec tracking by scanning `.opencode/context/**/[0-9]*.md` (SPEC files are context files)
- [ ] Validate opencode configuration structure and settings
- [ ] Optimize configuration for skills integration
- [ ] Provide context-aware recommendations based on past implementations

## Acceptance Criteria
- [ ] Skill loads successfully when invoked
- [ ] Context7 integration works for documentation lookup
- [ ] Can scan `.opencode/context/**/[0-9]*.md` to identify implemented features (SPEC files are context files)
- [ ] Provides validation feedback with actionable errors/warnings
- [ ] Outputs optimized configuration suggestions
- [ ] Maintains backward compatibility with existing config format

## Design Decisions
| Decision | Rationale | Alternative |
|----------|----------|------------|
| Use Context7 for docs | Up-to-date library docs | Static documentation |
| Scan `.opencode/context/` for history | Central source of truth (SPEC files ARE context files) | Parse git history |
| JSON/YAML config support | Industry standard formats | Custom format only |

## Tasks
- [x] Create skill directory structure: `expert-config/SKILL.md`
- [x] Implement Context7 integration for documentation lookup
- [x] Implement `.opencode/context/**/[0-9]*.md` scanner for historical analysis (SPEC files are context files)
- [x] Implement configuration validator with error reporting
- [x] Implement optimization engine for config suggestions
- [ ] Add comprehensive test coverage

## Dependencies
**External:** Context7 MCP for documentation lookup
**Internal:** opencode-hub repository structure with `.opencode/context/` folders (SPEC files ARE context files)

## Out of Scope
- Remote configuration loading (separate feature)
- Modifying existing skills
- Implementing configuration hot-reload at runtime