# SPEC.md - Terraform Agents & SPEC-Driven Workflow

**Feature**: 
1. Add specialized Terraform agents
2. Update SPEC-driven workflow with full GitHub integration
**Created**: 2026-04-24
**Status**: Draft

---

## Overview

### Part 1: Terraform Agents
Add new specialized agents (terraform-implementer, terraform-deployer, terraform-tester, terraform-verifier) to provide full Terraform lifecycle support:

- Write Terraform configurations
- Deploy to Terraform Cloud for state persistence
- Connect to GitHub repositories
- Validate with TFLint and other tools

### Part 2: SPEC-Driven Workflow
Update spec-driven workflow to include full GitHub automation:

- Issue creation from SPEC
- Branch creation (spec/{id}-{slug})
- PR creation that closes issue
- Integration with github-workflow skill

---

## Requirements

### Agent Types

- [ ] **terraform-implementer** - Writes Terraform configurations following best practices
- [ ] **terraform-deployer** - Deploys to Terraform Cloud, manages state and workspaces
- [ ] **terraform-tester** - Tests Terraform code (plan validation, security scanning)
- [ ] **terraform-verifier** - Validates with TFLint, checkov, OPA, Conftest

### terraform-implementer

- Creates `.tf` files following HashiCorp style guide
- Uses Terraform 1.0+ features (for_each, modules, workspaces)
- Integrates with remote state (Terraform Cloud)
- Version pinning for providers and modules
- Output validation
- Sensitive variable handling

### terraform-deployer

- Terraform Cloud API integration (tfe provider or CLI)
- Workspace management (create, configure, migrate state)
- GitHub repository linking
- Remote state backend configuration
- Variable and secrets management
- Execution environment setup

### terraform-tester

- `terraform plan` validation
- `terraform validate`
- Security scanning (checkov, tfsec)
- Cost estimation integration
- Drift detection

### terraform-verifier

- TFLint integration
- OPA/Conftest policy validation
- checkov static analysis
- Provider validation
- Module verification
- Best practices checking

---

## Integration Points

- **Terraform Cloud**: Remote state storage, workspaces, runs
- **GitHub**: Repository connection, VCS workflow
- **Tools**: TFLint, checkov, tfsec, OPA, Conftest, Infracost

---

## Acceptance Criteria

### Part 1: Terraform Agents

1. All 4 Terraform agent files created in `/agents/` directory
2. Each agent has correct YAML front matter (name, description, mode: subagent)
3. Agents load without errors in the agent system
4. terraform-implementer can create valid `.tf` files
5. terraform-deployer configures Terraform Cloud backend
6. terraform-tester runs plan and validate
7. terraform-verifier runs TFLint and returns results
8. Integration with context7 skill for documentation lookup

---

### Part 2: SPEC-Driven Workflow

9. spec command includes github-workflow as requirement
10. Creates GitHub issue from SPEC
11. Creates branch using spec/{id}-{slug} pattern
12. Creates PR that closes issue
13. Consistent branch naming across all docs

---

## Tasks

- [ ] Create `agents/terraform-implementer.md`
- [ ] Create `agents/terraform-deployer.md`
- [ ] Create `agents/terraform-tester.md`
- [ ] Create `agents/terraform-verifier.md`
- [ ] Integrate with existing agent loading system
- [ ] Add TFLint/tool validations to terraform-verifier
- [ ] Test each agent loads correctly
- [ ] Document usage in README

---

## Notes

- Follow existing agent pattern from `go-implementer.md`
- Use context7 for Terraform provider documentation
- Consider MCP integration for Terraform Cloud API