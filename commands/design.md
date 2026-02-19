---
description: "Design a specialized agent team for a project domain. Analyzes the project, maps roles from the catalog, and outputs a ready-to-use team configuration."
argument-hint: "<project description or path>"
---

Design a specialized agent team for: $ARGUMENTS

## Instructions

Use the team plugin Role Catalog as a base, then adapt it to the target project domain.

### Step 1: Analyze the Project Domain

If a project path is given, explore the codebase (CLAUDE.md, docs/, structure).
If only a description is given, ask clarifying questions.

Determine:
- **Domain type**: App development / Infrastructure / Data / Hardware / Other
- **Tech stack**: Languages, frameworks, platforms
- **Core work type**: UI implementation / Service integration / Data pipeline / ...
- **Security requirements**: Level of sensitivity
- **Test strategy**: TDD feasibility, E2E scope

### Step 2: Map Roles

Transform the Role Catalog roles to fit the domain:

**Mapping principles**:
- pm, qa, oracle are almost always kept (domain-agnostic)
- designer stays for UI-heavy projects; becomes Architect for infrastructure
- dev roles split into domain specializations
- Select only what's needed (minimum: pm + dev(s) + qa)

**Example mappings**:

| Domain | dev A → | dev B → | designer → |
|--------|---------|---------|------------|
| iOS App | ios-dev | backend-dev | UI/UX Designer |
| Flutter App | flutter-dev | backend-dev | UI/UX Designer |
| Web Service | frontend-dev | backend-dev | UI/UX Designer |
| IoT/Infra | Platform Engineer | Integrator | Architect |
| Data Pipeline | ETL Engineer | ML Engineer | Schema Designer |

### Step 3: Define Team Details

For each role, specify:
1. **Responsibilities**: Concrete activity list
2. **Required skills**: Claude Code skills to use
3. **File ownership**: Directory boundaries per role
4. **Workflow adjustments**: Adapt 6 phases to the domain
5. **Domain-specific rules**: Beyond the 10 mandatory rules

### Step 4: Cross-Model Review (if oracle plugin is installed)

After design, get a critical review via Codex:

```bash
codex exec "Critically review this agent team design. Analyze improvements, gaps, and risks: $(cat DESIGN_DOC_PATH)"
```

Review severity:
- **High**: Must fix before proceeding
- **Medium**: PM judgment call
- **Low**: Backlog

### Step 5: Generate Output

Create these files in the target project:

1. **`docs/plans/agent-team-design.md`** — Team roles, ownership map, workflow, rules, generation prompt
2. **Team rules section in project CLAUDE.md** — Append team configuration
3. Git commit + push

### Invariant Rules (apply to ALL teams)

- PM never writes code
- Oracle performs Codex review at every Phase Gate (High = blocking)
- File ownership defined in project CLAUDE.md; cross-ownership changes require PM to designate one owner
- Evidence-based completion with verification-before-completion
- Feedback loops: QA pattern 2+ times → lint rule or .golden-rules.md
- Non-stop development + halt on safety/security defects
- No plaintext secrets/credentials
- Phase 0-2 require user approval
