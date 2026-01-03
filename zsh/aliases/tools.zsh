# Modern CLI Tool Aliases
# =======================

# LSD - Modern ls replacement
alias ls='lsd'
alias l='lsd -l'
alias la='lsd -a'
alias lla='lsd -la'
alias lt='lsd --tree'
alias ltd='lsd --tree --depth 2'
alias ltr='lsd -ltr'
alias lS='lsd -lS'

# BAT - Better cat with syntax highlighting
alias cat='bat --paging=never'
alias catp='bat'
alias catl='bat --plain'
alias diff='bat --diff'

# TLDR - Simplified man pages
alias help='tldr'
alias h='tldr'

# Fastfetch - System info
alias ff='fastfetch'
alias fetch='fastfetch'

# LOVE 2D (if installed)
[[ -f "/Applications/love.app/Contents/MacOS/love" ]] && alias love="/Applications/love.app/Contents/MacOS/love"
