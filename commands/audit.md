---
description: "Audit the team framework health via cross-model (Codex) meta-review. Analyzes RPI enforcement, Oracle integration depth, artifact schema coverage, and context management."
---

# Framework Audit

Run a cross-model health check on the team framework configuration for the current project.

## Prerequisites

- Oracle role available (claude-oracle plugin or Codex CLI)
- Project has been through at least one `/team:up` cycle, OR has framework docs to analyze

## Audit Procedure

### Step 1: Gather Context

Read the following files (skip if not found):

1. **Framework source of truth**: The team plugin's `commands/up.md` and `skills/workflow/SKILL.md`
2. **Project CLAUDE.md**: Current project's team rules and file ownership
3. **Phase artifacts**: Any requirements docs, implementation plans, decision logs in the project
4. **Vault learnings**: `~/Documents/vault/Tech/Agent Team Learnings.md`

### Step 2: Construct Audit Prompt

Send ALL gathered context to Oracle (Codex) with this structured prompt:

```
Audit this agent team framework configuration. Analyze these 5 areas and score each 1-5:

1. RPI ENFORCEMENT
   - Are Research (Phase 1) and Plan (Phase 2) gates mechanically enforced or just advisory?
   - Can shallow documents pass gates?
   - Is there a clear "no code before requirements" boundary?

2. ORACLE INTEGRATION
   - Is Oracle review default-ON at Phase gates?
   - Are waiver conditions explicit?
   - Are risk-based auto-triggers defined?

3. ARTIFACT QUALITY
   - Do Phase 1/2 artifacts follow a structured schema?
   - Are validation rules concrete and checkable?
   - Do artifacts include: scope boundary, rejected alternatives, test mapping?

4. CONTEXT MANAGEMENT
   - Is teammate context rotation defined?
   - Is leader context compaction addressed?
   - Are sub-agent constraints (read-only) explicit?

5. COORDINATION
   - Is file ownership clearly defined?
   - Are task assignment rules explicit for each phase?
   - Is the feedback loop (QA → lint rules) defined?

For each area:
- Score (1-5)
- Specific gaps found
- Concrete fix (exact text or rule to add)

End with: Overall health score (average) and top 3 priority fixes.
```

### Step 3: Process Results

Parse Codex response and classify findings:

| Severity | Action |
|----------|--------|
| Score 1-2 | **Blocking** — fix before next team launch |
| Score 3 | **Warning** — fix recommended |
| Score 4-5 | **Healthy** — no action needed |

### Step 4: Report

Output audit results to the user:

```markdown
## Framework Audit Report

**Overall Health**: [X/5]
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
[per-area gaps and recommendations from Codex]
```

### Step 5: Apply (Optional)

If user approves, apply the priority fixes directly:
- Edit framework files (workflow/SKILL.md, up.md, project CLAUDE.md)
- Commit changes
- Log the audit in the project's decision log

## When to Run

- After modifying framework rules (up.md, workflow/SKILL.md, oracle.md)
- Before launching a team on a new project type
- Periodically (every 2-3 team cycles) as a health check
- After a retrospective identifies framework-level issues
