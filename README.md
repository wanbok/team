# agent-team-framework

Dynamic multi-agent team orchestration for [Claude Code](https://claude.com/claude-code). Spawns specialized teams that build your project through structured phases — from requirements to production.

[한국어](README.ko.md)

## What It Does

Instead of one AI coding alone, this framework creates a **team of specialized agents** that collaborate like a real development team:

```
You (Leader)
├── PM           — gathers requirements, breaks down tasks
├── Designer     — creates UI specs and design systems
├── Dev A        — implements Feature A with TDD
├── Dev B        — implements Feature B with TDD
├── QA           — reviews code, runs tests
└── Oracle       — cross-model verification (optional)
```

The team follows a **6-phase pipeline** with quality gates:

```
Phase 0: Team Composition [you approve the team]
  → Phase 1: Discovery [you approve requirements]
  → Phase 2: Design [you approve the plan]
  → Phase 3: Development [auto — TDD, parallel]
  → Phase 4: QA [auto — testing, review]
  → Phase 5: Finalization [auto — build, verify]
```

You approve Phases 0-2, then the team runs autonomously through 3-5.

## Install

### As a Claude Code Plugin (Recommended)

```bash
# Via marketplace (if registered)
/plugin install agent-team-framework@wanbok-claude-marketplace

# Or directly from GitHub
/plugin install --source github:wanbok/agent-team-framework
```

### Manual Install

```bash
git clone https://github.com/wanbok/agent-team-framework.git
cd agent-team-framework
chmod +x install.sh
./install.sh
```

## Usage

### `/team:up` — Launch a Team

```
/team:up SwiftUI + TCA iOS app for a pet adoption marketplace
/team:up Flutter mobile app for a fitness tracker with social features
/team:up Full-stack web app for an internal HR tool
```

The PM will analyze your project, propose a team, and guide you through the phases.

### `/team:design` — Design a Custom Team

```
/team:design IoT smart home integration platform
/team:design Data pipeline for real-time analytics
/team:design iPad drawing app with Apple Pencil support
```

This command analyzes your domain and maps the generic role catalog to specialized roles.

## Role Catalog

| Role | Description | Model | Multiple |
|------|-------------|-------|----------|
| pm | Requirements, planning, competitive analysis | Opus | - |
| designer | UI/UX, design system, wireframes | Opus | - |
| ios-dev | iOS (SwiftUI/TCA) | Opus | Yes |
| flutter-dev | Flutter/Dart | Opus | Yes |
| frontend-dev | Web frontend | Opus | Yes |
| backend-dev | Backend API | Opus | Yes |
| qa | Testing, code review | Opus | - |
| ui-tester | Device/simulator UI testing | Opus | - |
| oracle | Cross-model verification (read-only) | Sonnet | - |

For non-app domains, dev roles are mapped to domain specialists:

| Domain | Possible Roles |
|--------|---------------|
| IoT/Infra | Platform Engineer, Integrator, Architect |
| Data | ETL Engineer, ML Engineer, Schema Designer |
| CLI Tools | Core Dev, Plugin Dev (no designer needed) |

## Key Principles

1. **Requirements First** — no code until requirements are approved
2. **TDD Required** — all code starts with tests (Red → Green → Refactor)
3. **File Ownership** — each teammate owns specific directories; no conflicts
4. **Evidence-Based Completion** — "done" requires test evidence
5. **Non-Stop Development** — after Phase 2, the team doesn't stop until Phase 5
6. **Feedback Loops** — recurring QA patterns become lint rules

## Works Great With

### [claude-oracle](https://github.com/wanbok/claude-oracle)

Cross-model verification plugin. When installed, the Oracle role in your team automatically uses it for:
- Architecture review at Phase Gates
- Code review second opinions
- Alternative implementation suggestions

```bash
# Install oracle for enhanced team verification
git clone https://github.com/wanbok/claude-oracle.git
cd claude-oracle && ./install.sh
```

### [superpowers](https://github.com/obra/superpowers)

The framework references superpowers skills (brainstorming, writing-plans, test-driven-development, etc.). Install superpowers for the full experience:

```
/plugin install superpowers@claude-code-plugins
```

## Customization

### Templates

Copy and customize for your project:

- `templates/CLAUDE.md.template` — team configuration to add to your project's CLAUDE.md
- `templates/roles/` — detailed role definitions (pm, designer, dev, qa, oracle)

### Examples

- `examples/ios-app-team.md` — iOS SwiftUI + TCA team
- `examples/flutter-app-team.md` — Flutter mobile team
- `examples/web-service-team.md` — Full-stack web team

## Plugin Structure

```
agent-team-framework/
├── .claude-plugin/
│   └── plugin.json          # Plugin manifest (name: "team")
├── commands/
│   ├── up.md                # /team:up — launch a team
│   └── design.md            # /team:design — design a custom team
├── skills/
│   └── workflow/
│       └── SKILL.md         # Phase workflow guide
├── agents/
│   └── reviewer.md          # Phase 0 team composition reviewer
├── templates/
│   ├── CLAUDE.md.template   # Project configuration template
│   └── roles/               # Role definitions
├── examples/                # Example team compositions
├── install.sh               # Manual installation
└── uninstall.sh             # Manual uninstallation
```

## License

MIT
