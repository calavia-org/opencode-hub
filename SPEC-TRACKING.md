# SPEC Tracking System

## Overview

A comprehensive SPEC tracking system that integrates SPEC.md files into the repository's development workflow, enabling full traceability from specification to implementation through GitHub issues, branches, and pull requests. The system includes repository-based storage with standardized naming conventions and is enabled in the spec-driven agent for universal adoption.

## Motivation

Currently, SPEC.md files exist in the repository but lack integration with the GitHub workflow. This creates traceability gaps:

- **No issue linkage**: SPECs are not tied to GitHub issues
- **No automatic branch naming**: Feature branches don't reference their SPEC
- **Manual tracking**: Task progress isn't visible in GitHub
- **No PR linking**: Pull requests don't automatically reference their specification
- **No standardized storage**: SPEC files have inconsistent naming and locations

By embedding SPEC tracking into the workflow, we achieve:
- Complete traceability from idea to deployment
- Clear ownership through GitHub issues
- Visible progress tracking
- Audit trail for decisions
- Universal adoption through spec-driven agent

---

## Requirements

### Core SPEC Infrastructure

- [ ] All features must have a SPEC.md before implementation
- [ ] SPEC.md follows standardized template (see SPEC.template.md)
- [ ] SPEC status states: Draft, In Review, Approved, In Progress, Completed, Cancelled
- [ ] SPEC files stored in repository with consistent naming convention

### SPEC Storage & Naming Convention

- [ ] **Directory**: SPECs stored in `/.specs/` directory at repository root
- [ ] **Naming Pattern**: `/{issue-number}-{feature-slug}.md`
  - Example: `/specs/001-user-authentication.md`
  - Example: `/specs/042-api-rate-limiting.md`
- [ ] **Index File**: `/.specs/README.md` lists all SPECs with status
- [ ] **Template**: `SPEC.template.md` at root serves as standard template
- [ ] **Active SPEC**: `SPEC.md` at root always points to current working SPEC (symlink or index)
- [ ] **Archived SPECs**: Completed/cancelled SPECs moved to `/.specs/archived/`

### GitHub Integration

- [ ] SPECs create GitHub issues with `spec` and `approved` labels
- [ ] Feature branches use pattern: `spec/{issue-number}-{slug}`
- [ ] Pull requests include "Closes #{issue-number}" in body
- [ ] Issue body contains full SPEC content for reference
- [ ] Branch name derived from SPEC filename

### Workflow Automation

- [ ] `spec-driven` skill handles full lifecycle
- [ ] `github-workflow` skill provides GitHub API operations
- [ ] Branch creation from issue triggers
- [ ] PR template includes SPEC checklist

### Spec-Driven Agent Integration

- [ ] Agent recognizes `/.specs/` directory structure
- [ ] Agent loads SPEC from `/.specs/{issue}-{slug}.md` based on branch name
- [ ] Agent auto-generates branch names from active SPEC
- [ ] Agent tracks task completion against SPEC requirements
- [ ] Agent prompts for SPEC creation when no SPEC exists for new features
- [ ] Agent validates SPEC structure before workflow progression

### Tracking & Visibility

- [ ] Task checkboxes in SPEC mirror issue checkbox state
- [ ] Branch name contains issue reference
- [ ] PR description links to SPEC
- [ ] `.specs/README.md` provides dashboard view of all SPECs

---

## Acceptance Criteria

1. **AC1**: A new SPEC can be created using the spec-driven workflow with a single command
2. **AC2**: Creating a SPEC automatically creates a GitHub issue with spec content
3. **AC3**: Feature branches follow `spec/{id}-{slug}` naming convention
4. **AC4**: Tasks in SPEC.md map to checklist items in the linked GitHub issue
5. **AC5**: Completing all tasks in SPEC marks the feature as ready for PR
6. **AC6**: PR body contains reference to SPEC and closes linked issue
7. **AC7**: Documentation exists in README explaining the SPEC workflow
8. **AC8**: SPECs stored in `/.specs/` with `/{issue}-{slug}.md` naming
9. **AC9**: Spec-driven agent loads and enforces SPEC workflow from `/.specs/` directory
10. **AC10**: `.specs/README.md` index tracks all SPECs with their status

---

## Design Decisions

