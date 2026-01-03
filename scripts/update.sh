#!/bin/bash
# =============================================================================
# Update Script - Sync Dotfiles
# =============================================================================
# Usage: update.sh [push|pull|status]
# =============================================================================

set -e

DOTFILES_DIR="${DOTFILES_DIR:-$HOME/dotfiles}"
[[ ! -d "$DOTFILES_DIR" ]] && DOTFILES_DIR="$HOME/Projects/personal/dotfiles"

cd "$DOTFILES_DIR"

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

print_header() {
    echo ""
    echo -e "${BLUE}╔═══════════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${BLUE}║                     🔄 DOTFILES UPDATE                            ║${NC}"
    echo -e "${BLUE}╚═══════════════════════════════════════════════════════════════════╝${NC}"
    echo ""
}

show_status() {
    echo -e "${YELLOW}📊 Current Status:${NC}"
    git status --short
    echo ""
    echo -e "${YELLOW}📜 Recent Changes:${NC}"
    git log --oneline -5
}

pull_changes() {
    echo -e "${YELLOW}📥 Pulling latest changes...${NC}"
    git pull --rebase
    echo ""
    echo -e "${GREEN}✓ Dotfiles updated!${NC}"
    echo ""
    echo "Run './install.sh' to apply any new symlinks."
}

push_changes() {
    echo -e "${YELLOW}📤 Checking for changes...${NC}"

    if [[ -z $(git status --porcelain) ]]; then
        echo -e "${GREEN}✓ No changes to push${NC}"
        return
    fi

    echo ""
    echo "Changes detected:"
    git status --short
    echo ""

    read -p "Commit message (or 'q' to quit): " message
    [[ "$message" == "q" ]] && exit 0

    git add -A
    git commit -m "$message"
    git push

    echo ""
    echo -e "${GREEN}✓ Changes pushed!${NC}"
}

sync_all() {
    echo -e "${YELLOW}🔄 Full sync (pull + push)...${NC}"
    echo ""

    # Pull first
    echo "1. Pulling remote changes..."
    git pull --rebase || {
        echo -e "${RED}⚠️  Pull failed. Resolve conflicts first.${NC}"
        exit 1
    }

    # Check for local changes
    if [[ -n $(git status --porcelain) ]]; then
        echo ""
        echo "2. Local changes detected:"
        git status --short
        echo ""

        read -p "Commit message (or 'q' to skip): " message
        if [[ "$message" != "q" && -n "$message" ]]; then
            git add -A
            git commit -m "$message"
            git push
            echo -e "${GREEN}✓ Changes pushed!${NC}"
        fi
    else
        echo "2. No local changes to push."
    fi

    echo ""
    echo -e "${GREEN}✓ Sync complete!${NC}"
}

backup_local() {
    echo -e "${YELLOW}💾 Creating backup...${NC}"
    BACKUP_DIR="$HOME/.dotfiles-backup-$(date +%Y%m%d-%H%M%S)"
    mkdir -p "$BACKUP_DIR"

    # Backup key config files
    cp -r ~/.zshrc "$BACKUP_DIR/" 2>/dev/null || true
    cp -r ~/.gitconfig "$BACKUP_DIR/" 2>/dev/null || true
    cp -r ~/.config/starship.toml "$BACKUP_DIR/" 2>/dev/null || true
    cp -r ~/.config/ghostty "$BACKUP_DIR/" 2>/dev/null || true

    echo -e "${GREEN}✓ Backup created at: $BACKUP_DIR${NC}"
}

# Main
print_header

case "${1:-sync}" in
    pull)
        pull_changes
        ;;
    push)
        push_changes
        ;;
    status)
        show_status
        ;;
    backup)
        backup_local
        ;;
    sync|*)
        sync_all
        ;;
esac
