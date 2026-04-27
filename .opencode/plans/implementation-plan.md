# Implementation Plan: Pure Remote Config Documentation

**Status**: Approved by user
**Created**: 2026-04-27
**Purpose**: Update README.md + docs/PROJECT-SETUP.md for pure remote config (no setup.sh)

---

## Overview

Update documentation to reflect **pure remote config** approach:
- OpenCode auto-loads from `https://opencode.calavia.org/.well-known/opencode.json`
- No local clone needed (setup.sh removed)
- Tech-specific agents/skills inherited from OpenAgentsControl via URL

---

## Changes Required

### **1. README.md Updates**

#### **1.1 Update Quick Start Section (Lines 9-38)**
**Current Problem**: References non-existent `setup.sh`

**Replace with**:
```markdown
## Quick Start (Pure Remote Config)

OpenCode auto-loads config from `https://opencode.calavia.org/.well-known/opencode.json`:

```bash
# 1. Install OpenCode CLI (if not installed)
npm install -g opencode  # or your install method

# 2. Add tokens to your profile
echo 'export OPENCODE_BOT_TOKEN="ghp_..."' >> ~/.zshrc
echo 'export HUMAN_TOKEN="ghp_..."' >> ~/.zshrc
echo 'export CONTEXT7_API_KEY="ctx7_..."' >> ~/.zshrc

# 3. Start (auto-loads remote config)
source ~/.zshrc
openCode
```

**What happens:**
1. OpenCode reads `https://opencode.calavia.org/.well-known/opencode.json`
2. Auto-loads `spec-driven` agent from this Vercel deployment
3. Inherits tech-specific agents from OpenAgentsControl URLs
4. Loads SPEC files from `.opencode/context/` (if repo has them)
```

---

#### **1.2 Remove "Available Agents" Section (Lines 104-141)**
**Reason**: All tech-specific agents (go-*, java-*, python-*, terraform-*) are NOW inherited from OpenAgentsControl via URL. Only `spec-driven` is in this repo.

**Action**: DELETE entire section (lines 104-141)

---

#### **1.3 Remove "Available Modes" Section (Lines 143-147)**
**Reason**: Modes are inherited from OpenAgentsControl via URL.

**Action**: DELETE entire section (lines 143-147)

---

#### **1.4 Update "Available Skills" Section (Lines 149-158)**
**Current Problem**: Lists deleted skills (expert-config, repo-bootstrap, root-cause-analysis, context7)

**Replace with**:
```markdown
## Available Skills

| Skill | Description |
|-------|-------------|
| `spec-driven` | Create and manage SPEC files (context files) |
| `github-workflow` | GitHub automation (issues, branches, PRs) |
```

**What's served by this Vercel deployment:**
- ✓ 2 skills (`spec-driven`, `github-workflow`)

**Inherited from OpenAgentsControl (via URL):**
- • Tech-specific skills
```

---

#### **1.5 Remove "Token Configuration" Section (Lines 160-192)**
**Reason**: Duplicate of Quick Start section. Tokens are already documented there.

**Action**: DELETE entire section (lines 160-192)

---

#### **1.6 Update "SPEC Tracking" Section (Lines 214-272)**
**Current Problem**: References `.specs/` (legacy), has outdated workflow.

**Replace with**:
```markdown
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
```

---

#### **1.7 Update "Structure" Section (Lines 274-288)**
**Current Problem**: Lists deleted files (setup.sh, update.sh, SPEC.md, SPEC.workflow.yml)

**Replace with**:
```markdown
## Structure

```
opencode-hub/ (Vercel deployment)
├── agents/          # 1 agent (spec-driven orchestrator)
├── skills/          # 2 skills (spec-driven, github-workflow)
├── .opencode/
│   ├── context/    # SPEC files ARE context files
│   └── config/     # paths.json
├── .github/         # PR template
├── docs/            # Documentation (.md files only)
└── README.md        # Single source of truth
```

**Key**: 
- **Pure remote config** - no local clone needed
- SPEC files live directly in `.opencode/context/{category}/`
- Unified docs: `.md` files work on GitHub + Vercel (via marked.js)
- Minimal repo - only opencode-hub specific files stored locally
```

---

#### **1.8 Update "Deploy" Section (Lines 304-317)**
**Replace with**:
```markdown
## Deploy

**Live on Vercel**: https://opencode.calavia.org/

### How it works:
1. Vercel serves this repo's files (`.md`, `.json`, etc.)
2. OpenCode auto-loads from `https://opencode.calavia.org/.well-known/opencode.json`
3. All tech-specific agents/skills inherited from OpenAgentsControl via URLs

### Build (Optional)
For better SEO, convert `.md` to `.html`:
```bash
./build.sh
```
```

---

### **2. docs/PROJECT-SETUP.md Updates**

#### **2.1 Remove setup.sh References**
**Current Problem**: References `curl -sL https://opencode.calavia.org/setup.sh | bash` (file doesn't exist)

**Replace with**:
```markdown
## Quick Start (Pure Remote Config)

OpenCode auto-loads config from `https://opencode.calavia.org/.well-known/opencode.json`:

```bash
# 1. Install OpenCode CLI
npm install -g opencode  # or your install method

# 2. Add tokens to your profile
echo 'export OPENCODE_BOT_TOKEN="ghp_..."' >> ~/.zshrc
echo 'export HUMAN_TOKEN="ghp_..."' >> ~/.zshrc
echo 'export CONTEXT7_API_KEY="ctx7_..."' >> ~/.zshrc

# 3. Start (auto-loads remote config)
source ~/.zshrc
openCode
```

**What happens:**
1. OpenCode reads `https://opencode.calavia.org/.well-known/opencode.json`
2. Auto-loads `spec-driven` agent from this Vercel deployment
3. Inherits tech-specific agents from OpenAgentsControl URLs
```

---

## Execution Order

1. **README.md**:
   - [ ] Update Quick Start (Section 1.1)
   - [ ] Delete Available Agents (Section 1.2)
   - [ ] Delete Available Modes (Section 1.3)
   - [ ] Update Available Skills (Section 1.4)
   - [ ] Delete Token Configuration (Section 1.5)
   - [ ] Update SPEC Tracking (Section 1.6)
   - [ ] Update Structure (Section 1.7)
   - [ ] Update Deploy (Section 1.8)

2. **docs/PROJECT-SETUP.md**:
   - [ ] Update Quick Start (Section 2.1)

---

## Verification

After changes:
```bash
# Check no references to setup.sh/update.sh
grep -r "setup.sh\|update.sh" /Users/jcalavia/Development/Github/opencode-hub --include="*.md"

# Check no references to deleted agents/skills
grep -r "go-implementer\|java-implementer\|python-implementer" /Users/jcalavia/Development/Github/opencode-hub --include="*.md"

# Check pure remote config is explained
grep -r "pure remote\|auto-loads\|well-known" /Users/jcalavia/Development/Github/opencode-hub --include="*.md"
```

---

## Expected Result

- README.md is **clean, minimal, accurate**
- No references to deleted files/agents/skills
- Clear explanation of **pure remote config** approach
- Ready for **Vercel deployment** on merge to main
- Documentation works on **GitHub + Vercel** (unified `.md` files)

---

**Plan approved - ready for execution when mode is switched to normal.**
