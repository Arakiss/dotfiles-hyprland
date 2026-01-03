# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# ===================================================================
# ⚡ ZSH PERFORMANCE & HISTORY OPTIMIZATIONS
# ===================================================================
# History settings (complementing Atuin)
HISTSIZE=50000                    # Lines in memory
SAVEHIST=50000                    # Lines saved to file
HISTFILE=~/.zsh_history
setopt EXTENDED_HISTORY           # Save timestamp and duration
setopt HIST_EXPIRE_DUPS_FIRST     # Expire duplicates first
setopt HIST_IGNORE_DUPS           # Don't save duplicates
setopt HIST_IGNORE_ALL_DUPS       # Remove older duplicate
setopt HIST_IGNORE_SPACE          # Commands starting with space not saved
setopt HIST_FIND_NO_DUPS          # No duplicates in search
setopt HIST_SAVE_NO_DUPS          # Don't write duplicates
setopt SHARE_HISTORY              # Share between sessions
setopt INC_APPEND_HISTORY         # Add immediately, not at exit

# Better cd behavior
setopt AUTO_CD                    # cd without typing cd
setopt AUTO_PUSHD                 # Push to dir stack automatically
setopt PUSHD_IGNORE_DUPS          # No duplicates in stack
setopt PUSHD_SILENT               # Don't print stack after pushd

# Globbing & completion
setopt EXTENDED_GLOB              # Extended glob patterns
setopt NO_CASE_GLOB               # Case insensitive globbing
setopt GLOB_DOTS                  # Include dotfiles in glob

# Correction
setopt CORRECT                    # Command correction
setopt CORRECT_ALL                # Argument correction

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Theme disabled - using Starship instead (see bottom of file)
# ZSH_THEME="robbyrussell"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
# Plugins: Only built-in (external ones loaded separately below)
plugins=(
  git                 # Git aliases (ga, gco, gp, etc.)
  docker              # Docker completions & aliases
  docker-compose      # docker-compose aliases
  macos               # macOS shortcuts (tab, ofd, pfd, etc.)
  sudo                # Press ESC twice to add sudo
  copypath            # Copy current path to clipboard
  copyfile            # Copy file content to clipboard
  extract             # 'extract' any archive format
  web-search          # 'google', 'ddg', 'github' from terminal
)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='nvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch $(uname -m)"

# Set personal aliases, overriding those provided by Oh My Zsh libs,
# plugins, and themes. Aliases can be placed here, though Oh My Zsh
# users are encouraged to define aliases within a top-level file in
# the $ZSH_CUSTOM folder, with .zsh extension. Examples:
# - $ZSH_CUSTOM/aliases.zsh
# - $ZSH_CUSTOM/macos.zsh
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# LOVE 2D alias for quick testing
alias love="/Applications/love.app/Contents/MacOS/love"

eval "$(mise activate zsh)"

# fnm
eval "$(fnm env --use-on-cd)"

# bun completions
[ -s "/Users/petrucosmindumitru/.bun/_bun" ] && source "/Users/petrucosmindumitru/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# uv tools - Add ~/.local/bin to PATH for uv installed tools
export PATH="$HOME/.local/bin:$PATH"

eval "$(starship init zsh)"

# The following lines have been added by Docker Desktop to enable Docker CLI completions.
fpath=(/Users/petrucosmindumitru/.docker/completions $fpath)
autoload -Uz compinit
compinit
# End of Docker CLI completions

# Ghostty Configuration Aliases
alias gconfig='/Users/petrucosmindumitru/.config/ghostty/gconfig'
alias ghostty-config='/Users/petrucosmindumitru/.config/ghostty/interactive-config.sh'
alias gconfig-interactive='/Users/petrucosmindumitru/.config/ghostty/interactive-config.sh'
alias gconfig-switch='/Users/petrucosmindumitru/.config/ghostty/switch-config.sh'

# Quick preset aliases
alias gcyber='/Users/petrucosmindumitru/.config/ghostty/gconfig cyber'
alias gminimal='/Users/petrucosmindumitru/.config/ghostty/gconfig minimal'
alias gcozy='/Users/petrucosmindumitru/.config/ghostty/gconfig cozy'
alias gpro='/Users/petrucosmindumitru/.config/ghostty/gconfig pro'

