# OPENSPEC:START
# OpenSpec shell completions configuration
fpath=("/Users/dolores/.oh-my-zsh/custom/completions" $fpath)
autoload -Uz compinit
compinit
# OPENSPEC:END

# =============================================================================
# ZSH Configuration - Modular Setup
# =============================================================================
# Structure:
#   config/     - ZSH options, history, oh-my-zsh
#   aliases/    - Organized by category
#   functions/  - Custom functions
#   tools/      - External tool initialization
# =============================================================================

DOTFILES_ZSH="${ZDOTDIR:-$HOME}/.dotfiles-zsh"

# Fallback: If not symlinked, use dotfiles directory
[[ ! -d "$DOTFILES_ZSH" ]] && DOTFILES_ZSH="$HOME/dotfiles/zsh"
[[ ! -d "$DOTFILES_ZSH" ]] && DOTFILES_ZSH="$HOME/Projects/personal/dotfiles/zsh"

# Source a file if it exists
_source_if_exists() {
    [[ -f "$1" ]] && source "$1"
}

# Source all .zsh files in a directory
_source_dir() {
    if [[ -d "$1" ]]; then
        for file in "$1"/*.zsh; do
            [[ -f "$file" ]] && source "$file"
        done
    fi
}

# =============================================================================
# Core Configuration
# =============================================================================
_source_if_exists "$DOTFILES_ZSH/config/options.zsh"
_source_if_exists "$DOTFILES_ZSH/config/plugins.zsh"

# =============================================================================
# Aliases (load all)
# =============================================================================
_source_dir "$DOTFILES_ZSH/aliases"

# =============================================================================
# Functions
# =============================================================================
_source_dir "$DOTFILES_ZSH/functions"

# Auto-check Ghostty memory on terminal open
_ghostty_auto_check 2>/dev/null

# =============================================================================
# Tool Initialization (mise, starship, fzf, zoxide, atuin, etc.)
# =============================================================================
_source_if_exists "$DOTFILES_ZSH/tools/init.zsh"

# =============================================================================
# Local overrides (not tracked in git)
# =============================================================================
_source_if_exists "$HOME/.zshrc.local"

# bun completions
[ -s "/Users/dolores/.bun/_bun" ] && source "/Users/dolores/.bun/_bun"
export PATH="$HOME/bin:$HOME/.bun/bin:$PATH"

. "$HOME/.local/bin/env"

# Hermes Agent — ensure ~/.local/bin is on PATH
export PATH="$HOME/.local/bin:$PATH"

# Keep the fnm-selected Node ahead of tool-owned ~/.local/bin shims.
command -v fnm &>/dev/null && eval "$(fnm env --use-on-cd --shell zsh)"

# goal-loop helper (autonomous goal-loop, Stop hook + local MLX judge)
export PATH="$HOME/.claude/bin:$PATH"

