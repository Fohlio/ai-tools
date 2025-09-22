# ai-tools

A lightweight, opinionated collection of agent specs, rules, and links for building AI-assisted workflows. This repo focuses on clarity, interoperability (MCP), and pragmatic execution.

## What’s inside

- `AGENTS.md` — Overview of available agents with roles and links
- `CLAUDE.md` — Guidelines for using Claude effectively in this repo
- `links.md` — Curated developer-oriented AI links
- `subagents/` — Individual agent personas/specs
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
│  └── cursor.json
├── rules/
│  └── claude-rules.md
└── subagents/
   ├── ai-sdk-prompt-architect.md
   ├── app-replication-architect.md
   ├── code-reviewer-typescript-nextjs.md
   ├── dialogue-story-specialist.md
   ├── flutter-ux-architect.md
   ├── fsd-architecture-specialist.md
   ├── game-design-architect.md
   ├── mui-design-expert.md
   ├── nextjs-fsd-developer.md
   ├── product-marketing-strategist.md
   ├── project-manager.md
   ├── psychology-consultant.md
   ├── technical-integration-architect.md
   └── telegram-bot-architect.md
```

## Notes on MCP configuration

- `mcp/cursor.json` is provided as an example. Ensure you manage tokens via environment variables or your editor’s secrets manager. Avoid committing credentials.

## Contributing

- Keep edits minimal, documented, and aligned with existing patterns.
- Prefer updating `AGENTS.md` and `CLAUDE.md` when adding agents or guidelines.
- Validate links in `links.md` when updating categories.

## License

This project is licensed under the MIT License. See `LICENSE` for details.
