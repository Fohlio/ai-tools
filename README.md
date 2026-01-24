# 🤖 AI Tools

Agents, commands, and MCP servers for Claude Code and Cursor.

## ⚡ Quick Start

```bash
git clone https://github.com/yourusername/ai-tools.git ~/projects/ai-tools
cd ~/projects/ai-tools && ./sync.sh
```

---

## 🚀 Commands

| Command | Description |
|---------|-------------|
| `/implement-feature` | Plan → Implement → Test → Review |
| `/test-code` | Write tests (Playwright/Jest/Vitest) |
| `/refactor-code` | Simplify and improve readability |
| `/team-review` | Multi-agent review (Architect, UX, Sales, PM) |
| `/prd-creation` | Create PRD for a new feature |

---

## 🔌 MCP Servers

| Server | Purpose |
|--------|---------|
| **Context7** | Up-to-date library documentation |
| **Playwright** | Browser testing |
| **GitHub** | Repository operations |
| **Stitch** | UI design & code generation |

---

## 🤖 Top Agents (`subagents/`)

- `code-architect`: Architecture & development
- `code-tester`: QA & automated tests
- `ux-designer`: UI/UX (Stitch/Figma)
- `project-manager`: Planning & P0-P2 tasks

---

## 🛠 Skills (`skills/`)

- `feature-implementation`: TDD/BDD workflows
- `prompt-engineering`: Research-backed prompts
- `poc-hypothesis`: Quick technical validation

---

## ⚙️ Env Vars

```bash
export GITHUB_PERSONAL_ACCESS_TOKEN="ghp_..."
export OPENAI_API_KEY="sk-..."
```

---

## 📝 Principles

1. **Plan First** — Ask before coding.
2. **Audit** — Reuse existing code.
3. **No Placeholders** — Full implementation only.
4. **Context7** — Always use for docs.

---

## License
MIT
