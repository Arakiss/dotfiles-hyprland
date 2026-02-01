#!/bin/bash
# =============================================================================
# Dotfiles Installation Script
# =============================================================================
# Automatically adapts to any machine - no hardcoded paths
# =============================================================================

set -e

DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"

echo "============================================="
echo "  Installing Dotfiles"
echo "============================================="
echo "  Home: $HOME"
echo "  User: $USER"
echo "  Dotfiles: $DOTFILES_DIR"
echo "============================================="
echo ""

# Colors
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

# Backup existing files
backup_if_exists() {
    if [ -f "$1" ] || [ -d "$1" ]; then
        if [ ! -L "$1" ]; then  # Don't backup symlinks
            echo -e "  ${YELLOW}Backing up${NC} $1"
            mv "$1" "$1.backup.$(date +%Y%m%d%H%M%S)"
        fi
    fi
}

# Create symlinks
link_file() {
    local src="$1"
    local dest="$2"

    if [ -e "$src" ]; then
        backup_if_exists "$dest"
        mkdir -p "$(dirname "$dest")"
        ln -sf "$src" "$dest"
        echo -e "  ${GREEN}Linked${NC} $dest"
    fi
}

# Process template file (replace {{HOME}} with actual home)
process_template() {
    local template="$1"
    local dest="$2"

    if [ -f "$template" ]; then
        backup_if_exists "$dest"
        mkdir -p "$(dirname "$dest")"
        sed "s|{{HOME}}|$HOME|g" "$template" > "$dest"
        echo -e "  ${GREEN}Generated${NC} $dest"
    fi
}

# =============================================================================
# Homebrew packages
# =============================================================================
echo "Installing Homebrew packages..."
if command -v brew &> /dev/null; then
    # Update brew
    brew update || true

    # Install from Brewfile
    if [ -f "$DOTFILES_DIR/homebrew/Brewfile" ]; then
        brew bundle --file="$DOTFILES_DIR/homebrew/Brewfile" || true
    fi
else
    echo -e "  ${YELLOW}Homebrew not installed. Run bootstrap.sh first or install from https://brew.sh${NC}"
fi

# =============================================================================
# SSH Configuration
# =============================================================================
echo ""
echo "Setting up SSH..."
mkdir -p "$HOME/.ssh"
chmod 700 "$HOME/.ssh"

# Generate SSH key if it doesn't exist
if [ ! -f "$HOME/.ssh/id_ed25519" ]; then
    echo "  Generating SSH key..."
    ssh-keygen -t ed25519 -C "${GIT_EMAIL:-petruarakiss@gmail.com}" -f "$HOME/.ssh/id_ed25519" -N ""
    echo ""
    echo "  New SSH public key:"
    cat "$HOME/.ssh/id_ed25519.pub"
    echo ""
    echo "  Add it to GitHub: https://github.com/settings/keys"
fi

# Process SSH config template
if [ -f "$DOTFILES_DIR/git/ssh_config.template" ]; then
    process_template "$DOTFILES_DIR/git/ssh_config.template" "$HOME/.ssh/config"
    chmod 600 "$HOME/.ssh/config"
elif [ -f "$DOTFILES_DIR/git/ssh_config" ]; then
    link_file "$DOTFILES_DIR/git/ssh_config" "$HOME/.ssh/config"
    chmod 600 "$HOME/.ssh/config"
fi

# Add key to agent
eval "$(ssh-agent -s)" &>/dev/null || true
ssh-add --apple-use-keychain "$HOME/.ssh/id_ed25519" 2>/dev/null || \
ssh-add "$HOME/.ssh/id_ed25519" 2>/dev/null || true

# =============================================================================
# Git Configuration
# =============================================================================
echo ""
echo "Setting up Git..."

# Process gitconfig template
if [ -f "$DOTFILES_DIR/git/.gitconfig.template" ]; then
    process_template "$DOTFILES_DIR/git/.gitconfig.template" "$HOME/.gitconfig"
elif [ -f "$DOTFILES_DIR/git/.gitconfig" ]; then
    link_file "$DOTFILES_DIR/git/.gitconfig" "$HOME/.gitconfig"
