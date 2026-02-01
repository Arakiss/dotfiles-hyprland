# =============================================================================
# Ghostty-Warp Configuration Aliases
# =============================================================================
# From: https://github.com/Arakiss/ghostty-warp

# Ghostty Configuration
alias gconfig="$HOME/.config/ghostty/gconfig"
alias ghostty-warp="$HOME/.config/ghostty/interactive-config.sh"
alias gconfig-interactive="$HOME/.config/ghostty/interactive-config.sh"
alias gconfig-switch="$HOME/.config/ghostty/switch-config.sh"

# Quick preset aliases
alias gcyber="$HOME/.config/ghostty/gconfig cyber"
alias gminimal="$HOME/.config/ghostty/gconfig minimal"
alias gcozy="$HOME/.config/ghostty/gconfig cozy"
alias gpro="$HOME/.config/ghostty/gconfig pro"

# =============================================================================
# Workflow Snippets (pet)
# =============================================================================
alias pw='pet search'             # Search workflows
alias pe='pet exec'               # Execute workflow
alias pn='pet new'                # New workflow snippet
alias pl='pet list'               # List all snippets

# =============================================================================
# Command Corrections (thefuck)
# =============================================================================
if command -v thefuck &>/dev/null; then
    eval $(thefuck --alias 2>/dev/null)
    eval $(thefuck --alias fix 2>/dev/null)
fi

# =============================================================================
# Extended Completions (zsh-completions)
# =============================================================================
if type brew &>/dev/null; then
    FPATH=$(brew --prefix)/share/zsh-completions:$FPATH
fi
