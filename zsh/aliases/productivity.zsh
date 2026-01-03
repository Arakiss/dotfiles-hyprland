# Productivity Tool Aliases
# =========================
# Ghostty Warp v2.0 - Enhanced productivity features

# Workflow Snippets (pet) - Warp Workflows alternative
# Usage: pw to search, pe to execute, pn to create new
alias pw='pet search'
alias pe='pet exec'
alias pn='pet new'
alias pl='pet list'

# Command Corrections (thefuck)
# Usage: Type 'fuck' or 'fix' after a failed command
if command -v thefuck &> /dev/null; then
    eval $(thefuck --alias 2>/dev/null)
    eval $(thefuck --alias fix 2>/dev/null)
fi

# Extended Completions
if type brew &>/dev/null; then
    FPATH="$(brew --prefix)/share/zsh-completions:$FPATH"
    autoload -Uz compinit
    compinit
fi

# tmate - Terminal Sharing
# Usage: tmate to start, tmate show-messages for URL
alias tsh='tmate show-messages'
