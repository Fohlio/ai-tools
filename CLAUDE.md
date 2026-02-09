# CLAUDE.md

Guidance for Claude Code when working in this repository.

## Repository Overview

A curated collection of AI agent personas, slash commands, skills, and MCP configurations for building advanced AI-assisted workflows.

## Key Conventions

1. **Planning First**: Always ask clarifying questions and present a plan before implementation.
2. **Audit & Reuse**: Search for existing components/patterns before creating new ones.
3. **No Placeholders**: Fully implement features; never leave `TODO` or `FIXME` comments.
4. **Minimalism**: Make precise, non-destructive changes. Avoid unnecessary files or logs.
5. **Context7**: Use `mcp__context7__resolve-library-id` and `mcp__context7__query-docs` for up-to-date library documentation.
6. **Build Verification**: Never mark a task as "Done" without successful build and test verification.

## Structure

```
ai-tools/
├── agents/           # Agent personas with YAML frontmatter
├── commands/         # Slash command workflow orchestrations
├── skills/           # Executable Claude Code skills
└── mcp/              # MCP server configurations
```

## Commands

Custom slash commands in `commands/` orchestrate multi-agent workflows:

| Command | Description |
|---------|-------------|
| `/implement-feature` | Standard: Plan → Implement → Test → Refactor → Verify |
| `/implement-tdd-feature` | TDD: Tests first → Implement → Refactor → Verify |
| `/implement-bdd-feature` | BDD: Gherkin → Tests → Implement → Verify |
| `/test-code` | Write automated tests (Playwright/Jest/Vitest) |
| `/refactor-code` | Simplify and improve readability |
| `/prd-creation` | Create Product Requirements Document |
| `/team-review` | Multi-agent review (Architect, UX, Sales, PM, Refactorer) |
| `/business-review` | Product-marketing audit (5C/SWOT framework) |

## Agents

Files in `agents/` define specialized AI personas:

| Agent | Purpose |
|-------|---------|
| `code-architect` | Full-stack architecture and implementation |
| `code-tester` | QA automation (Playwright, Jest, Vitest) |
| `code-refactorer` | Code simplification and maintainability |
| `ux-designer` | UX/UI design with Stitch and Figma |
| `project-manager` | Planning, priorities (P0-P2), T-shirt sizing |
| `sales-marketer` | Growth marketing and CRO |
| `build-verificator` | Quality gates and completeness audits |
| `mobile-architect` | Flutter/cross-platform development |
| `librarian` | Project documentation and knowledge management |

## Skills

Executable skills in `skills/`:

- `feature-implementation`: Orchestrates Standard/TDD/BDD workflows
- `prompt-engineering`: Research-backed prompt optimization
- `poc-hypothesis`: Quick technical validation with multiple hypotheses and real BE endpoints
- `bug-tracing`: Hypothesis-driven debugging with instrumented logging (`tmp/debug.log`)
- `analyze-architecture`: Systematic architecture audit (13-section checklist with scorecard)
- `humanizer`: Remove AI writing patterns
- `agent-browser`: Browser automation CLI
- `create-design-system`: Design system creation guide
- `replicate`: Reverse-engineer a feature (architecture + user flow + design) and produce an integration PRD

## Agent Format

Files in `agents/` must include YAML frontmatter:

```markdown
---
name: agent-name
description: One-line description
tools: Tool1, Tool2, ...
model: opus|sonnet|haiku
color: color-name
---
```

## MCP Setup

`mcp/mcp.json` contains reference configs for:
- **Context7**: Library documentation
- **Playwright**: Browser testing
- **GitHub**: Repository operations
- **Figma**: Design context
- **Stitch**: UI prototyping
- **Vercel**: Deployment
- **Sentry**: Error monitoring
- **DeepWiki**: Documentation search
- **Agents Playbook**: Workflow patterns

Inject tokens via environment variables; never commit credentials.
