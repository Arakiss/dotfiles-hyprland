# Ghostty Functions & Aliases
# ===========================

# Ghostty Config Aliases
alias gconfig="$HOME/.config/ghostty/gconfig"
alias ghostty-config="$HOME/.config/ghostty/interactive-config.sh"
alias gconfig-interactive="$HOME/.config/ghostty/interactive-config.sh"
alias gconfig-switch="$HOME/.config/ghostty/switch-config.sh"

# Quick preset aliases
alias gcyber="$HOME/.config/ghostty/gconfig cyber"
alias gminimal="$HOME/.config/ghostty/gconfig minimal"
alias gcozy="$HOME/.config/ghostty/gconfig cozy"
alias gpro="$HOME/.config/ghostty/gconfig pro"

# Memory monitoring
alias ghostty-mem='ps -o pid,rss,%mem -p $(pgrep ghostty 2>/dev/null) 2>/dev/null | tail -1 | awk "{printf \"Ghostty: %.1f GB (%.1f%% RAM)\n\", \$2/1024/1024, \$3}" || echo "Ghostty no está corriendo"'

alias ghostty-check='mem_gb=$(ps -o rss= -p $(pgrep ghostty 2>/dev/null) 2>/dev/null | awk "{print \$1/1024/1024}"); if (( $(echo "$mem_gb > 2" | bc -l 2>/dev/null || echo 0) )); then echo "⚠️  ALERTA: Ghostty usa ${mem_gb}GB - considera reiniciarlo"; else echo "✅ Ghostty OK: ${mem_gb:-0}GB"; fi'

# Full status function
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

    if (( $(echo "$mem_gb > 3" | bc -l) )); then
        echo ""
        echo "⚠️  ALERTA: Ghostty usa ${mem_gb}GB"
        echo "   Considera reiniciarlo con: ghostty-restart"
    fi
}

# Restart Ghostty cleanly
ghostty-restart() {
    echo "🔄 Reiniciando Ghostty..."
    osascript -e 'tell application "Ghostty" to quit' 2>/dev/null
    sleep 1
    open -a Ghostty
    echo "✅ Ghostty reiniciado"
}

# Auto-check on terminal open (silent unless problem)
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
