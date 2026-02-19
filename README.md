# AI Tools

A curated collection of AI agent personas, slash commands, skills, and MCP configurations for Claude Code and Cursor.

## Quick Start

```bash
git clone https://github.com/Fohlio/ai-tools.git ~/projects/ai-tools
cd ~/projects/ai-tools && ./sync.sh
```

---

## Commands

Slash commands in `commands/` orchestrate multi-agent workflows:

| Command | Description |
|---------|-------------|
| `/ai-tools:implement-feature` | Standard workflow: Plan → Implement → Test → Refactor → Verify |
| `/ai-tools:implement-tdd-feature` | TDD workflow: Tests first → Implement → Refactor → Verify |
| `/ai-tools:implement-bdd-feature` | BDD workflow: Gherkin scenarios → Tests → Implement → Verify |
| `/ai-tools:test-code` | Analyze code, write automated tests (Playwright/Jest/Vitest) |
| `/ai-tools:refactor-code` | Simplify and improve code readability and scalability |
| `/ai-tools:prd-creation` | Create a comprehensive Product Requirements Document |
| `/ai-tools:team-review` | Multi-agent review (Architect, UX, Sales, PM, Refactorer) |
| `/ai-tools:business-review` | Product-marketing audit using 5C/SWOT framework |
---

## Agents

Agent personas in `agents/` with specialized expertise:

| Agent | Description |
|-------|-------------|
| `code-architect` | Senior Full-Stack Architect (Clean Architecture, SOLID, DDD) |
| `code-tester` | QA Automation Engineer (Playwright, Jest, Vitest) |
| `code-refactorer` | Code simplification and maintainability expert |
| `ux-designer` | UX/UI Designer using Stitch and Figma |
| `project-manager` | Task decomposition, P0-P2 priorities, T-shirt sizing |
| `sales-marketer` | Growth marketing, CRO, and conversion optimization |
| `build-verificator` | Quality gate verification and completeness audits |
| `mobile-architect` | Flutter/cross-platform mobile specialist |
| `researcher` | Creative researcher: Web search, Context7, brainstorming |

---

## Skills

Executable skills in `skills/` for specialized tasks:

| Skill | Description |
|-------|-------------|
| `feature-implementation` | Orchestrates Standard, TDD, or BDD workflows with quality gates |
| `prompt-engineering` | Research-backed prompt optimization for Claude, GPT, Gemini, etc. |
| `poc-hypothesis` | Quick technical validation with multiple hypotheses and self-testable BE endpoints |
| `bug-tracing` | Hypothesis-driven debugging with instrumented logging and user-assisted reproduction |
| `analyze-architecture` | Systematic 13-section architecture audit with scorecard output |
| `humanizer` | Remove AI writing patterns to sound more natural |
| `agent-browser` | Browser automation CLI for testing and interaction |
| `create-design-system` | Guides creation of design systems (goals, foundations, components) |

---

## MCP Servers

Reference configurations in `mcp/mcp.json`:

| Server | Purpose |
|--------|---------|
| **Context7** | Up-to-date library documentation |
| **Playwright** | Browser automation and testing |
| **GitHub** | Repository operations via Docker |
| **Figma** | Design context extraction |
| **Stitch** | AI-powered UI prototyping |
| **Vercel** | Deployment and hosting |
| **Sentry** | Error monitoring |
| **DeepWiki** | Documentation search |
| **Agents Playbook** | Agent workflow patterns |

---

## Environment Variables

```bash
export GITHUB_PERSONAL_ACCESS_TOKEN="ghp_..."
export OPENAI_API_KEY="sk-..."
```

---

## Principles

1. **Plan First** — Always ask clarifying questions before coding
2. **Audit & Reuse** — Search for existing patterns before creating new ones
3. **No Placeholders** — Full implementation only, no TODOs or FIXMEs
4. **Context7** — Always use for up-to-date library documentation
5. **Verify** — Never mark done without build verification

---

## License

MIT
