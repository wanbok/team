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

- [ ] Requirements document complete (functional/non-functional, personas, success metrics)
- [ ] Competitive analysis (PM surveyed 3+ comparable apps/tools)
- [ ] Oracle review passed (if available)
- [ ] User approved

### Phase 2 → 3 (User Approval Required)

- [ ] Implementation plan (task breakdown, per-teammate assignments)
- [ ] UI design (design system, component specs, wireframes) — if applicable
- [ ] Architecture contracts frozen (State/Action contracts, dependency signatures)
- [ ] Oracle review passed (if available)
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
- [ ] Oracle final validation passed (if available)
- [ ] Requirements vs. feature completeness checklist confirmed

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
