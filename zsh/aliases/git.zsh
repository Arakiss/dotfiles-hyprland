# Git Extras (complementing oh-my-zsh git plugin)
# ================================================
# The plugin gives you: ga, gaa, gc, gco, gp, gl, gst, etc.

alias gundo='git reset --soft HEAD~1'
alias gunstage='git restore --staged'
alias gwip='git add -A && git commit -m "WIP"'
alias gclean='git branch --merged | grep -v "\*\|main\|master" | xargs -n 1 git branch -d'
alias glog='git log --oneline --graph --decorate -20'
alias gloga='git log --oneline --graph --decorate --all'

# GitHub CLI Shortcuts
alias ghpr='gh pr create'
alias ghprl='gh pr list'
alias ghprv='gh pr view --web'
alias ghprc='gh pr checkout'
alias ghis='gh issue list'
alias ghiv='gh issue view'
alias ghrepo='gh repo view --web'
alias ghrun='gh run list'
