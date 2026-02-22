---
description: "Create and launch an agent team for a project. Dynamically composes the optimal team based on project needs."
argument-hint: "<project description or path>"
---

Create an agent team for the project: $ARGUMENTS

## Team Composition Protocol

### Phase 0 — Team Composition

1. **Spawn PM first** (Opus, plan mode). PM analyzes the project and proposes a team from the Role Catalog.
2. **Spawn team-reviewer** (Sonnet). Reviews PM's proposal for:
   - Tech stack coverage (correct dev roles for the project)
   - Team size appropriateness (no over/under-staffing)
   - Required roles present (pm + dev(s) + qa minimum)
   - Unnecessary roles removed
3. Present final proposal to user for approval.
4. Spawn only the approved roles. team-reviewer shuts down after Phase 0.

### Role Catalog

Select roles based on project needs. Multiple instances allowed for dev roles (e.g., ios-a, ios-b).

| Role | Description | Skills | Model | Multiple |
|------|-------------|--------|-------|----------|
| pm | Requirements, task breakdown, competitive analysis | brainstorming, writing-plans | Opus | - |
| designer | UI/UX design, design system | ui-ux-pro-max | Opus | - |
| ios-dev | iOS development (SwiftUI/TCA) | test-driven-development, composable-architecture | Opus | Yes |
| flutter-dev | Flutter development | test-driven-development | Opus | Yes |
| frontend-dev | Web frontend development | test-driven-development | Opus | Yes |
| backend-dev | Backend API development | test-driven-development | Opus | Yes |
| qa | Testing, code review | verification-before-completion | Opus | - |
| ui-tester | Device/simulator UI testing | - | Opus | - |
| oracle | Cross-model verification (Codex/GPT). Read-only consultant | ask-oracle | Sonnet | - |

For non-app domains, map dev roles to domain specialists (e.g., Platform Engineer, ETL Engineer, ML Engineer).

### Leader Operating Discipline

- **Delegate everything**. Leader focuses ONLY on orchestration.
- **Leader does**: receive reports, communicate with user, make decisions, assign tasks.
- **Leader does NOT**: implement, research, explore codebase (delegate to teammates).
- Log every important decision immediately.
- Self-verification after every major analysis:
  1. What was the hardest decision?
  2. What alternatives were rejected and why?
  3. What am I least confident about?
- Do NOT intervene with idle teammates who have active tasks (they may be waiting for subagents).
  - Exception: blocker unreported >10min or deadlock detected.
- Context rotation: when next task is unrelated to previous work (changes 2+ of: feature domain, primary owned directory, stakeholder objective), shut down teammate and spawn fresh instance with same role name. Write a handoff summary before shutdown.
- Task tool subagents are READ-ONLY (research/file reading only). Never delegate implementation to subagents.

### Coordination Protocols

**Cross-ownership changes**:
- If a task spans more than one ownership area, leader creates a joint task with a primary owner and required co-reviewers before any coding begins.
- Other teammates wait until the cross-ownership change is complete before modifying related files.

**Handoff packets**:
- Phase 2→3: each task assignment must include Task ID, owner role, reviewer role, and acceptance test reference.
- Phase 3→4: dev submits an evidence packet per Task ID before QA review: test run output, coverage report, and diff summary.
- Phase 4→5: QA submits test summary with pass/fail counts, coverage percentage, and list of open issues.

**Decision log SLA**:
- Every gate approval, waiver, or exception must be logged in the project decision file within the same phase session. A missing entry blocks the next gate.

### Workflow Phases

```
Phase 0: Team Composition [user approval]
  → Phase 1: Discovery [user approval]
  → Phase 2: Design [user approval]
  → Phase 3: Development [auto]
  → Phase 4: QA [auto]
  → Phase 5: Finalization [auto]
```

**Phase 1 (Discovery)**: PM gathers requirements via brainstorming + brief competitive analysis. Oracle reviews requirements (mandatory). Wait for user approval.

**Phase 2 (Design)**: PM writes implementation plan, designer creates UI specs. Oracle reviews architecture (mandatory, blocking). Wait for user approval.

**Phase 3 (Development)**: Devs implement features in parallel with TDD. QA reviews continuously. Oracle available on request. Do NOT stop.

**Phase 4 (QA)**: QA leads testing. UI-tester runs scenario + random tests. Oracle provides second opinions on critical issues. Failed tests reassigned to devs automatically.

**Phase 5 (Finalization)**: Final code review, build verification, UI-tester final pass, Oracle final validation (mandatory), completion checklist.

### Mandatory Rules

1. **Requirements first** — NO code before requirements are approved. Requirements must pass the Artifact Schema (see workflow skill)
2. **TDD required** — ALL code must have tests written FIRST (Red → Green → Refactor). Implementation plan must map every task to a test
3. **File ownership** — Each teammate only edits their own directories (defined in project CLAUDE.md)
4. **Evidence-based completion** — Use verification-before-completion before ANY completion claims
5. **Code review required** — QA reviews all major features before proceeding
6. **Task assignment** — Phase 1-2: leader assigns. Phase 3-5: self-assign within own ownership scope
7. **Lifecycle management** — Idle teammates with active tasks are NOT interrupted. Fresh instances for unrelated tasks
8. **Non-stop development** — After Phase 2 approval, DO NOT STOP until Phase 5 is complete
9. **Feedback loops** — QA pattern repeated 2+ times → add linter rule or golden rule
10. **Only work on tasks assigned to YOU** — Do NOT complete another teammate's task
11. **Oracle default ON** — Oracle review is mandatory at Phase 1→2, 2→3, and Phase 5 gates. Waiver requires explicit user approval with reason logged. Auto-triggered on: security decisions (auth/authz, secrets, encryption, PII), DB migrations, new architecture patterns (framework or design pattern not previously used), external API integrations (new outbound endpoint or third-party SDK), large diffs (10+ files)
12. **Hard gate lock** — No implementation task may begin until Phase 1 and Phase 2 each receive `GATE:PASS` from QA (not the leader or artifact author) plus user approval. `GATE:FAIL` blocks all downstream work
