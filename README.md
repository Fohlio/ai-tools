# ai-tools

A lightweight, opinionated collection of agent specs, rules, and links for building AI-assisted workflows. This repo focuses on clarity, interoperability (MCP), and pragmatic execution.

## What's inside

- `links.md` — Curated developer-oriented AI links
- `subagents/` — Individual agent personas/specs
- `skills/` — Reusable Claude Code skills with scripts (copy to your project's `.claude/skills/`)
- `rules/` — Additional rules and guidelines (e.g., `rules/claude-rules.md`)
- `mcp/cursor.json` — Example MCP server configuration for local tooling

## Quick start

1. Browse agent capabilities in `AGENTS.md` and open the corresponding file under `subagents/`.
2. Follow `CLAUDE.md` for interaction style and output quality when using Claude.
3. Use `links.md` to quickly jump to provider docs, SDKs, and tooling.

## Repo structure

```
.
├── AGENTS.md
├── CLAUDE.md
├── links.md
├── mcp/
│   └── cursor.json
├── rules/
│   └── claude-rules.md
├── skills/
│   └── create-game-assets/   # DALL-E 3 game asset generator
│       ├── SKILL.md
│       ├── README.md
│       ├── package.json
│       └── src/
└── subagents/
    ├── ai-sdk-prompt-architect.md
    ├── code-reviewer.md
    ├── fsd-architecture-specialist.md
    ├── project-manager.md
    └── ... (more agents)
```

## Notes on MCP configuration

- `mcp/cursor.json` is provided as an example. Ensure you manage tokens via environment variables or your editor’s secrets manager. Avoid committing credentials.

## Contributing

- Keep edits minimal, documented, and aligned with existing patterns.
- Prefer updating `AGENTS.md` and `CLAUDE.md` when adding agents or guidelines.
- Validate links in `links.md` when updating categories.

## License

This project is licensed under the MIT License. See `LICENSE` for details.