# ===================================================================
# 🐳 DOCKER POWER ALIASES - BATTERY SAVING
# ===================================================================

# Stop all running containers (saves battery)
alias docker-stop-all='docker stop $(docker ps -q) 2>/dev/null || echo "No containers running"'

# Stop all containers and remove them
alias docker-nuke='docker stop $(docker ps -aq) 2>/dev/null && docker rm $(docker ps -aq) 2>/dev/null || echo "All cleaned up"'

# Stop only Supabase analytics containers (the battery killers)
alias docker-stop-analytics='docker ps --filter "name=supabase_analytics" --format "{{.ID}}" | xargs docker stop 2>/dev/null || echo "No analytics containers running"'

# Show Docker resource usage (find battery hogs)
alias docker-stats='docker stats --no-stream --format "table {{.Name}}\t{{.CPUPerc}}\t{{.MemUsage}}"'

# Show only running Supabase containers
alias docker-supabase='docker ps --filter "name=supabase_" --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}"'

# Quick restart all containers
alias docker-restart-all='docker restart $(docker ps -q) 2>/dev/null || echo "No containers to restart"'

# ===================================================================
# 📂 LSD - Modern ls replacement
# ===================================================================
alias ls='lsd'
alias l='lsd -l'
alias la='lsd -a'
alias lla='lsd -la'
alias lt='lsd --tree'
alias ltd='lsd --tree --depth 2'
alias ltr='lsd -ltr'              # Sort by time, reversed (newest last)
alias lS='lsd -lS'                # Sort by size

# ===================================================================
# 🐱 BAT - Better cat with syntax highlighting
# ===================================================================
alias cat='bat --paging=never'    # Replace cat (no pager)
alias catp='bat'                  # With pager
alias catl='bat --plain'          # No line numbers, no decorations
alias diff='bat --diff'           # Better diff viewing

# ===================================================================
# 📖 TLDR - Simplified man pages
# ===================================================================
alias help='tldr'                 # Quick help for commands
alias h='tldr'

# ===================================================================
# 🖥️ FASTFETCH - System info
# ===================================================================
alias ff='fastfetch'
alias fetch='fastfetch'

# ===================================================================
# 🔧 SYSTEM & DEVELOPMENT UTILITIES
# ===================================================================
# Quick edit configs
alias zshrc='${EDITOR:-code} ~/.zshrc'
alias reload='source ~/.zshrc && echo "✓ zshrc reloaded"'

# Ports & processes
alias ports='lsof -i -P -n | grep LISTEN'
alias port='lsof -i :'            # Usage: port 3000
alias killport='kill -9 $(lsof -t -i:$1)'  # Usage: killport 3000

# Network
alias ip='curl -s ifconfig.me'    # Public IP
alias localip="ipconfig getifaddr en0"

# Disk usage
alias df='df -h'
alias du='du -h'
alias dud='du -d 1 -h'            # Directory sizes (1 level deep)
alias duf='du -sh *'              # Size of files/dirs in current dir

# Process management
alias psg='ps aux | grep -v grep | grep -i'  # Usage: psg node

# Clipboard (macOS)
alias copy='pbcopy'
alias paste='pbpaste'

# Quick directory jumps (complement zoxide)
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias ~='cd ~'
alias -- -='cd -'                 # Go back to previous dir

# Mkdir and cd into it
mkcd() { mkdir -p "$1" && cd "$1"; }

# ===================================================================
# 🚀 BUN SHORTCUTS (your main runtime)
# ===================================================================
alias b='bun'
alias br='bun run'
alias bd='bun run dev'
alias bb='bun run build'
alias bt='bun run test'
alias bi='bun install'
alias ba='bun add'
alias bad='bun add -d'
alias brm='bun remove'
alias bx='bunx'

# ===================================================================
# 🐙 GITHUB CLI SHORTCUTS
# ===================================================================
alias ghpr='gh pr create'
alias ghprl='gh pr list'
alias ghprv='gh pr view --web'
alias ghprc='gh pr checkout'
alias ghis='gh issue list'
alias ghiv='gh issue view'
alias ghrepo='gh repo view --web'
alias ghrun='gh run list'

