# 🤖 AI Tools

A collection of agents, commands, and MCP servers for Claude Code and Cursor.

## ⚡ Quick Start

```bash
# Clone the repository
git clone https://github.com/yourusername/ai-tools.git ~/projects/ai-tools

# Run the setup
cd ~/projects/ai-tools
./setup.sh
```

The script will install:
- ✅ MCP servers (Context7, Playwright, GitHub...)
- ✅ Commands for Claude Code
- ✅ Skills (optional)

For quick installation without prompts: `./setup.sh --quick`

---

## 📦 What's Inside

```
ai-tools/
├── commands/      → Slash commands for Claude Code
├── subagents/     → Specialized agents
├── skills/        → Executable skills (scripts)
├── mcp/           → MCP server configs
└── links.md       → Useful links
```

---

## 🚀 Commands

After installation, the following commands are available in Claude Code:

| Command | Description |
|---------|-------------|
| `/implement-feature` | Full cycle: Plan → Implement → Test → Review |
| `/implement-tdd-feature` | TDD: Plan → **Test** → Implement → Refactor |
| `/implement-bdd-feature` | BDD: Plan → **Gherkin** → Implement |
| `/test-code` | Analyze code, write tests (Playwright/Jest/Vitest), validate business logic |
| `/refactor-code` | Review and simplify code for readability and scalability |
| `/business-review` | Business & marketing review: PRD → Analysis → Verdict |
| `/design-review` | Comprehensive design review: Audit → Critique → Optimize |
| `/team-review` | Team review: Code Architect + UX + Sales + PM + Refactorer |
| `/design-system` | Create and scale a design system |
| `/prd-creation` | Create PRD for a new feature with PM involvement |

**Usage:**
```
/implement-feature feature description or path to spec
```

---

## 🔌 MCP Servers

Installed servers:

| Server | Purpose |
|--------|---------|
| **Context7** | Up-to-date library documentation |
| **Playwright** | Browser testing |
| **GitHub** | Repository operations |
| **Sentry** | Error monitoring |
| **Vercel** | Deployment |
| **Figma** | Design and mockups |
| **agents-playbook** | AI workflows and prompts |
| **deepwiki** | Wikipedia documentation |
| **stitch** | Google UI design tool with AI code generation |

### Manual MCP Setup

To add a server manually:

```bash
# Via CLI
claude mcp add context7 --url https://mcp.context7.com/mcp

# Or edit ~/.claude/settings.json
```

`settings.json` format:
```json
{
  "mcpServers": {
    "context7": {
      "url": "https://mcp.context7.com/mcp"
    },
    "Playwright": {
      "command": "npx -y @modelcontextprotocol/server-playwright"
    }
  }
}
```

---

## 🤖 Agents

Specialized agents in `subagents/`:

### General (general/)

| Agent | Description |
|-------|-------------|
| `meta-agent` | Master orchestrator of all tools |
| `code-architect` | Full-stack architecture and development |
| `code-tester` | Automated testing (Playwright, Jest, Vitest) |
| `code-refactorer` | Code refactoring and simplification |
| `ux-optimiser` | UX/UI audit and optimization |
| `sales-marketer` | Marketing and conversion |
| `agent-browser` | Browser automation |
| `ai-prompter` | Prompt engineering and AI architecture |
| `build-verificator` | Final QA verification and testing |
| `mobile-architect` | Flutter and cross-platform mobile development |
| `project-manager` | Task decomposition and planning (P0-P2, T-shirt sizing) |

### Specialized (specific/)

| Agent | Description |
|-------|-------------|
| `game-design-architect` | Game design and game specifications |
| `fsd-architecture-specialist` | Feature-Sliced Design architecture |
| `dialogue-story-specialist` | Narrative, dialogue, and storytelling |
| `app-replication-architect` | App analysis and replication strategy |
| `product-marketing-strategist` | Feedback analysis and product positioning |
| `psychology-consultant` | Mental health feature consulting |

Usage in Claude Code:
```
Use agent meta-agent from ~/projects/ai-tools/subagents/general/meta-agent.md
```

---

## 🛠 Skills

Executable scripts in `skills/`:

| Skill | Description |
|-------|-------------|
| `feature-implementation` | Full development cycle (Standard, TDD, BDD) |
| `create-game-assets` | Asset generation via DALL-E 3 |
| `poc-hypothesis` | Quick POC for hypothesis validation |
| `agent-browser` | Browser automation |
| `integrate-playbook-mcp` | Integrate Agents Playbook MCP into AI frameworks |
| `humanizer` | Remove AI-generated text markers, improve style |
| `startup-hub` | Startup research and project management in Startup Hub |

Installing a single skill:
```bash
cp -r skills/create-game-assets ~/.claude/skills/
cd ~/.claude/skills/create-game-assets && npm install
```

---

## ⚙️ Environment Variables

Add to `~/.zshrc`:

```bash
# GitHub MCP (required for GitHub server)
export GITHUB_PERSONAL_ACCESS_TOKEN="ghp_..."

# OpenAI (for skills with generation)
export OPENAI_API_KEY="sk-..."
```

---

## 📁 Config Structure

| Path | Purpose |
|------|---------|
| `~/.claude/settings.json` | MCP servers (global) |
| `~/.claude/commands/` | Slash commands (global) |
| `~/.claude/skills/` | Skills (global) |
| `.claude/settings.json` | MCP servers (project) |
| `.claude/commands/` | Commands (project) |

---

## 🔧 Manual Installation

If you prefer not to use the script:

### MCP
```bash
cp mcp/cursor.json ~/.claude/settings.json
```

### Commands
```bash
mkdir -p ~/.claude/commands
cp commands/*.md ~/.claude/commands/
```

### Skills
```bash
mkdir -p ~/.claude/skills
cp -r skills/create-game-assets ~/.claude/skills/
cd ~/.claude/skills/create-game-assets && npm install
```

---

## 📝 Key Principles

1. **Planning** — agents ask questions before implementation
2. **Audit** — search for existing solutions before creating new ones
3. **No placeholders** — full implementation or explicit request to defer
4. **Minimal changes** — precise fixes without over-engineering
5. **Context7** — up-to-date documentation via MCP

---

## 📚 Useful Links

See `links.md` for links to provider documentation, SDKs, and tools.

---

## License

MIT — see `LICENSE`
