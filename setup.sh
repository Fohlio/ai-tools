#!/bin/bash

# AI Tools Setup Script
# Автоматическая установка MCP серверов, команд и агентов для Claude Code

set -e

# Цвета для вывода
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Путь к репозиторию
REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CLAUDE_DIR="$HOME/.claude"

print_header() {
    echo ""
    echo -e "${CYAN}╭─────────────────────────────────────────────────╮${NC}"
    echo -e "${CYAN}│${NC}  ${BLUE}🤖 AI Tools Setup${NC}                              ${CYAN}│${NC}"
    echo -e "${CYAN}│${NC}  MCP • Commands • Agents                        ${CYAN}│${NC}"
    echo -e "${CYAN}╰─────────────────────────────────────────────────╯${NC}"
    echo ""
}

print_step() {
    echo -e "${GREEN}▸${NC} $1"
}

print_info() {
    echo -e "  ${YELLOW}→${NC} $1"
}

print_success() {
    echo -e "  ${GREEN}✓${NC} $1"
}

print_error() {
    echo -e "  ${RED}✗${NC} $1"
}

# Проверка установки Claude Code
check_claude() {
    print_step "Проверяю Claude Code..."
    if command -v claude &> /dev/null; then
        local version=$(claude --version 2>/dev/null || echo "unknown")
        print_success "Claude Code установлен: $version"
        return 0
    else
        print_error "Claude Code не найден"
        echo ""
        echo -e "  Установите Claude Code:"
        echo -e "    ${CYAN}npm install -g @anthropic-ai/claude-code${NC}"
        echo -e "    или"
        echo -e "    ${CYAN}brew install claude-code${NC}"
        echo ""
        return 1
    fi
}

# Создание директорий
create_directories() {
    print_step "Создаю директории..."
    mkdir -p "$CLAUDE_DIR/commands"
    mkdir -p "$CLAUDE_DIR/skills"
    print_success "~/.claude/commands"
    print_success "~/.claude/skills"
}

# Установка MCP серверов
setup_mcp() {
    print_step "Настраиваю MCP серверы..."
    
    local settings_file="$CLAUDE_DIR/settings.json"
    
    if [ -f "$settings_file" ]; then
        print_info "Найден существующий settings.json"
        echo ""
        echo -e "  Что сделать?"
        echo -e "  ${CYAN}1${NC}) Заменить полностью (бэкап будет сохранён)"
        echo -e "  ${CYAN}2${NC}) Пропустить (оставить как есть)"
        echo -e "  ${CYAN}3${NC}) Показать примеры MCP для ручного добавления"
        echo ""
        read -p "  Выбор [1/2/3]: " mcp_choice
        
        case $mcp_choice in
            1)
                cp "$settings_file" "$settings_file.backup.$(date +%Y%m%d_%H%M%S)"
                print_info "Бэкап сохранён"
                cp "$REPO_DIR/mcp/cursor.json" "$settings_file"
                print_success "MCP конфиг установлен"
                ;;
            3)
                show_mcp_examples
                ;;
            *)
                print_info "Пропущено"
                ;;
        esac
    else
        cp "$REPO_DIR/mcp/cursor.json" "$settings_file"
        print_success "MCP конфиг установлен"
    fi
}

show_mcp_examples() {
    echo ""
    echo -e "  ${BLUE}Добавьте в ~/.claude/settings.json:${NC}"
    echo ""
    cat << 'EOF'
  {
    "mcpServers": {
      "context7": {
        "url": "https://mcp.context7.com/mcp"
      },
      "Playwright": {
        "command": "npx -y @modelcontextprotocol/server-playwright"
      },
      "GitHub": {
        "command": "docker run -i --rm -e GITHUB_PERSONAL_ACCESS_TOKEN ghcr.io/github/github-mcp-server",
        "env": { "GITHUB_PERSONAL_ACCESS_TOKEN": "${GITHUB_PERSONAL_ACCESS_TOKEN}" }
      }
    }
  }
EOF
    echo ""
}

# Установка команд
setup_commands() {
    print_step "Устанавливаю команды..."
    
    local commands=(
        "implement-feature:Полный цикл разработки"
        "implement-tdd-feature:TDD: сначала тесты"
        "implement-bdd-feature:BDD: Gherkin + тесты"
        "business-review:Бизнес и маркетинг ревью"
        "team-review:Командное ревью (Code Architect, UX, Sales, PM, Refactorer)"
        "playbook-generate:Генерация промптов и воркфлоу в Agents Playbook"
        "design-system:Создание и масштабирование дизайн-системы"
        "prd-creation:Создание PRD для новой фичи"
    )
    
    for cmd_info in "${commands[@]}"; do
        local cmd_name="${cmd_info%%:*}"
        local cmd_desc="${cmd_info##*:}"
        local src="$REPO_DIR/commands/${cmd_name}.md"
        local dst="$CLAUDE_DIR/commands/${cmd_name}.md"
        
        if [ -f "$src" ]; then
            cp "$src" "$dst"
            print_success "/$cmd_name — $cmd_desc"
        fi
    done
}

