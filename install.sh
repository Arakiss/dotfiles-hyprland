#!/bin/bash
# Dotfiles Installation Script

set -e

DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"

echo "🚀 Installing dotfiles from $DOTFILES_DIR"

# Backup existing files
backup_if_exists() {
    if [ -f "$1" ] || [ -d "$1" ]; then
        echo "  📦 Backing up $1 to $1.backup"
        mv "$1" "$1.backup"
    fi
}

# Create symlinks
link_file() {
    local src="$1"
    local dest="$2"

    if [ -e "$src" ]; then
        backup_if_exists "$dest"
        ln -sf "$src" "$dest"
        echo "  ✓ Linked $dest"
    fi
}

# Install Homebrew packages
echo ""
echo "📦 Installing Homebrew packages..."
if command -v brew &> /dev/null; then
    brew bundle --file="$DOTFILES_DIR/homebrew/Brewfile" || true
else
    echo "  ⚠️ Homebrew not installed. Install from https://brew.sh"
fi

# ZSH
echo ""
echo "🐚 Setting up ZSH..."
link_file "$DOTFILES_DIR/zsh/.zshrc" ~/.zshrc
link_file "$DOTFILES_DIR/zsh/.zshenv" ~/.zshenv
# Link entire zsh folder for modular config
link_file "$DOTFILES_DIR/zsh" ~/.dotfiles-zsh

# Git
echo ""
echo "🐙 Setting up Git..."
link_file "$DOTFILES_DIR/git/.gitconfig" ~/.gitconfig
mkdir -p ~/.ssh
link_file "$DOTFILES_DIR/git/ssh_config" ~/.ssh/config

# Starship
echo ""
echo "🚀 Setting up Starship..."
mkdir -p ~/.config
link_file "$DOTFILES_DIR/config/starship/starship.toml" ~/.config/starship.toml

# Ghostty
echo ""
echo "👻 Setting up Ghostty..."
mkdir -p ~/.config/ghostty
for file in "$DOTFILES_DIR/config/ghostty"/*; do
    if [ -e "$file" ]; then
        name=$(basename "$file")
        link_file "$file" ~/.config/ghostty/"$name"
    fi
done

# Atuin
echo ""
echo "📜 Setting up Atuin..."
mkdir -p ~/.config/atuin
link_file "$DOTFILES_DIR/config/atuin/config.toml" ~/.config/atuin/config.toml

# Mise
echo ""
echo "🔧 Setting up Mise..."
mkdir -p ~/.config/mise
link_file "$DOTFILES_DIR/config/mise/config.toml" ~/.config/mise/config.toml

# Scripts
echo ""
echo "📜 Setting up Scripts..."
mkdir -p ~/.local/bin
for script in "$DOTFILES_DIR/scripts"/*; do
    if [ -e "$script" ]; then
        name=$(basename "$script")
        link_file "$script" ~/.local/bin/"$name"
        chmod +x ~/.local/bin/"$name"
    fi
done

# Cursor
echo ""
echo "📝 Setting up Cursor..."
CURSOR_CONFIG_DIR="$HOME/Library/Application Support/Cursor/User"
if [ -d "$CURSOR_CONFIG_DIR" ]; then
    link_file "$DOTFILES_DIR/config/cursor/settings.json" "$CURSOR_CONFIG_DIR/settings.json"
    link_file "$DOTFILES_DIR/config/cursor/keybindings.json" "$CURSOR_CONFIG_DIR/keybindings.json"
else
    echo "  ⚠️ Cursor not installed. Skipping..."
fi

echo ""
echo "✅ Dotfiles installed!"
echo ""
echo "Next steps:"
echo "  1. Restart your terminal"
echo "  2. Run 'source ~/.zshrc' to reload"
echo "  3. Generate SSH keys if needed: ssh-keygen -t ed25519"
