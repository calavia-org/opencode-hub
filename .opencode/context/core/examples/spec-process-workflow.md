# Example: SPEC Process Workflow

**Purpose**: SPEC-driven development steps from docs/SPEC-process.md

**Workflow**:
```markdown
1. Define Feature
   - Name, description, motivation, requirements

2. Create SPEC (.opencode/context/{category}/{NNN-feature}.md)
   - Overview, motivation, requirements, acceptance criteria
   - Tasks, dependencies, out of scope
   - Frontmatter: name, issue, status, category

3. GitHub Issue
   - Title: "SPEC: [Feature]"
   - Labels: spec, approved
   - Created via github_bot MCP

4. Feature Branch
   - spec/{issue-number}-{feature-slug}
   - Created via bot SSH key

5. Implementation
   - Delegate to {lang}-implementer (from OpenAgentsControl)
   - Update docs/ (ALWAYS required)
   - Check Copilot comments (ALWAYS required)

6. Pull Request
   - Title: "Closes #[issue]: [feature]"
   - Created via github_bot MCP

7. Complete
   - Update SPEC status to "completed" (no archiving)
   - SPEC stays in context/{category}/ (discoverable)
```

**Context Integration**:
- SPEC files ARE context files (loaded by ContextScout)
- OpenAgentsControl agents can reference: `.opencode/context/{category}/{NNN-feature}.md`

**Reference**: https://github.com/calavia-org/opencode-hub
**Related**: concepts/spec-driven-process.md, guides/spec-process-guide.md
