# Docker Power Aliases - Battery Saving
# =====================================

# Stop all running containers
alias docker-stop-all='docker stop $(docker ps -q) 2>/dev/null || echo "No containers running"'

# Stop all containers and remove them
alias docker-nuke='docker stop $(docker ps -aq) 2>/dev/null && docker rm $(docker ps -aq) 2>/dev/null || echo "All cleaned up"'

# Stop only Supabase analytics containers (battery killers)
alias docker-stop-analytics='docker ps --filter "name=supabase_analytics" --format "{{.ID}}" | xargs docker stop 2>/dev/null || echo "No analytics containers running"'

# Show Docker resource usage
alias docker-stats='docker stats --no-stream --format "table {{.Name}}\t{{.CPUPerc}}\t{{.MemUsage}}"'

# Show only running Supabase containers
alias docker-supabase='docker ps --filter "name=supabase_" --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}"'

# Quick restart all containers
alias docker-restart-all='docker restart $(docker ps -q) 2>/dev/null || echo "No containers to restart"'
