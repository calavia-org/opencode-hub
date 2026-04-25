# Expert Implementer for Opencode Configuration

## Overview
A new specialized skill/agent that writes, validates, and optimizes opencode configuration files, with support for historical spec tracking from the .specs directory. Uses Context7 for documentation lookup during implementation.

## Motivation
Ensure opencode configuration is properly validated and optimized for context-aware operations. The agent should use Context7 to look up library documentation and understand historical specs implemented in the `.specs/` folder.

## Requirements
- [ ] Create new skill file at `~/.config/opencode/skills/expert-config/SKILL.md`
- [ ] Use Context7 for library/API documentation lookup
- [ ] Implement historical spec tracking by scanning `.specs/` directory
- [ ] Validate opencode configuration structure and settings
- [ ] Optimize configuration for skills integration
- [ ] Provide context-aware recommendations based on past implementations

## Acceptance Criteria
- [ ] Skill loads successfully when invoked
- [ ] Context7 integration works for documentation lookup
- [ ] Can scan .specs/ folder to identify implemented features
- [ ] Provides validation feedback with actionable errors/warnings
- [ ] Outputs optimized configuration suggestions
- [ ] Maintains backward compatibility with existing config format

## Design Decisions
| Decision | Rationale | Alternative |
|----------|----------|------------|
| Use Context7 for docs | Up-to-date library docs | Static documentation |
| Scan .specs/ for history | Central source of truth | Parse git history |
| JSON/YAML config support | Industry standard formats | Custom format only |

## Tasks
- [x] Create skill directory structure: `expert-config/SKILL.md`
- [x] Implement Context7 integration for documentation lookup
- [x] Implement .specs/ directory scanner for historical analysis
- [x] Implement configuration validator with error reporting
- [x] Implement optimization engine for config suggestions
- [ ] Add comprehensive test coverage

## Dependencies
**External:** Context7 MCP for documentation lookup
**Internal:** opencode-hub repository structure with .specs/ folder

## Out of Scope
- Remote configuration loading (separate feature)
- Modifying existing skills
- Implementing configuration hot-reload at runtime