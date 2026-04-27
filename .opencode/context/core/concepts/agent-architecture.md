# Concept: Agent Architecture

**Core Idea**: 18 agents organized by language (Go, Java, Python, Terraform) 
with specialized roles: implementer, tester, verifier, and deployer.

**Key Points**:
- 4 language stacks: Go, Java, Python, Terraform (4 agents each = 16)
- Plus 2 orchestrators: spec-driven, opencode-implementer
- Each stack: implementer (code), tester (tests), verifier (non-functional), deployer (Docker/K8s)
- Agents discovered via `agents` URL in opencode.json

**Quick Example**:
```json
{"name": "go-implementer", "description": "Implements Go code"}
{"name": "go-tester", "description": "Runs Go tests"}
{"name": "go-verifier", "description": "Validates non-functional"}
{"name": "go-deployer", "description": "Deploys to Docker/K8s"}
```

**Reference**: https://opencode.calavia.org/agents
**Related**: lookup/agent-reference.md, concepts/spec-driven-process.md
