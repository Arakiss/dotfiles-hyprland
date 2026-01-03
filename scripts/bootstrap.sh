#!/bin/bash
# =============================================================================
# Bootstrap Script - New Machine Setup
# =============================================================================
# Run this on a fresh macOS install:
#   curl -fsSL https://raw.githubusercontent.com/Arakiss/dotfiles/main/scripts/bootstrap.sh | bash
# =============================================================================

set -e

echo ""
echo "╔═══════════════════════════════════════════════════════════════════╗"
echo "║                    🚀 MACHINE BOOTSTRAP                           ║"
echo "╚═══════════════════════════════════════════════════════════════════╝"
echo ""

# -----------------------------------------------------------------------------
# Xcode Command Line Tools
# -----------------------------------------------------------------------------
echo "📦 Checking Xcode Command Line Tools..."
if ! xcode-select -p &>/dev/null; then
    echo "  Installing Xcode Command Line Tools..."
    xcode-select --install
    echo "  ⚠️  Please complete the installation dialog, then re-run this script."
    exit 1
else
    echo "  ✓ Already installed"
fi

# -----------------------------------------------------------------------------
# Homebrew
# -----------------------------------------------------------------------------
echo ""
echo "🍺 Checking Homebrew..."
if ! command -v brew &>/dev/null; then
    echo "  Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

    # Add Homebrew to PATH for this session
    eval "$(/opt/homebrew/bin/brew shellenv)"
else
    echo "  ✓ Already installed"
    echo "  Updating Homebrew..."
    brew update
fi

# -----------------------------------------------------------------------------
# Git (needed to clone dotfiles)
# -----------------------------------------------------------------------------
echo ""
echo "📥 Checking Git..."
if ! command -v git &>/dev/null; then
    echo "  Installing Git..."
    brew install git
else
    echo "  ✓ Already installed"
fi

# -----------------------------------------------------------------------------
# Clone Dotfiles
# -----------------------------------------------------------------------------
DOTFILES_DIR="$HOME/dotfiles"

echo ""
echo "📂 Setting up dotfiles..."
if [ -d "$DOTFILES_DIR" ]; then
    echo "  ✓ Dotfiles already exist at $DOTFILES_DIR"
    echo "  Pulling latest changes..."
    cd "$DOTFILES_DIR" && git pull
else
    echo "  Cloning dotfiles..."
    git clone https://github.com/Arakiss/dotfiles.git "$DOTFILES_DIR"
fi

# -----------------------------------------------------------------------------
# Install Core Tools via Homebrew
# -----------------------------------------------------------------------------
echo ""
echo "🛠️  Installing core tools..."
brew bundle --file="$DOTFILES_DIR/homebrew/Brewfile" || true

# -----------------------------------------------------------------------------
# Install Oh-My-Zsh
# -----------------------------------------------------------------------------
echo ""
echo "🐚 Checking Oh-My-Zsh..."
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo "  Installing Oh-My-Zsh..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
else
    echo "  ✓ Already installed"
fi

# -----------------------------------------------------------------------------
# Install Bun
# -----------------------------------------------------------------------------
echo ""
echo "🥟 Checking Bun..."
if ! command -v bun &>/dev/null; then
    echo "  Installing Bun..."
    curl -fsSL https://bun.sh/install | bash
else
    echo "  ✓ Already installed"
fi

# -----------------------------------------------------------------------------
# Install fnm (Fast Node Manager)
# -----------------------------------------------------------------------------
echo ""
echo "📦 Checking fnm..."
if ! command -v fnm &>/dev/null; then
    echo "  Installing fnm..."
    brew install fnm
else
    echo "  ✓ Already installed"
fi

# -----------------------------------------------------------------------------
# Install mise (Runtime Version Manager)
# -----------------------------------------------------------------------------
echo ""
echo "🔧 Checking mise..."
if ! command -v mise &>/dev/null; then
    echo "  Installing mise..."
    curl https://mise.run | sh
else
    echo "  ✓ Already installed"
fi

# -----------------------------------------------------------------------------
# Run Dotfiles Installer
# -----------------------------------------------------------------------------
echo ""
echo "🔗 Running dotfiles installer..."
cd "$DOTFILES_DIR"
./install.sh

# -----------------------------------------------------------------------------
# Setup Atuin (if installed)
# -----------------------------------------------------------------------------
echo ""
echo "📜 Checking Atuin..."
if command -v atuin &>/dev/null; then
    if [ ! -f "$HOME/.config/atuin/session" ]; then
        echo "  Atuin is installed but not logged in."
        echo "  Run 'atuin login' to sync your shell history."
    else
        echo "  ✓ Atuin configured"
    fi
fi

# -----------------------------------------------------------------------------
# Done!
# -----------------------------------------------------------------------------
echo ""
echo "╔═══════════════════════════════════════════════════════════════════╗"
echo "║                     ✅ BOOTSTRAP COMPLETE!                        ║"
echo "╚═══════════════════════════════════════════════════════════════════╝"
echo ""
echo "Next steps:"
echo "  1. Restart your terminal (or run: exec zsh)"
echo "  2. Generate SSH keys: ssh-keygen -t ed25519 -C 'your@email.com'"
echo "  3. Add SSH key to GitHub: gh auth login"
echo "  4. Setup Atuin sync: atuin login"
echo ""
