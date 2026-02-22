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
- [ ] Per-module coverage report submitted (minimum 50% at Phase 3 exit; 80%+ enforced at Phase 4→5)
- [ ] Code reviews passed
- [ ] TDD proof-of-order: QA verified commit ordering (Red→Green) for at least one representative task per developer
- [ ] Pre-Implementation Diff Check: no non-planning file changes before Phase 2 GATE:PASS (Rule 14)
- [ ] Leader context checkpoint logged (utilization %, active tasks, last compaction timestamp)

### Phase 4 → 5 (Auto)

- [ ] Unit test coverage 80%+
- [ ] Core user flow E2E tests passing
- [ ] Accessibility/responsive verification complete

### Phase 5 Complete

- [ ] Production build succeeds
- [ ] Final code review passed
- [ ] Oracle final validation passed (mandatory; waiver requires user approval + reason logged). Oracle Phase 5 scope: (1) verify all High/Medium Oracle Findings from Phases 1-4 are resolved, (2) confirm no new risk triggers introduced in Phase 5, (3) validate production build artifact against requirements completeness checklist
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

## Competitive Analysis
| App | Core Features | Strengths | Weaknesses | Differentiation |
|-----|--------------|-----------|------------|-----------------|
| [app 1] | ... | ... | ... | ... |
| [app 2] | ... | ... | ... | ... |
| [app 3] | ... | ... | ... | ... |
(minimum 3 apps, all columns required)

## Traceability Matrix
| FR ID | Task IDs | Test Path |
|-------|----------|-----------|
| FR-1 | T-1, T-2 | Tests/Feature1Tests.swift |
| FR-2 | T-3 | Tests/Feature2Tests.swift |
(every FR must map to at least one task and one test path — no empty cells allowed)

## Blocking Questions
- [unresolved blockers — each must have owner, due date, and mitigation plan]
- [any unresolved blocker without an approved waiver is GATE:FAIL]

## Deferred Items
- [items to resolve in Phase 2 — allowed to remain]

## Oracle Findings (required)
| Finding ID | Severity | Description | Resolution | Linked Task ID | Owner |
|------------|----------|-------------|------------|----------------|-------|
| OF-1 | High/Medium/Low | ... | Fixed/Deferred/Accepted | T-N or - | ... |
(if no findings were raised, include: `OF-0 | None | No findings | - | - | [validator role]`)

Gate rule: Any High severity finding without a mitigation task or explicit user-approved acceptance blocks gate passage.
```

**Validation rules**:
- All sections present
- **Blocking Questions**: unresolved blockers must each have owner, due date, and mitigation plan. Any unresolved blocker without an approved waiver is GATE:FAIL. Deferred Items may remain
- Each FR has a priority indicator (format flexible)
- Each FR must include at least 2 acceptance criteria: 1 happy-path and 1 failure/edge-case (Given/When/Then or equivalent testable statement). Placeholders (TBD, TBA, N/A) are invalid
- At least 1 persona, 1 success metric, 1 NFR
- Scope Boundary: minimum 2 in-scope items and 2 out-of-scope items
- Competitive Analysis: minimum 3 apps, all 5 columns filled (no empty cells)
- Traceability Matrix: every FR has at least one Task ID and one test path — no empty cells. Every cell must reference existing IDs (FR-*, T-*, test path); placeholders (TBD, N/A, "later") are invalid
- Success Metric must specify: baseline (or "new"), target value, and measurement method
- **Testability rule**: Any FR/NFR using subjective terms (e.g., "fast", "robust", "secure", "user-friendly", "scalable") must include numeric or binary pass/fail criteria; otherwise GATE:FAIL
- **Validated by QA** (not the artifact author). Artifact must include `Validated-by: [role] [timestamp]`

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
| # | Task | Files | Owner | Depends On | Test |
|---|------|-------|-------|------------|------|
| T-1 | [description] | [file paths] | [role] | - | [test file/case] |

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

## Oracle Findings (required)
| Finding ID | Severity | Description | Resolution | Linked Task ID | Owner |
|------------|----------|-------------|------------|----------------|-------|
| OF-1 | High/Medium/Low | ... | Fixed/Deferred/Accepted | T-N or - | ... |
(if no findings were raised, include: `OF-0 | None | No findings | - | - | [validator role]`)

Gate rule: Any High severity finding without a mitigation task or explicit user-approved acceptance blocks gate passage.
```

**Validation rules**:
- Architecture Overview includes at least 1 rejected alternative with rationale
- Every created/modified file appears in the Files column (Option A) or Files field (Option B) and has exactly one owner
- Every task has a corresponding test — test file path must be specified (no "TBD" or placeholder)
- Task Breakdown contains at least max(3, number of FRs) task entries — a single monolithic task is GATE:FAIL
- Contracts section is non-empty (at least one State/Action or Dependency signature)
- No task without an owner
- Dependency graph is acyclic (no circular dependencies)
- **Validated by QA** (not the artifact author). Artifact must include `Validated-by: [role] [timestamp]`

## Hard Gate Enforcement

Phase 1 and Phase 2 gates require **independent validation** — the artifact author cannot self-certify.

- QA (or a designated validator) reviews the artifact against the schema above
- Required output: `GATE:PASS` or `GATE:FAIL` with specific deficiencies listed
- `GATE:FAIL` blocks phase transition — all implementation tasks remain locked
- Leader may not override `GATE:FAIL`; only fixing the deficiencies and re-validation can advance the gate
- User approval is required **after** `GATE:PASS`, not instead of it

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
- Evaluate "unrelated" using three attributes: (1) feature domain, (2) primary owned directory, (3) stakeholder objective
- If 2+ attributes changed from the previous task → shut down teammate + spawn fresh instance (prevents 200K context saturation)
- If 0-1 attributes changed → keep existing teammate
- Role name preserved; only internal instance changes
- Before any teammate shutdown, a handoff summary is mandatory. Follow the Handoff Summary Template defined in `up.md` (max 500 words, 4 required fields)

**Sub-agent constraints**:
- Task tool subagents are READ-ONLY (research/file reading only)
- Never delegate implementation, file edits, or other workspace-mutating work to subagents
- If implementation is required, the assigned teammate must perform it directly

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

### Decision Log SLA

Every gate approval, waiver, or exception must be logged in the project's decision file **within the same phase session**. A missing decision log entry blocks the next gate. This includes:
- Phase gate passage decisions
- Oracle waiver decisions
- Cross-ownership change approvals
- Architecture or scope changes after Phase 2 freeze
