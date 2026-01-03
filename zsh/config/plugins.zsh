# Oh-My-Zsh Configuration
# =======================

export ZSH="$HOME/.oh-my-zsh"

# Theme disabled - using Starship instead
# ZSH_THEME="robbyrussell"

# Plugins: Only built-in (external ones loaded in tools/init.zsh)
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

# Docker CLI completions
fpath=($HOME/.docker/completions $fpath)
autoload -Uz compinit
compinit
