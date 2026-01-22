# CLAUDE.md

Guidance for Claude Code when working in this repository.

## Repository Overview
A curated collection of AI agent personas, slash commands, and MCP configurations for building advanced AI-assisted workflows.

## Key Conventions
1. **Planning First**: Always ask clarifying questions and present a plan before implementation.
2. **Audit & Reuse**: Search for existing components/patterns before creating new ones.
3. **No Placeholders**: Fully implement features; never leave `TODO` or `FIXME` comments.
4. **Minimalism**: Make precise, non-destructive changes. Avoid unnecessary files or logs.
5. **Context7**: Use `mcp__context7__resolve-library-id` and `mcp__context7__query-docs` for up-to-date library documentation.

## Commands
Custom slash commands in `commands/` orchestrate multi-agent workflows:
- `/implement-feature`: Plan → Implement → Test → Review → Verify.
- `/design-review`: Audit → Critique → Optimize (based on `ux-optimiser`).
- `/team-review`: Multi-agent review (Architect, UX, Sales, PM, Refactorer).
- `/refactor-code`: Simplify and improve readability.

## Structure
- `subagents/`: Agent personas with YAML frontmatter.
- `commands/`: Markdown-based workflow orchestrations.
- `skills/`: Executable Claude Code skills (TypeScript).
- `mcp/`: MCP server configurations (Context7, Figma, Stitch, etc.).

## Agent Format
Files in `subagents/` must include YAML frontmatter:
```markdown
---
name: agent-name
description: One-line description
model: sonnet|opus|haiku
color: color-name
---
```

## MCP Setup
`mcp/mcp.json` contains reference configs. Inject tokens via environment variables; never commit credentials.
