# Omarchy Fish Configuration
# Source this from config.fish

# Aliases - matching OmArchy style
alias n='nvim'
alias v='nvim'
alias g='git'
alias lg='lazygit'
alias ld='lazydocker'
alias d='docker'
alias dc='docker compose'

# Git aliases
alias gcm='git commit -m'
alias gcam='git commit -am'
alias gca='git commit --amend'
alias gs='git status'
alias gd='git diff'
alias gp='git push'
alias gl='git pull'
alias gco='git checkout'
alias gb='git branch'
alias glog='git log --oneline --graph --decorate -15'

# Modern CLI replacements
if command -q eza
    alias ls='eza --icons'
    alias ll='eza -la --icons --group-directories-first'
    alias la='eza -a --icons'
    alias lt='eza --tree --level=2 --icons'
end

if command -q bat
    alias cat='bat --style=plain'
end

if command -q dust
    alias du='dust'
end

# Navigation
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

# Utils
alias open='xdg-open'
alias cls='clear'
alias ff='fzf --preview "bat --color=always --style=numbers {}" --bind "enter:become(nvim {})"'

# Starship prompt
if command -q starship
    starship init fish | source
end

# Zoxide
if command -q zoxide
    zoxide init fish | source
    alias cd='z'
end

# fzf key bindings
if test -f /usr/share/fish/vendor_functions.d/fzf_key_bindings.fish
    fzf_key_bindings
end

# PATH
fish_add_path ~/.local/bin

# Fastfetch on new interactive shell (only first terminal)
if status is-interactive; and not set -q OMARCHY_GREETED
    set -gx OMARCHY_GREETED 1
    if command -q fastfetch
        fastfetch
    end
end
