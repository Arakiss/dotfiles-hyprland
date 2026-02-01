#!/bin/bash
# =============================================================================
# Bootstrap Script for New Machines
# =============================================================================
# Run this on a fresh Mac:
#   curl -fsSL https://raw.githubusercontent.com/Arakiss/dotfiles/main/bootstrap.sh | bash
# Or if you already cloned:
#   ./bootstrap.sh
# =============================================================================

set -e

echo "============================================="
echo "  Dotfiles Bootstrap - New Machine Setup"
echo "============================================="
echo ""

# Detect HOME and USER automatically
DOTFILES_DIR="${DOTFILES_DIR:-$HOME/dotfiles}"
REPO_URL="git@github.com:Arakiss/dotfiles.git"
REPO_URL_HTTPS="https://github.com/Arakiss/dotfiles.git"

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

print_step() {
    echo -e "${GREEN}==>${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}Warning:${NC} $1"
}

print_error() {
    echo -e "${RED}Error:${NC} $1"
}

# =============================================================================
# Step 1: Xcode Command Line Tools
# =============================================================================
print_step "Checking Xcode Command Line Tools..."
if ! xcode-select -p &> /dev/null; then
    echo "  Installing Xcode Command Line Tools..."
    xcode-select --install
    echo ""
    echo "  Please complete the Xcode installation popup, then run this script again."
    exit 0
else
    echo "  Xcode Command Line Tools already installed."
fi

# =============================================================================
# Step 2: Homebrew
# =============================================================================
print_step "Checking Homebrew..."
if ! command -v brew &> /dev/null; then
    echo "  Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

    # Add Homebrew to PATH for Apple Silicon
    if [[ $(uname -m) == "arm64" ]]; then
        echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> "$HOME/.zprofile"
        eval "$(/opt/homebrew/bin/brew shellenv)"
    fi
else
    echo "  Homebrew already installed."
fi

# Ensure brew is in PATH
if [[ $(uname -m) == "arm64" ]] && [[ -f /opt/homebrew/bin/brew ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# =============================================================================
# Step 3: SSH Key Generation
# =============================================================================
print_step "Checking SSH keys..."
SSH_KEY="$HOME/.ssh/id_ed25519"
if [[ ! -f "$SSH_KEY" ]]; then
    echo "  Generating new SSH key..."
    mkdir -p "$HOME/.ssh"
    chmod 700 "$HOME/.ssh"

    # Prompt for email
    read -p "  Enter your email for SSH key (default: petruarakiss@gmail.com): " SSH_EMAIL
    SSH_EMAIL="${SSH_EMAIL:-petruarakiss@gmail.com}"

    ssh-keygen -t ed25519 -C "$SSH_EMAIL" -f "$SSH_KEY" -N ""

    # Start ssh-agent and add key
    eval "$(ssh-agent -s)"
    ssh-add --apple-use-keychain "$SSH_KEY" 2>/dev/null || ssh-add "$SSH_KEY"

    echo ""
    echo "  Your public key (copy this to GitHub):"
    echo "  ----------------------------------------"
    cat "${SSH_KEY}.pub"
    echo "  ----------------------------------------"
    echo ""
    echo "  Add it at: https://github.com/settings/keys"
    echo ""

    # Copy to clipboard
    cat "${SSH_KEY}.pub" | pbcopy
    echo "  (Key copied to clipboard)"
    echo ""
    read -p "  Press Enter after adding the key to GitHub..."
else
    echo "  SSH key already exists."
    eval "$(ssh-agent -s)" &>/dev/null
    ssh-add --apple-use-keychain "$SSH_KEY" 2>/dev/null || ssh-add "$SSH_KEY" 2>/dev/null || true
fi

# =============================================================================
# Step 4: Clone Dotfiles
# =============================================================================
print_step "Checking dotfiles repository..."
if [[ ! -d "$DOTFILES_DIR" ]]; then
    echo "  Cloning dotfiles..."
    # Try SSH first, fall back to HTTPS
    if ssh -T git@github.com 2>&1 | grep -q "successfully authenticated"; then
        git clone "$REPO_URL" "$DOTFILES_DIR"
    else
        print_warning "SSH not configured for GitHub, using HTTPS..."
        git clone "$REPO_URL_HTTPS" "$DOTFILES_DIR"
    fi
else
    echo "  Dotfiles already cloned. Pulling latest..."
    cd "$DOTFILES_DIR" && git pull
fi

# =============================================================================
# Step 5: Run Install Script
# =============================================================================
print_step "Running dotfiles installation..."
cd "$DOTFILES_DIR"
chmod +x install.sh
./install.sh

echo ""
echo "============================================="
echo "  Bootstrap Complete!"
echo "============================================="
echo ""
echo "Next steps:"
echo "  1. Restart your terminal (or run: source ~/.zshrc)"
echo "  2. Open Ghostty for the best terminal experience"
echo ""