# Установка скиллов
setup_skills() {
    print_step "Какие скиллы установить?"
    echo ""
    
    local skills=(
        "create-game-assets:Генерация игровых ассетов (DALL-E 3)"
        "feature-implementation:Полный цикл разработки (Standard, TDD, BDD)"
        "poc-hypothesis:Быстрый POC для проверки гипотез"
        "integrate-playbook-mcp:Интеграция Playbook MCP"
        "agent-browser:Автоматизация браузера"
    )
    
    local i=1
    for skill_info in "${skills[@]}"; do
        local skill_name="${skill_info%%:*}"
        local skill_desc="${skill_info##*:}"
        echo -e "  ${CYAN}$i${NC}) $skill_name — $skill_desc"
        ((i++))
    done
    echo -e "  ${CYAN}a${NC}) Установить все"
    echo -e "  ${CYAN}n${NC}) Пропустить"
    echo ""
    read -p "  Выбор (номера через пробел или a/n): " skill_choice
    
    if [ "$skill_choice" = "n" ]; then
        print_info "Пропущено"
        return
    fi
    
    if [ "$skill_choice" = "a" ]; then
        skill_choice="1 2 3 4"
    fi
    
    for num in $skill_choice; do
        local idx=$((num - 1))
        if [ $idx -ge 0 ] && [ $idx -lt ${#skills[@]} ]; then
            local skill_info="${skills[$idx]}"
            local skill_name="${skill_info%%:*}"
            install_skill "$skill_name"
        fi
    done
}

install_skill() {
    local skill_name="$1"
    local src="$REPO_DIR/skills/$skill_name"
    local dst="$CLAUDE_DIR/skills/$skill_name"
    
    if [ -d "$src" ]; then
        # Копируем скилл
        rm -rf "$dst"
        cp -r "$src" "$dst"
        
        # Устанавливаем зависимости если есть package.json
        if [ -f "$dst/package.json" ]; then
            print_info "Устанавливаю зависимости для $skill_name..."
            (cd "$dst" && npm install --silent 2>/dev/null) || true
        fi
        
        print_success "$skill_name установлен"
    else
        print_error "$skill_name не найден"
    fi
}

# Показать информацию о переменных окружения
show_env_info() {
    print_step "Переменные окружения"
    echo ""
    echo -e "  Добавьте в ~/.zshrc или ~/.bashrc:"
    echo ""
    echo -e "  ${CYAN}# GitHub MCP${NC}"
    echo -e "  export GITHUB_PERSONAL_ACCESS_TOKEN=\"your-token\""
    echo ""
    echo -e "  ${CYAN}# OpenAI (для скиллов)${NC}"
    echo -e "  export OPENAI_API_KEY=\"sk-...\""
    echo ""
}

# Финальное сообщение
show_done() {
    echo ""
    echo -e "${GREEN}╭─────────────────────────────────────────────────╮${NC}"
    echo -e "${GREEN}│${NC}  ${GREEN}✓ Готово!${NC}                                     ${GREEN}│${NC}"
    echo -e "${GREEN}╰─────────────────────────────────────────────────╯${NC}"
    echo ""
    echo -e "  Теперь в Claude Code доступны команды:"
    echo -e "    ${CYAN}/implement-feature${NC} — полный цикл разработки"
    echo -e "    ${CYAN}/implement-tdd-feature${NC} — TDD workflow"
    echo -e "    ${CYAN}/implement-bdd-feature${NC} — BDD workflow"
    echo -e "    ${CYAN}/business-review${NC} — бизнес и маркетинг ревью"
    echo -e "    ${CYAN}/team-review${NC} — командное ревью (Code Architect, UX, Sales, PM, Refactorer)"
    echo -e "    ${CYAN}/playbook-generate${NC} — генерация промптов и воркфлоу в Agents Playbook"
    echo -e "    ${CYAN}/design-system${NC} — создание и масштабирование дизайн-системы"
    echo -e "    ${CYAN}/prd-creation${NC} — создание PRD для новой фичи"
    echo ""
    echo -e "  Запуск Claude Code:"
    echo -e "    ${CYAN}cd your-project && claude${NC}"
    echo ""
}

# Быстрая установка (без вопросов)
quick_install() {
    print_header
    echo -e "  ${YELLOW}Быстрая установка (всё по умолчанию)${NC}"
    echo ""
    
    check_claude || exit 1
    create_directories
    
    # MCP
    local settings_file="$CLAUDE_DIR/settings.json"
    if [ ! -f "$settings_file" ]; then
        cp "$REPO_DIR/mcp/cursor.json" "$settings_file"
        print_success "MCP конфиг установлен"
    else
        print_info "MCP конфиг уже существует (пропущено)"
    fi
    
    # Commands
    for cmd in "$REPO_DIR/commands"/*.md; do
        [ -f "$cmd" ] && cp "$cmd" "$CLAUDE_DIR/commands/"
    done
    print_success "Команды установлены"
    
    show_done
}

# Интерактивная установка
interactive_install() {
    print_header
    
    check_claude || exit 1
    
    echo ""
    create_directories
    echo ""
    setup_mcp
    echo ""
    setup_commands
    echo ""
    setup_skills
    echo ""
    show_env_info
    show_done
}

# Помощь
show_help() {
    print_header
    echo "  Использование:"
    echo ""
    echo -e "    ${CYAN}./setup.sh${NC}         Интерактивная установка"
    echo -e "    ${CYAN}./setup.sh --quick${NC} Быстрая установка (всё по умолчанию)"
    echo -e "    ${CYAN}./setup.sh --help${NC}  Показать эту справку"
    echo ""
    echo "  Что устанавливается:"
    echo ""
    echo "    • MCP серверы (Context7, Playwright, GitHub...)"
    echo "    • Команды (/implement-feature, /implement-tdd-feature...)"
    echo "    • Скиллы (генерация ассетов, TDD workflow...)"
    echo ""
}

# Main
case "${1:-}" in
    --quick|-q)
        quick_install
        ;;
    --help|-h)
        show_help
        ;;
    *)
        interactive_install
        ;;
esac