# ===================================================================
# 🎯 GIT EXTRAS (complementing oh-my-zsh git plugin)
# ===================================================================
# The plugin gives you: ga, gaa, gc, gco, gp, gl, gst, etc.
# These are extras not in the plugin:
alias gundo='git reset --soft HEAD~1'           # Undo last commit (keep changes)
alias gunstage='git restore --staged'           # Unstage file(s)
alias gwip='git add -A && git commit -m "WIP"'  # Quick WIP commit
alias gclean='git branch --merged | grep -v "\*\|main\|master" | xargs -n 1 git branch -d'  # Clean merged branches
alias glog='git log --oneline --graph --decorate -20'  # Pretty log
alias gloga='git log --oneline --graph --decorate --all'  # All branches

# ===================================================================
# 🗄️ SUPABASE SHORTCUTS
# ===================================================================
alias sb='bunx supabase'
alias sbs='bunx supabase status'
alias sbstart='bunx supabase start'
alias sbstop='bunx supabase stop'
alias sbstudio='bunx supabase studio'
alias sbreset='bunx supabase db reset'
alias sbmig='bunx supabase migration'

# ===================================================================
# 🚀 INTELLIGENT AUTOCOMPLETE & SHELL ENHANCEMENTS (2025)
# ===================================================================

# --- zsh-autosuggestions Configuration ---
# Fish-like autosuggestions based on history
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# Optimization: Limit buffer size for better performance
export ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20

# Enable async mode for faster suggestions
export ZSH_AUTOSUGGEST_USE_ASYNC=1

# Customize suggestion color (subtle gray)
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#6c7086"

# Suggest from history and completion
export ZSH_AUTOSUGGEST_STRATEGY=(history completion)

# --- zsh-syntax-highlighting Configuration ---
# Must be loaded AFTER zsh-autosuggestions
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# --- fzf Configuration ---
# Fuzzy finder for files, history, and more
# Initialize fzf with zsh integration
source <(fzf --zsh)

# fzf key bindings:
# - CTRL-T: Paste selected files/dirs into command line
# - CTRL-R: Search command history (IMPROVED with fzf!)
# - ALT-C:  cd into selected directory

# Custom fzf options for better UX
export FZF_DEFAULT_OPTS="
  --height 40%
  --layout=reverse
  --border
  --preview-window=right:50%
  --bind='ctrl-/:toggle-preview'
"

# Use fd (if available) for better file finding
if command -v fd &> /dev/null; then
  export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
  export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
fi

# --- zoxide Configuration ---
# Smart directory navigation (replaces cd with learning capabilities)
eval "$(zoxide init zsh)"

# Usage:
# - z <keyword>    : Jump to a directory matching keyword
# - zi             : Interactive directory search (requires fzf)
# - z -            : Go back to previous directory

# --- Atuin Configuration ---
# Intelligent shell history with search and sync
eval "$(atuin init zsh)"

# Atuin key bindings:
# - CTRL-R: Search through ALL your command history with fuzzy search
# - UP:     Navigate through history with context awareness

# Atuin config location: ~/.config/atuin/config.toml
# You can customize search modes, sync settings, and more

# ===================================================================
# 🎯 QUICK REFERENCE
# ===================================================================
# Auto-suggestions: Type and see gray suggestions → Right arrow to accept
# Syntax highlighting: Valid commands = green, invalid = red
# fzf history: CTRL-R for fuzzy command history search
# fzf files: CTRL-T to find and insert files
# fzf dirs: ALT-C to cd into directory
# zoxide: Use 'z' instead of 'cd' (learns your patterns)
# Atuin: Enhanced CTRL-R with full-text search across all history
# ===================================================================


# Ghostty memory monitor
alias ghostty-mem="ps -o pid,rss -p \$(pgrep ghostty) 2>/dev/null | tail -1 | awk '{printf \"Ghostty: %.1f GB\n\", \$2/1024/1024}'"


# ==============================================================================
# 🧠 MEMORY MANAGEMENT ALIASES
# ==============================================================================

# Ver memoria de Ghostty
alias ghostty-mem='ps -o pid,rss,%mem -p $(pgrep ghostty 2>/dev/null) 2>/dev/null | tail -1 | awk "{printf \"Ghostty: %.1f GB (%.1f%% RAM)\n\", \$2/1024/1024, \$3}" || echo "Ghostty no está corriendo"'

