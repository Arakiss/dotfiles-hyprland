# External Tool Initialization
# ============================
# Uses lazy loading where possible to speed up shell startup

# =============================================================================
# LAZY LOADING HELPER
# =============================================================================
# Creates a function that loads the real tool on first use
_lazy_load() {
    local cmd=$1
    local init_cmd=$2

    eval "
    $cmd() {
        unfunction $cmd 2>/dev/null
        $init_cmd
        $cmd \"\$@\"
    }
    "
}

# =============================================================================
# INSTANT LOADING (fast tools, needed immediately)
# =============================================================================

# Bun (fast, needed for aliases)
[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# UV tools & local bin
export PATH="$HOME/.local/bin:$PATH"

# OpenCode
export PATH="$HOME/.opencode/bin:$PATH"

# Starship prompt (fast, visible immediately)
eval "$(starship init zsh)"

# =============================================================================
# LAZY LOADING (heavy tools, load on first use)
# =============================================================================

# --- mise (runtime version manager) ---
# Only initialize when mise/python/ruby/etc is called
if command -v mise &>/dev/null; then
    _lazy_mise_init() {
        unfunction _lazy_mise_init 2>/dev/null
        unfunction mise python python3 ruby 2>/dev/null
        eval "$(mise activate zsh)"
    }
    _lazy_load "mise" "_lazy_mise_init"
    _lazy_load "python" "_lazy_mise_init"
    _lazy_load "python3" "_lazy_mise_init"
    _lazy_load "ruby" "_lazy_mise_init"
fi

# --- fnm (fast Node manager) ---
# Loaded immediately because node is needed by many tools (Claude, etc.)
command -v fnm &>/dev/null && eval "$(fnm env --use-on-cd)"

# =============================================================================
# DEFERRED LOADING (load after prompt, in background)
# =============================================================================

# zsh-autosuggestions
_load_autosuggestions() {
    if [[ -f /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh ]]; then
        source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
        export ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20
        export ZSH_AUTOSUGGEST_USE_ASYNC=1
        export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#6c7086"
        export ZSH_AUTOSUGGEST_STRATEGY=(history completion)
    fi
}

# zsh-syntax-highlighting (must be after autosuggestions)
_load_syntax_highlighting() {
    [[ -f /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]] && \
        source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
}

# fzf
_load_fzf() {
    source <(fzf --zsh) 2>/dev/null
    export FZF_DEFAULT_OPTS="
      --height 40%
      --layout=reverse
      --border
      --preview-window=right:50%
      --bind='ctrl-/:toggle-preview'
    "
    if command -v fd &>/dev/null; then
        export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
        export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
    fi
}

# zoxide (smart cd)
_load_zoxide() {
    command -v zoxide &>/dev/null && eval "$(zoxide init zsh)"
}

# Atuin (shell history)
_load_atuin() {
    command -v atuin &>/dev/null && eval "$(atuin init zsh)"
}

# Load these after first prompt for faster startup
_deferred_load() {
    _load_autosuggestions
    _load_syntax_highlighting
    _load_fzf
    _load_zoxide
    _load_atuin
}

# Use zsh-defer if available, otherwise load immediately
if (( $+functions[zsh-defer] )); then
    zsh-defer _deferred_load
else
    # Schedule for after first prompt
    zmodload zsh/sched 2>/dev/null && sched +0 _deferred_load || _deferred_load
fi

# =============================================================================
# TAB TITLE
# =============================================================================
_set_tab_title() {
    print -Pn "\e]0;%1~\a"
}
precmd_functions+=(_set_tab_title)
