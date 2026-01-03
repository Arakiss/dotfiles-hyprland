# System & Development Utilities
# ==============================

# Quick edit configs
alias zshrc='${EDITOR:-code} ~/.zshrc'
alias reload='source ~/.zshrc && echo "✓ zshrc reloaded"'

# Ports & processes
alias ports='lsof -i -P -n | grep LISTEN'
alias port='lsof -i :'
alias psg='ps aux | grep -v grep | grep -i'

# Network
alias ip='curl -s ifconfig.me'
alias localip="ipconfig getifaddr en0"

# Disk usage
alias df='df -h'
alias du='du -h'
alias dud='du -d 1 -h'
alias duf='du -sh *'

# Clipboard (macOS)
alias copy='pbcopy'
alias paste='pbpaste'

# Quick directory jumps
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias ~='cd ~'
alias -- -='cd -'

# Mkdir and cd into it
mkcd() { mkdir -p "$1" && cd "$1"; }

# Memory management
alias mem='echo "=== MEMORIA ===" && memory_pressure | grep "free percentage" && echo "" && echo "=== SWAP ===" && sysctl vm.swapusage | awk -F"=" "{print \$2}"'
alias mem-purge='echo "Purgando memoria..." && sudo purge && echo "✅ Memoria purgada"'
alias mem-hogs='ps aux -m | head -11 | awk "{printf \"%-6s %-5s %-8s %s\n\", \$2, \$4\"%\", \$6/1024\"MB\", \$11}"'
