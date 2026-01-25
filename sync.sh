#!/bin/bash

# AI Tools Sync Script
# Синхронизирует команды, скиллы и агенты из репозитория в ~/.claude и ~/.codex

set -e

# Цвета для вывода
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Путь к репозиторию и целевые директории
REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TARGET_DIRS=("$HOME/.claude" "$HOME/.codex")

# Флаги что синхронизировать
SYNC_COMMANDS=false
SYNC_SKILLS=false
SYNC_AGENTS=false

print_header() {
    echo ""
    echo -e "${CYAN}╭─────────────────────────────────────────────────╮${NC}"
    echo -e "${CYAN}│${NC}  ${BLUE}🔄 AI Tools Sync${NC}                              ${CYAN}│${NC}"
    echo -e "${CYAN}│${NC}  Commands • Skills • Agents                     ${CYAN}│${NC}"
    echo -e "${CYAN}╰─────────────────────────────────────────────────╯${NC}"
    echo ""
}

show_help() {
    print_header
    echo "  Использование:"
    echo ""
    echo -e "    ${CYAN}./sync.sh${NC}              Интерактивный выбор"
    echo -e "    ${CYAN}./sync.sh --all${NC}        Синхронизировать всё"
    echo -e "    ${CYAN}./sync.sh --commands${NC}   Только команды"
    echo -e "    ${CYAN}./sync.sh --skills${NC}     Только скиллы"
    echo -e "    ${CYAN}./sync.sh --agents${NC}     Только агенты"
    echo -e "    ${CYAN}./sync.sh --help${NC}       Показать эту справку"
    echo ""
    echo "  Можно комбинировать:"
    echo -e "    ${CYAN}./sync.sh --commands --agents${NC}"
    echo ""
}

print_step() {
    echo -e "${GREEN}▸${NC} $1"
}

print_success() {
    echo -e "  ${GREEN}✓${NC} $1"
}

print_info() {
    echo -e "  ${YELLOW}→${NC} $1"
}

# Проверка и создание целевых директорий
setup_target_dirs() {
    print_step "Проверяю целевые директории..."
    
    for target_dir in "${TARGET_DIRS[@]}"; do
        if [ ! -d "$target_dir" ]; then
            mkdir -p "$target_dir"
            print_success "Создана директория $target_dir"
        else
            print_info "$target_dir уже существует"
        fi
    done
}

# Создание поддиректорий
setup_subdirs() {
    print_step "Проверяю поддиректории..."
    
    local subdirs=()
    
    # Добавляем только те директории, которые будут синхронизироваться
    if [ "$SYNC_COMMANDS" = true ]; then
        subdirs+=("commands")
    fi
    
    if [ "$SYNC_SKILLS" = true ]; then
        subdirs+=("skills")
    fi
    
    if [ "$SYNC_AGENTS" = true ]; then
        subdirs+=("agents")
    fi
    
    for target_dir in "${TARGET_DIRS[@]}"; do
        for subdir in "${subdirs[@]}"; do
            if [ ! -d "$target_dir/$subdir" ]; then
                mkdir -p "$target_dir/$subdir"
                print_success "Создана $target_dir/$subdir"
            else
                print_info "$target_dir/$subdir уже существует"
            fi
        done
    done
}

