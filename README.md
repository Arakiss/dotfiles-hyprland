# Dotfiles

Personal shell configuration for syncing across machines.

## Quick Install

```bash
git clone git@github.com:Arakiss/dotfiles.git ~/dotfiles
cd ~/dotfiles
./install.sh
```

## Contents

### ZSH (`.zshrc`)
- Oh-My-Zsh with curated plugins
- Modern CLI replacements: `lsd`, `bat`, `fzf`, `zoxide`
- Docker power aliases (battery saving)
- Bun, Supabase, GitHub CLI shortcuts
- Ghostty memory monitoring
- zsh-autosuggestions & syntax-highlighting
- Atuin history sync

### Starship Prompt
- Catppuccin Mocha theme
- Nerd Font icons
- Git status with detailed indicators
- Language version detection

### Ghostty Terminal
- Multiple presets (cyber, minimal, cozy, pro)
- Custom shaders
- Config scripts

### Homebrew
- Essential packages in `Brewfile`
- Install with: `brew bundle --file=homebrew/Brewfile`

## Structure

```
dotfiles/
├── zsh/
│   ├── .zshrc
│   └── .zshenv
├── git/
│   ├── .gitconfig
│   └── ssh_config
├── config/
│   ├── starship/
│   ├── ghostty/
│   ├── atuin/
│   └── mise/
├── scripts/
├── homebrew/
│   └── Brewfile
└── install.sh
```

## Manual Steps

### SSH Keys
Generate new keys on each machine:
```bash
ssh-keygen -t ed25519 -C "your@email.com"
```

### Work-Specific Git
Create work-specific config:
```bash
# In your work projects directory
echo '[user]
    name = Your Work Name
    email = work@company.com' > .gitconfig
```

## Requirements

- macOS
- Homebrew
- [Nerd Font](https://www.nerdfonts.com/) (JetBrains Mono recommended)

---

**Updated:** January 2026
