#!/bin/bash
# Pet Snippet Manager Setup
# Configures pet for parameterized workflow snippets

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SNIPPETS_DIR="$SCRIPT_DIR/snippets"
PET_CONFIG_DIR="$HOME/.config/pet"

echo "=== Pet Workflow Setup ==="
echo ""

# Check if pet is installed
if ! command -v pet &> /dev/null; then
    echo "Installing pet..."
    brew install knqyf263/pet/pet
    echo "pet installed successfully!"
else
    echo "pet is already installed."
fi

echo ""

# Create pet config directory
mkdir -p "$PET_CONFIG_DIR"

# Configure pet to use our snippets directory
PET_CONFIG="$PET_CONFIG_DIR/config.toml"
if [ ! -f "$PET_CONFIG" ]; then
    echo "Creating pet configuration..."
    cat > "$PET_CONFIG" << 'TOML'
[General]
  snippetfile = "~/.config/pet/snippet.toml"
  editor = "vim"
  column = 40
  selectcmd = "fzf"
  backend = "fzf"

[General.color]
  command = "cyan"
  description = "green"
  tag = "yellow"
TOML
    echo "Configuration created at $PET_CONFIG"
fi

# Import default snippets
echo ""
echo "Importing default workflow snippets..."

for snippet_file in "$SNIPPETS_DIR"/*.toml; do
    if [ -f "$snippet_file" ]; then
        filename=$(basename "$snippet_file")
        echo "  - Importing $filename"
        cat "$snippet_file" >> "$PET_CONFIG_DIR/snippet.toml"
    fi
done

echo ""
echo "=== Setup Complete ==="
echo ""
echo "Usage:"
echo "  pet new      # Create new snippet"
echo "  pet search   # Search snippets (fuzzy)"
echo "  pet exec     # Search and execute"
echo "  pet list     # List all snippets"
echo ""
echo "Aliases:"
echo "  pn   # pet new"
echo "  pw   # pet search (workflow)"
echo "  pe   # pet exec"
echo "  pl   # pet list"
echo ""
