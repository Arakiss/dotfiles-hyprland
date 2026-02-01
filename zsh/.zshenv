# Homebrew (must be first - sets up PATH for all brew-installed tools)
if [[ -f /opt/homebrew/bin/brew ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
elif [[ -f /usr/local/bin/brew ]]; then
    eval "$(/usr/local/bin/brew shellenv)"
fi

# Cargo/Rust environment (if installed)
[[ -f "$HOME/.cargo/env" ]] && . "$HOME/.cargo/env"