fi

# Create project directories structure
mkdir -p "$HOME/Projects/personal"
mkdir -p "$HOME/Projects/work"
mkdir -p "$HOME/Projects/azure"

# =============================================================================
# ZSH Configuration
# =============================================================================
echo ""
echo "Setting up ZSH..."
link_file "$DOTFILES_DIR/zsh/.zshrc" "$HOME/.zshrc"
link_file "$DOTFILES_DIR/zsh/.zshenv" "$HOME/.zshenv"
link_file "$DOTFILES_DIR/zsh" "$HOME/.dotfiles-zsh"

# =============================================================================
# Starship Prompt
# =============================================================================
echo ""
echo "Setting up Starship..."
mkdir -p "$HOME/.config"
link_file "$DOTFILES_DIR/config/starship/starship.toml" "$HOME/.config/starship.toml"

# =============================================================================
# Ghostty Terminal
# =============================================================================
echo ""
echo "Setting up Ghostty..."
mkdir -p "$HOME/.config/ghostty"
for file in "$DOTFILES_DIR/config/ghostty"/*; do
    if [ -f "$file" ]; then
        name=$(basename "$file")
        link_file "$file" "$HOME/.config/ghostty/$name"
    fi
done

# =============================================================================
# Atuin (Shell History)
# =============================================================================
echo ""
echo "Setting up Atuin..."
mkdir -p "$HOME/.config/atuin"
link_file "$DOTFILES_DIR/config/atuin/config.toml" "$HOME/.config/atuin/config.toml"

# =============================================================================
# Mise (Version Manager)
# =============================================================================
echo ""
echo "Setting up Mise..."
mkdir -p "$HOME/.config/mise"
link_file "$DOTFILES_DIR/config/mise/config.toml" "$HOME/.config/mise/config.toml"

# =============================================================================
# Custom Scripts
# =============================================================================
echo ""
echo "Setting up Scripts..."
mkdir -p "$HOME/.local/bin"
for script in "$DOTFILES_DIR/scripts"/*; do
    if [ -f "$script" ]; then
        name=$(basename "$script")
        link_file "$script" "$HOME/.local/bin/$name"
        chmod +x "$HOME/.local/bin/$name"
    fi
done

# =============================================================================
# Cursor/VS Code
# =============================================================================
echo ""
echo "Setting up Cursor..."
CURSOR_CONFIG_DIR="$HOME/Library/Application Support/Cursor/User"
if [ -d "$CURSOR_CONFIG_DIR" ] || [ -d "/Applications/Cursor.app" ]; then
    mkdir -p "$CURSOR_CONFIG_DIR"
    link_file "$DOTFILES_DIR/config/cursor/settings.json" "$CURSOR_CONFIG_DIR/settings.json"
    link_file "$DOTFILES_DIR/config/cursor/keybindings.json" "$CURSOR_CONFIG_DIR/keybindings.json"
else
    echo -e "  ${YELLOW}Cursor not installed. Skipping...${NC}"
fi

# =============================================================================
# macOS Defaults (optional)
# =============================================================================
if [ -f "$DOTFILES_DIR/macos/defaults.sh" ]; then
    echo ""
    echo "Applying macOS defaults..."
    chmod +x "$DOTFILES_DIR/macos/defaults.sh"
    "$DOTFILES_DIR/macos/defaults.sh" || true
fi

# =============================================================================
# Done!
# =============================================================================
echo ""
echo "============================================="
echo "  Dotfiles Installed!"
echo "============================================="
echo ""
echo "Next steps:"
echo "  1. Restart your terminal"
echo "  2. Or run: source ~/.zshrc"
echo ""

# Show SSH key if newly generated
if [ ! -f "$HOME/.ssh/id_ed25519.pub.added" ]; then
    if [ -f "$HOME/.ssh/id_ed25519.pub" ]; then
        echo "Don't forget to add your SSH key to GitHub:"
        echo "  https://github.com/settings/keys"
        echo ""
        echo "Your public key:"
        cat "$HOME/.ssh/id_ed25519.pub"
        echo ""
    fi
fi