# Ver estado general de memoria y swap
alias mem='echo "=== MEMORIA ===" && memory_pressure | grep "free percentage" && echo "" && echo "=== SWAP ===" && sysctl vm.swapusage | awk -F"=" "{print \$2}"'

# Purgar memoria (requiere password)
alias mem-purge='echo "Purgando memoria..." && sudo purge && echo "✅ Memoria purgada"'

# Ver qué procesos usan más memoria
alias mem-hogs='ps aux -m | head -11 | awk "{printf \"%-6s %-5s %-8s %s\n\", \$2, \$4\"%\", \$6/1024\"MB\", \$11}"'

# Alerta si Ghostty usa más de 2GB
alias ghostty-check='mem_gb=$(ps -o rss= -p $(pgrep ghostty 2>/dev/null) 2>/dev/null | awk "{print \$1/1024/1024}"); if (( $(echo "$mem_gb > 2" | bc -l 2>/dev/null || echo 0) )); then echo "⚠️  ALERTA: Ghostty usa ${mem_gb}GB - considera reiniciarlo"; else echo "✅ Ghostty OK: ${mem_gb:-0}GB"; fi'


# ==============================================================================
# 🔄 AUTO-CHECK DE GHOSTTY AL ABRIR TERMINAL
# ==============================================================================

# Función completa de estado de Ghostty
ghostty-status() {
    local pid=$(pgrep ghostty 2>/dev/null)
    if [[ -z "$pid" ]]; then
        echo "👻 Ghostty no está corriendo"
        return
    fi
    
    local mem_kb=$(ps -o rss= -p $pid 2>/dev/null | tr -d ' ')
    local mem_gb=$(echo "scale=2; $mem_kb/1024/1024" | bc)
    local uptime=$(ps -o etime= -p $pid | tr -d ' ')
    local tabs=$(pgrep -P $pid | wc -l | tr -d ' ')
    
    echo "┌─────────────────────────────────────┐"
    echo "│         👻 GHOSTTY STATUS           │"
    echo "├─────────────────────────────────────┤"
    printf "│  PID:      %-24s│\n" "$pid"
    printf "│  Memoria:  %-24s│\n" "${mem_gb} GB"
    printf "│  Uptime:   %-24s│\n" "$uptime"
    printf "│  Tabs:     %-24s│\n" "$tabs"
    echo "└─────────────────────────────────────┘"
    
    # Alerta si usa mucha memoria
    if (( $(echo "$mem_gb > 3" | bc -l) )); then
        echo ""
        echo "⚠️  ALERTA: Ghostty usa ${mem_gb}GB"
        echo "   Considera reiniciarlo con: ghostty-restart"
    fi
}

# Reiniciar Ghostty de forma limpia
ghostty-restart() {
    echo "🔄 Reiniciando Ghostty..."
    osascript -e 'tell application "Ghostty" to quit' 2>/dev/null
    sleep 1
    open -a Ghostty
    echo "✅ Ghostty reiniciado"
}

# Check silencioso al abrir terminal (solo muestra alerta si hay problema)
_ghostty_auto_check() {
    local pid=$(pgrep ghostty 2>/dev/null)
    [[ -z "$pid" ]] && return
    
    local mem_kb=$(ps -o rss= -p $pid 2>/dev/null | tr -d ' ')
    local mem_gb=$(echo "scale=2; $mem_kb/1024/1024" | bc 2>/dev/null)
    
    if (( $(echo "${mem_gb:-0} > 3" | bc -l 2>/dev/null) )); then
        echo ""
        echo "╔═══════════════════════════════════════════════════════════╗"
        echo "║  ⚠️  GHOSTTY MEMORY WARNING: ${mem_gb}GB                      ║"
        echo "║  Ejecuta 'ghostty-restart' para reiniciar                 ║"
        echo "╚═══════════════════════════════════════════════════════════╝"
        echo ""
    fi
}

# Ejecutar check automático al abrir terminal
_ghostty_auto_check

# ==============================================================================
# 📁 TAB TITLE - Solo nombre de carpeta (consistente con Starship)
# ==============================================================================
_set_tab_title() {
    # %1~ = solo el nombre del directorio actual (o ~ si es home)
    print -Pn "\e]0;%1~\a"
}
precmd_functions+=(_set_tab_title)

# opencode
export PATH=/Users/petrucosmindumitru/.opencode/bin:$PATH