| Decision | Rationale | Alternative Considered |
|----------|----------|------------------------|
| `/.specs/` directory | Clean separation from source code, clear location for all specs | Root-level SPEC.md only - harder to scale, lose history |
| `/{issue}-{slug}.md` naming | Links directly to GitHub issue, human-readable, sortable | UUID-based - harder to read, no issue linkage |
| `SPEC.template.md` at root | Templates should be discoverable at repository root | Hidden in `/.specs/` - less discoverable |
| `SPEC.md` as current pointer | Quick access to active SPEC without knowing exact filename | Always require full path - friction for daily use |
| Spec-driven agent integration | Agents should enforce workflow by default | Optional skill - risk of inconsistency |
| `/.specs/archived/` for completed | Keeps active list clean while preserving history | Delete completed - loses audit trail |
| Squash merge preferred | Keeps main branch history clean | Merge commits - preserves context but noisier |

---

## Directory Structure

```
repository-root/
├── .specs/
│   ├── README.md              # Index of all SPECs
│   ├── archived/              # Completed/cancelled SPECs
│   │   └── 001-feature-name.md
│   ├── 001-feature-name.md    # Active SPEC
│   ├── 042-another-feature.md
│   └── 100-yet-another.md
├── SPEC.template.md          # Standard template
├── SPEC.md                   # Symlink/pointer to current working SPEC
└── ...
```

---

## Spec-Driven Agent Updates

The `agents/spec-driven.md` agent must be updated to:

1. **Detect SPEC location**: Look for `/.specs/` directory
2. **Load active SPEC**: Read SPEC based on current branch or `SPEC.md` pointer
3. **Enforce workflow**: Require valid SPEC before proceeding to implementation
4. **Track progress**: Update task checkboxes against SPEC requirements
5. **Generate artifacts**:
   - Create SPEC file in `/.specs/{issue}-{slug}.md`
   - Create branch `spec/{issue}-{slug}`
   - Create issue with SPEC body
6. **Index management**: Maintain `/.specs/README.md` automatically

---

## Tasks

- [ ] Update `SPEC-TRACKING.md` to define SPEC tracking system specification
- [ ] Review and refine SPEC with stakeholders
- [ ] Create GitHub issue for SPEC tracking implementation
- [ ] Create feature branch `spec/{issue-number}-spec-tracking`
- [ ] Create `/.specs/` directory structure
- [ ] Create `/.specs/README.md` with SPEC index template
- [ ] Update `SPEC.template.md` if needed
- [ ] Update `skills/spec-driven/SKILL.md` with full workflow documentation
- [ ] Update `skills/github-workflow/SKILL.md` with issue/branch/PR operations
- [ ] Update `agents/spec-driven.md` to:
  - [ ] Detect and load SPECs from `/.specs/` directory
  - [ ] Enforce SPEC existence before implementation
  - [ ] Auto-generate branch names from SPEC
  - [ ] Track task completion
  - [ ] Maintain SPEC index
- [ ] Create PR template in `.github/PULL_REQUEST_TEMPLATE.md` with SPEC checklist
- [ ] Add workflow documentation to `README.md`
- [ ] Test full workflow: SPEC → Issue → Branch → PR
- [ ] Verify automation scripts if applicable

---

## Dependencies

**External:**
- GitHub CLI (gh) for API operations
- GitHub credentials with repo permissions

**Internal:**
- `skills/spec-driven` - existing workflow skill
- `skills/github-workflow` - existing GitHub skill
- `SPEC.template.md` - existing template file
- `agents/spec-driven.md` - existing agent to update

---

## Out of Scope

- GitHub Projects/Board automation (future enhancement)
- Automated status updates via webhooks
- SPEC versioning or history tracking beyond archiving
- Integration with external issue trackers (Jira, Linear)
- Migration of existing SPEC.md files (existing files remain at root)

---

## Open Questions

1. Should `SPEC.md` at root be a symlink or a copy of the active SPEC?
   - **Recommendation**: Symlink for single source of truth
2. Do we need automated status syncing between SPEC and GitHub issue?
   - **Recommendation**: Manual for now; can add automation later
3. Should we auto-migrate existing `SPEC.md` to `/.specs/`?
   - **Recommendation**: No, existing files remain; new SPECs use new structure
4. What triggers SPEC archival (manual vs automatic)?
   - **Recommendation**: Manual via PR merge; agent prompts for archival