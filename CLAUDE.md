# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a collection of AI agent specifications, rules, and curated links for building AI-assisted workflows. No build system or tests—just markdown files organizing agent personas and integration configurations.

## Structure

- `subagents/` — Agent specs with YAML frontmatter (name, description, model, color) and markdown body defining behavior, deliverables, and workflow
- `skills/` — Reusable Claude Code skills with executable scripts
- `rules/` — Shared guidelines (e.g., `claude-rules.md`)
- `mcp/` — MCP server configurations for editor integrations
- `links.md` — Curated AI/developer tool links

## Agent Spec Format

Each file in `subagents/` follows this pattern:

```markdown
---
name: agent-name
description: One-line description
model: sonnet|opus|haiku
color: color-name
---

[Agent instructions in markdown]
```

## Commands

Custom slash commands in `commands/` for orchestrated workflows:

| Command | Description |
|---------|-------------|
| `/c-implement-feature` | Full workflow: Plan → Implement → Test → Review → Verify |
| `/c-implement-tdd-feature` | TDD workflow: Plan → **Test** → Implement → Refactor → Verify |
| `/c-implement-s-feature` | Simple: Plan → Implement → Simplify |
| `/c-implement-s-tdd-feature` | Simple TDD: Plan → **Test** → Implement → Simplify |

## Key Conventions

1. **Planning mode**: Agents ask clarifying questions before implementation; require explicit approval at stage gates
2. **Audit before building**: Search for existing components/patterns before creating new ones
3. **No placeholders**: Implement fully or explicitly ask to defer — never leave TODO/FIXME comments
4. **Minimal changes**: Do not over-engineer; make precise fixes; avoid unnecessary files and console logs
5. **Context7**: Use `mcp__context7__resolve-library-id` and `mcp__context7__query-docs` to fetch library documentation

## Skills

Skills in `skills/` are self-contained Claude Code skills with TypeScript scripts. To use a skill in another project:

1. Copy the skill folder to your project's `.claude/skills/`
2. Run `npm install` in the skill folder
3. Set required environment variables (e.g., `OPENAI_API_KEY`)

Each skill has a `SKILL.md` defining when/how Claude should use it, and a `README.md` with setup instructions.

## MCP Configuration

`mcp/cursor.json` contains example MCP server configs (Context7, Playwright, Figma, GitHub, Supabase, etc.). Tokens should be injected via environment variables—never commit credentials.
