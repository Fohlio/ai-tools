# ai-tools

A lightweight, opinionated collection of agent specs, rules, and links for building AI-assisted workflows. This repo focuses on clarity, interoperability (MCP), and pragmatic execution.

## What's inside

- `links.md` — Curated developer-oriented AI links
- `subagents/` — Individual agent personas/specs
- `skills/` — Reusable Claude Code skills with scripts (copy to your project's `.claude/skills/`)
- `rules/` — Additional rules and guidelines (e.g., `rules/claude-rules.md`)
- `commands/` — Custom slash commands for Claude Code workflows
- `mcp/cursor.json` — Example MCP server configuration for local tooling

---

## Installing Claude Code

### Via npm (recommended)

```bash
npm install -g @anthropic-ai/claude-code
```

### Via Homebrew (macOS)

```bash
brew install claude-code
```

### Verify installation

```bash
claude --version
```

### Update to latest version

```bash
npm update -g @anthropic-ai/claude-code
# or
brew upgrade claude-code
```

---

## Configuration Paths

Claude Code uses two configuration scopes:

| Scope | Path | Purpose |
|-------|------|---------|
| **User-level** | `~/.claude/` | Global settings, MCP servers, commands available everywhere |
| **Project-level** | `.claude/` (in project root) | Project-specific commands, skills, settings |

Key files:
- `~/.claude/settings.json` — Global MCP servers, permissions
- `.claude/settings.json` — Project MCP servers, settings override
- `.claude/commands/` — Custom slash commands
- `.claude/skills/` — Executable skill scripts

---

## Adding MCP Servers

MCP servers extend Claude Code with external tools (GitHub, Figma, databases, etc.).

### Option 1: Edit settings.json directly

**Global (all projects):**

```bash
# Open or create the settings file
mkdir -p ~/.claude
nano ~/.claude/settings.json
```

**Project-level:**

```bash
mkdir -p .claude
nano .claude/settings.json
```

Add servers in this format:

```json
{
  "mcpServers": {
    "context7": {
      "url": "https://mcp.context7.com/mcp"
    },
    "Playwright": {
      "command": "npx -y @modelcontextprotocol/server-playwright",
      "env": {}
    },
    "GitHub": {
      "command": "docker run -i --rm -e GITHUB_PERSONAL_ACCESS_TOKEN ghcr.io/github/github-mcp-server",
      "env": {
        "GITHUB_PERSONAL_ACCESS_TOKEN": "${GITHUB_PERSONAL_ACCESS_TOKEN}"
      }
    }
  }
}
```

### Option 2: Copy from this repo

```bash
# Copy example MCP config as a starting point
cp mcp/cursor.json ~/.claude/settings.json
```

Then edit to keep only the servers you need and add your tokens.

### Option 3: Via Claude Code CLI

```bash
claude mcp add context7 --url https://mcp.context7.com/mcp
claude mcp add playwright --command "npx -y @modelcontextprotocol/server-playwright"
```

### Server types

| Type | Config key | Example |
|------|------------|---------|
| **HTTP/SSE** | `url` | `"url": "https://mcp.context7.com/mcp"` |
| **Stdio** | `command` | `"command": "npx -y @some/mcp-server"` |
| **With env vars** | `env` | `"env": { "API_KEY": "${API_KEY}" }` |

---

## Adding Commands

Commands are custom slash commands (e.g., `/implement-feature`) that orchestrate multi-step workflows.

### Option 1: Copy to user-level (available globally)

```bash
mkdir -p ~/.claude/commands
cp commands/*.md ~/.claude/commands/
```

### Option 2: Copy to project-level

```bash
mkdir -p .claude/commands
cp /path/to/ai-tools/commands/*.md .claude/commands/
```

### Command format

Commands are Markdown files with YAML frontmatter:

```markdown
---
name: my-command
description: What this command does
allowed-tools: Task, Read, Edit, Write, Bash
---

# Instructions for Claude

Your workflow steps here...
```

### Usage

After adding, use in Claude Code:

```
/c-implement-feature path/to/feature-spec.md
/c-implement-tdd-feature path/to/feature-spec.md
/c-implement-bdd-feature path/to/feature-spec.md
```

---

## Adding Skills

Skills are executable scripts that Claude Code can run (image generation, API calls, etc.).

### Option 1: Copy skill folder to project

```bash
mkdir -p .claude/skills
cp -r /path/to/ai-tools/skills/create-game-assets .claude/skills/

# Install dependencies
cd .claude/skills/create-game-assets
npm install
```

### Option 2: Symlink for development

```bash
mkdir -p .claude/skills
ln -s /path/to/ai-tools/skills/create-game-assets .claude/skills/create-game-assets
```

### Skill structure

Each skill folder contains:

```
skill-name/
├── SKILL.md      # Instructions for Claude (when/how to use)
├── README.md     # Human documentation
├── package.json  # Dependencies
└── src/          # Executable scripts
```

### Required env vars

Set environment variables for skills that need them:

```bash
export OPENAI_API_KEY="sk-..."  # For create-game-assets
```

---

## Adding Subagents

Subagents are specialized agent personas used with Claude Code's `Task` tool for orchestration.

### Option 1: Reference directly (recommended)

Point Claude to the subagent file when needed:

```
Use the code-architect agent from /path/to/ai-tools/subagents/general/code-architect.md
```

### Option 2: Copy to project

```bash
mkdir -p .claude/agents
cp /path/to/ai-tools/subagents/general/*.md .claude/agents/
cp /path/to/ai-tools/subagents/specific/*.md .claude/agents/
```

### Subagent format

Subagents are Markdown files with YAML frontmatter:

```markdown
---
name: agent-name
description: One-line description
tools: Task, Read, Edit, Write, Bash, mcp__context7__query-docs
model: opus
color: cyan
---

# Agent instructions

Role, capabilities, workflow...
```

### Available subagents

**General-purpose:**
- `code-architect` — Full-stack implementation
- `code-refactorer` — Code quality improvements
- `code-reviewer` — PR review and feedback
- `code-tester` — Test writing and coverage
- `build-verificator` — Build validation
- `ux-optimiser` — UI/UX audit

**Specialized:**
- `game-design-architect` — Game development
- `fsd-architecture-specialist` — Feature-Sliced Design
- `startup-hub-agent` — Startup tooling

---

## Quick Setup (Copy Everything)

To set up all configurations at once:

```bash
# Clone the repo
git clone https://github.com/yourusername/ai-tools.git ~/projects/ai-tools

# Create Claude config directory
mkdir -p ~/.claude/{commands,skills}

# Copy MCP config (edit to add your tokens)
cp ~/projects/ai-tools/mcp/cursor.json ~/.claude/settings.json

# Copy all commands
cp ~/projects/ai-tools/commands/*.md ~/.claude/commands/

# Copy skills you need
cp -r ~/projects/ai-tools/skills/create-game-assets ~/.claude/skills/
cd ~/.claude/skills/create-game-assets && npm install

# Set required env vars in your shell profile
echo 'export OPENAI_API_KEY="your-key"' >> ~/.zshrc
echo 'export GITHUB_PERSONAL_ACCESS_TOKEN="your-token"' >> ~/.zshrc
```

---

## Quick start

1. Follow `CLAUDE.md` for interaction style and output quality when using Claude.
2. Use `links.md` to quickly jump to provider docs, SDKs, and tooling.

## Repo structure

```
.
├── CLAUDE.md
├── commands/                # Custom Claude Code orchestration workflows
│   ├── c-implement-feature.md           # Full: Plan → Implement → Test → Review
│   ├── c-implement-tdd-feature.md       # TDD: Plan → Test → Implement → Refactor
│   ├── c-implement-bdd-feature.md       # BDD: Plan → Gherkin+Tests → Implement
│   ├── c-implement-s-feature.md         # Simple: Plan → Implement → Simplify
│   ├── c-implement-s-tdd-feature.md     # Simple TDD: Plan → Test → Implement
│   └── c-implement-s-bdd-feature.md     # Simple BDD: Plan → Gherkin+Tests → Implement
├── links.md
├── mcp/
│   └── cursor.json
├── rules/
│   └── claude-rules.md
├── skills/
│   ├── create-game-assets/   # DALL-E 3 game asset generator
│   │   ├── SKILL.md
│   │   ├── README.md
│   │   ├── package.json
│   │   └── src/
│   ├── implement-tdd-feature/ # TDD workflow: tests first, then implementation
│   │   ├── SKILL.md
│   │   └── README.md
│   ├── poc-hypothesis/       # Rapid POC for hypothesis validation
│   │   ├── SKILL.md
│   │   └── README.md
│   └── remove-background/    # Remove image backgrounds (rembg)
│       ├── SKILL.md
│       └── README.md
└── subagents/
    ├── general/              # Core development & management agents
    │   ├── project-manager.md
    │   ├── code-architect.md
    │   ├── code-refactorer.md
    │   ├── code-reviewer.md
    │   ├── code-tester.md
    │   ├── build-verificator.md
    │   ├── mobile-architect.md
    │   ├── ux-optimiser.md
    │   └── technical-integration-architect.md
    └── specific/             # Specialized technology & domain agents
        ├── app-replication-architect.md
        ├── dialogue-story-specialist.md
        ├── fsd-architecture-specialist.md
        ├── game-design-architect.md
        ├── product-marketing-strategist.md
        ├── psychology-consultant.md
        └── startup-hub-agent.md
```

## Notes on MCP configuration

- `mcp/cursor.json` is provided as an example. Ensure you manage tokens via environment variables or your editor’s secrets manager. Avoid committing credentials.

## Contributing

- Keep edits minimal, documented, and aligned with existing patterns.
- Prefer updating `AGENTS.md` and `CLAUDE.md` when adding agents or guidelines.
- Validate links in `links.md` when updating categories.

## License

This project is licensed under the MIT License. See `LICENSE` for details.
