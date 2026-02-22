---
description: "Audit the team framework health via cross-model (Codex) meta-review. Analyzes RPI enforcement, Oracle integration depth, artifact schema coverage, and context management."
---

# Framework Audit

Run a cross-model health check on the team framework configuration for the current project.

## Prerequisites

- Oracle role available (oracle plugin or Codex CLI)
- Project has been through at least one `/team:up` cycle, OR has framework docs to analyze

## Audit Procedure

### Step 1: Gather Context

Read the following files in parallel (skip if not found):

1. **Framework source of truth**: The team plugin's `commands/up.md` and `skills/workflow/SKILL.md`
2. **Project CLAUDE.md**: Current project's team rules and file ownership
3. **Phase artifacts**: Any requirements docs, implementation plans, decision logs in the project
4. **Vault learnings**: `~/Documents/vault/Tech/Agent Team Learnings.md`

Use a single Explore subagent to gather all files and return a summarized context bundle.

### Step 2: Parallel Area Audits

Send 5 **parallel** Oracle requests, one per area. Each area gets only its relevant context slice.

**Area 1: RPI Enforcement**
```
Audit this agent team framework's RPI (Research-Plan-Implement) enforcement.

[Include: Phase gate criteria from SKILL.md, Rules 1/12 from up.md, Artifact Schemas]

Score 1-5 on:
- Are Research (Phase 1) and Plan (Phase 2) gates mechanically enforced or just advisory?
- Can shallow documents pass gates? Is there a quality floor (acceptance criteria, scope minimums)?
- Is there a clear "no code before requirements" boundary with enforcement (not just policy text)?
- Is gate validation independent (non-author)?

Return: Score, specific gaps, concrete fix (exact text to add/change with file path).
```

**Area 2: Oracle Integration**
```
Audit this agent team framework's Oracle (cross-model verification) integration.

[Include: oracle.md, Rules 11 from up.md, Phase gate Oracle requirements from SKILL.md]

Score 1-5 on:
- Is Oracle review default-ON at Phase gates?
- Are waiver conditions explicit with AND logic?
- Are risk-based auto-triggers defined with concrete examples (not vague terms)?
- Do artifacts have a structured Oracle Findings table with severity-based gate blocking?
- Is there a decision log SLA for waivers?

Return: Score, specific gaps, concrete fix (exact text to add/change with file path).
```

**Area 3: Artifact Quality**
```
Audit this agent team framework's artifact quality gates.

[Include: Artifact Schemas from SKILL.md, validation rules]

Score 1-5 on:
- Do Phase 1/2 artifacts follow a structured schema with minimum counts?
- Are validation rules concrete and checkable (not just "all sections present")?
- Do artifacts include: scope boundary (with minimums), rejected alternatives, test mapping (no TBD)?
- Is third-party validation required (QA, not author)?
- Is there an Oracle Findings section in the schema?

Return: Score, specific gaps, concrete fix (exact text to add/change with file path).
```

**Area 4: Context Management**
```
Audit this agent team framework's context management strategy.

[Include: Leader Operating Discipline from up.md, Teammate Lifecycle from SKILL.md]

Score 1-5 on:
- Is teammate context rotation defined with concrete triggers (not just "unrelated")?
- Is leader context compaction addressed (soft/hard limits, compaction strategy)?
- Are sub-agent constraints (read-only) explicit in BOTH up.md and SKILL.md?
- Is there a handoff summary requirement before teammate shutdown?

Return: Score, specific gaps, concrete fix (exact text to add/change with file path).
```

**Area 5: Coordination**
```
Audit this agent team framework's coordination mechanisms.

[Include: File ownership rules, task assignment rules, feedback loop from up.md and SKILL.md, qa.md]

Score 1-5 on:
- Is file ownership clearly defined with a canonical template (not just "see project CLAUDE.md")?
- Are task assignment rules explicit for each phase (leader-assigned vs self-assigned)?
- Is the cross-ownership conflict resolution protocol defined?
- Are handoff packet formats defined between phases?
- Is the feedback loop (QA → lint rules) defined with closure proof requirement?
- Is the decision log SLA enforced (missing entry blocks next gate)?

Return: Score, specific gaps, concrete fix (exact text to add/change with file path).
```

### Step 3: Aggregate & Classify

Collect all 5 Oracle responses and compute:
- Per-area score (1-5)
- Overall health score (average)
- Classification per area:

| Severity | Action |
|----------|--------|
| Score 1-2 | **Blocking** — fix before next team launch |
| Score 3 | **Warning** — fix recommended |
| Score 4-5 | **Healthy** — no action needed |

### Step 4: Report

Output audit results to the user:

```markdown
## Framework Audit Report

**Overall Health**: [X.X/5]
**Date**: [YYYY-MM-DD]

### Scores
| Area | Score | Status |
|------|-------|--------|
| RPI Enforcement | X/5 | [status] |
| Oracle Integration | X/5 | [status] |
| Artifact Quality | X/5 | [status] |
| Context Management | X/5 | [status] |
| Coordination | X/5 | [status] |

### Priority Fixes
1. [fix description + specific file/line to change]
2. ...
3. ...

### Detailed Findings
[per-area gaps and recommendations]
```

### Step 5: Challenge Recommendations

Before applying, critically evaluate Oracle's concrete recommendations:

- **Specific numbers** (e.g., "500 words", "3 apps", "60% threshold"): Ask "why this number and not another?" Present at least 2 alternatives with trade-offs
- **New structural additions** (e.g., new schema sections, new checklist items): Assess whether the gap is real or theoretical — does the team actually hit this failure mode?
- **Reject or defer** recommendations that lack clear justification or address hypothetical problems

Present the challenged recommendations to the user with alternatives before applying.

### Step 6: Apply (Optional)

If user approves, apply the priority fixes directly:
- Edit framework files (workflow/SKILL.md, up.md, role templates)
- Commit changes to team plugin repo
- Sync relevant changes to project CLAUDE.md if needed
- Log the audit in the project's decision log

## When to Run

- After modifying framework rules (up.md, workflow/SKILL.md, role templates)
- Before launching a team on a new project type
- Periodically (every 2-3 team cycles) as a health check
- After a retrospective identifies framework-level issues
