---
name: workflow
description: "Guide for the 6-phase agent team workflow. Provides phase-specific instructions, gate criteria, and team coordination patterns. Use when orchestrating a multi-agent development team through discovery, design, development, QA, and finalization phases."
---

# Team Workflow

Orchestration guide for multi-agent team development. This skill helps the team leader manage the 6-phase pipeline and enforce quality gates.

## Phase Pipeline

```
Phase 0: Team Composition [user approval]
  → Phase 1: Discovery [user approval]
  → Phase 2: Design [user approval]
  → Phase 3: Development [auto]
  → Phase 4: QA [auto]
  → Phase 5: Finalization [auto]
```

## Phase Gate Criteria

### Phase 0 → 1 (User Approval Required)

- [ ] PM analyzed project and proposed team composition
- [ ] team-reviewer validated the proposal
- [ ] User approved → spawn only approved roles

### Phase 1 → 2 (User Approval Required)

- [ ] Requirements document complete — must pass **Artifact Schema** (see below)
- [ ] Competitive analysis (PM surveyed 3+ comparable apps/tools)
- [ ] Oracle review passed (mandatory; waiver requires user approval + reason logged)
- [ ] User approved

### Phase 2 → 3 (User Approval Required)

- [ ] Implementation plan — must pass **Artifact Schema** (see below)
- [ ] UI design (design system, component specs, wireframes) — if applicable
- [ ] Architecture contracts frozen (State/Action contracts, dependency signatures)
- [ ] Oracle review passed (mandatory; waiver requires user approval + reason logged)
- [ ] User approved → auto-execution begins

### Phase 3 → 4 (Auto)

- [ ] All development tasks complete
- [ ] Each module's unit tests passing
- [ ] Code reviews passed

### Phase 4 → 5 (Auto)

- [ ] Unit test coverage 80%+
- [ ] Core user flow E2E tests passing
- [ ] Accessibility/responsive verification complete

### Phase 5 Complete

- [ ] Production build succeeds
- [ ] Final code review passed
- [ ] Oracle final validation passed (mandatory; waiver requires user approval + reason logged)
- [ ] Requirements vs. feature completeness checklist confirmed

## Artifact Schemas

Phase gate artifacts must conform to these schemas. Documents missing required fields **cannot pass the gate**.

### Phase 1 Requirements Schema

```markdown
# Requirements: [Project Name]

## Functional Requirements
- [ ] FR-1: [requirement] — [priority indicator]
- [ ] FR-2: ...
(minimum 3 functional requirements, each with priority)
Priority format is flexible: must/should/could, P0/P1/P2, ✅/⚠️, or project convention

## Non-Functional Requirements
- [ ] NFR-1: [requirement] (e.g., performance, security, accessibility)
(minimum 1 non-functional requirement)

## User Personas
- **[Persona Name]**: [description, goals, pain points]
(minimum 1 persona — inline or separate section both acceptable)

## Success Metrics
- [metric]: [target] (e.g., "test coverage: 80%+")
(minimum 1 measurable metric with concrete target)

## Scope Boundary
- **In scope**: [explicit list]
- **Out of scope**: [explicit list]

## Blocking Questions
- [questions that MUST be resolved before gate passage — must be empty]

## Deferred Items
- [items to resolve in Phase 2 — allowed to remain]
```

**Validation rules**:
- All sections present
- **Blocking Questions** must be empty (all resolved). Deferred Items may remain
- Each FR has a priority indicator (format flexible)
- At least 1 persona, 1 success metric, 1 NFR
- Scope Boundary explicitly separates in/out of scope

### Phase 2 Implementation Plan Schema

```markdown
# Implementation Plan: [Project Name]

## Architecture Overview
- [1-2 paragraph summary of chosen architecture]
- **Key decision**: [what was chosen and why]
- **Rejected alternative**: [what was considered and why rejected]

## Task Breakdown
Each task must include: owner, dependency, and corresponding test.
Format is flexible — consolidated table OR per-task sections both acceptable:

Option A (table):
| # | Task | Owner | Depends On | Test |
|---|------|-------|------------|------|
| T-1 | [description] | [role] | - | [test file/case] |

Option B (per-task sections):
### Task N: [title]
- **Owner**: [role]
- **Files**: [list of files to create/modify]
- **Depends on**: [task IDs]
- **Tests**: [test files]

## Contracts (Frozen at Gate)
### State/Action Contracts
- [exact type definitions or interface signatures]

### Dependency Signatures
- [exact function/API signatures shared between modules]
```

**Validation rules**:
- Architecture Overview includes at least 1 rejected alternative with rationale
- Every file has an owner (via task assignment — no unowned files)
- Every task has a corresponding test
- Contracts section is non-empty (at least one State/Action or Dependency signature)
- No task without an owner
- Dependency graph is acyclic (no circular dependencies)

## Leader Coordination Patterns

### Task Assignment

**Phase 1-2** (Leader-assigned):
- Leader assigns tasks to teammates
- Teammates work only on assigned tasks

**Phase 3-5** (Self-assigned):
- On task completion, teammates pick up unassigned tasks within their ownership scope
- Cross-scope tasks still require leader assignment
- On blockers: report to leader immediately, switch to another task

### Teammate Lifecycle

**Idle handling**:
- Do NOT intervene if teammate has an active task (may be waiting for subagents)
- Exception: blocker unreported >10min, or deadlock detected → send status check

**Context rotation**:
- Next task unrelated to previous work → shut down teammate + spawn fresh instance (prevents 200K context saturation)
- Next task is continuation → keep existing teammate
- Role name preserved; only internal instance changes

### Communication Protocol

| From → To | Purpose |
|-----------|---------|
| PM ↔ Leader | Requirements/plan approval, team proposals |
| PM → All | Task assignments, priority changes |
| Designer → Devs | Design specs, component API |
| Dev ↔ Dev | Shared model/contract change agreements |
| QA → Devs | Bug reports, review feedback |
| ui-tester → Devs | UI bug reports (repro steps + screenshots) |
| Devs → Oracle | Alternative impl, architecture validation requests |
| QA → Oracle | Code review second opinion |
| Oracle → Requester | Verification results (suggestions only, never direct edits) |

### Decision Logging

Log every important decision immediately:

```markdown
| Date | Decision | Reason | Rejected Alternatives |
|------|----------|--------|-----------------------|
| YYYY-MM-DD | ... | ... | ... |
```

After every major analysis, self-verify:
1. What was the hardest decision?
2. What alternatives were rejected and why?
3. What am I least confident about?