# Синхронизация команд
sync_commands() {
    print_step "Синхронизирую команды..."
    
    local count=0
    
    if [ -d "$REPO_DIR/commands" ]; then
        for cmd_file in "$REPO_DIR/commands"/*.md; do
            if [ -f "$cmd_file" ]; then
                local filename=$(basename "$cmd_file")
                
                # Копируем в обе директории
                for target_dir in "${TARGET_DIRS[@]}"; do
                    cp "$cmd_file" "$target_dir/commands/$filename"
                done
                
                print_success "$filename"
                ((count++))
            fi
        done
        
        if [ $count -eq 0 ]; then
            print_info "Команды не найдены"
        else
            print_info "Синхронизировано команд: $count"
        fi
    else
        print_info "Директория commands/ не найдена в репозитории"
    fi
}

# Синхронизация скиллов
sync_skills() {
    print_step "Синхронизирую скиллы..."
    
    local count=0
    
    if [ -d "$REPO_DIR/skills" ]; then
        for skill_dir in "$REPO_DIR/skills"/*; do
            if [ -d "$skill_dir" ]; then
                local skill_name=$(basename "$skill_dir")
                
                # Синхронизируем в обе директории
                for target_dir in "${TARGET_DIRS[@]}"; do
                    local dst="$target_dir/skills/$skill_name"
                    
                    # Удаляем старую версию если есть
                    if [ -d "$dst" ]; then
                        rm -rf "$dst"
                    fi
                    
                    # Копируем скилл
                    cp -r "$skill_dir" "$dst"
                    
                    # Устанавливаем зависимости если есть package.json (только один раз)
                    if [ "$target_dir" == "$HOME/.claude" ] && [ -f "$dst/package.json" ]; then
                        print_info "Устанавливаю зависимости для $skill_name..."
                        (cd "$dst" && npm install --silent 2>/dev/null) || true
                    fi
                done
                
                print_success "$skill_name"
                ((count++))
            fi
        done
        
        if [ $count -eq 0 ]; then
            print_info "Скиллы не найдены"
        else
            print_info "Синхронизировано скиллов: $count"
        fi
    else
        print_info "Директория skills/ не найдена в репозитории"
    fi
}

# Синхронизация агентов
sync_agents() {
    print_step "Синхронизирую агенты..."
    
    local count=0
    
    if [ -d "$REPO_DIR/agents" ]; then
        for agent_file in "$REPO_DIR/agents"/*.md; do
            if [ -f "$agent_file" ]; then
                local filename=$(basename "$agent_file")
                
                # Копируем в обе директории
                for target_dir in "${TARGET_DIRS[@]}"; do
                    cp "$agent_file" "$target_dir/agents/$filename"
                done
                
                print_success "$filename"
                ((count++))
            fi
        done
        
        if [ $count -eq 0 ]; then
            print_info "Агенты не найдены"
        else
            print_info "Синхронизировано агентов: $count"
        fi
    else
        print_info "Директория agents/ не найдена в репозитории"
    fi
}

# Интерактивный выбор что синхронизировать
interactive_select() {
    echo -e "  ${BLUE}Выберите что синхронизировать:${NC}"
    echo ""
    echo -e "    ${CYAN}1${NC}) Команды (commands/)"
    echo -e "    ${CYAN}2${NC}) Скиллы (skills/)"
    echo -e "    ${CYAN}3${NC}) Агенты (agents/)"
    echo -e "    ${CYAN}a${NC}) Всё"
    echo ""
    read -p "  Выбор (номера через пробел или 'a'): " selection
    
    if [ "$selection" = "a" ] || [ "$selection" = "A" ]; then
        SYNC_COMMANDS=true
        SYNC_SKILLS=true
        SYNC_AGENTS=true
    else
        for num in $selection; do
            case $num in
                1) SYNC_COMMANDS=true ;;
                2) SYNC_SKILLS=true ;;
                3) SYNC_AGENTS=true ;;
            esac
        done
    fi
    
    echo ""
}

# Финальное сообщение
show_done() {
    echo ""
    echo -e "${GREEN}╭─────────────────────────────────────────────────╮${NC}"
    echo -e "${GREEN}│${NC}  ${GREEN}✓ Синхронизация завершена!${NC}                    ${GREEN}│${NC}"
    echo -e "${GREEN}╰─────────────────────────────────────────────────╯${NC}"
    echo ""
    echo -e "  Синхронизировано в ~/.claude и ~/.codex:"
    
    if [ "$SYNC_COMMANDS" = true ]; then
        echo -e "    ${CYAN}→${NC} commands/"
    fi
    
    if [ "$SYNC_SKILLS" = true ]; then
        echo -e "    ${CYAN}→${NC} skills/"
    fi
    
    if [ "$SYNC_AGENTS" = true ]; then
        echo -e "    ${CYAN}→${NC} agents/"
    fi
    
    echo ""
}

# Выполнение синхронизации
run_sync() {
    print_header
    
    # Если ничего не выбрано - интерактивный режим
    if [ "$SYNC_COMMANDS" = false ] && [ "$SYNC_SKILLS" = false ] && [ "$SYNC_AGENTS" = false ]; then
        interactive_select
    fi
    
    setup_target_dirs
    echo ""
    setup_subdirs
    echo ""
    
    if [ "$SYNC_COMMANDS" = true ]; then
        sync_commands
        echo ""
    fi
    
    if [ "$SYNC_SKILLS" = true ]; then
        sync_skills
        echo ""
    fi
    
    if [ "$SYNC_AGENTS" = true ]; then
        sync_agents
        echo ""
    fi
    
    show_done
}

# Парсинг аргументов
case "${1:-}" in
    --help|-h)
        show_help
        exit 0
        ;;
    --all)
        SYNC_COMMANDS=true
        SYNC_SKILLS=true
        SYNC_AGENTS=true
        ;;
    *)
        # Парсим все флаги
        while [ $# -gt 0 ]; do
            case "$1" in
                --commands) SYNC_COMMANDS=true ;;
                --skills) SYNC_SKILLS=true ;;
                --agents) SYNC_AGENTS=true ;;
                --all)
                    SYNC_COMMANDS=true
                    SYNC_SKILLS=true
                    SYNC_AGENTS=true
                    ;;
            esac
            shift
        done
        ;;
esac

# Main
run_sync
