# Dotfiles

Personal shell configuration for syncing across machines. **Automatically adapts to any machine** - no hardcoded paths.

## New Machine Setup (Recommended)

For a completely fresh Mac, run:

```bash
# Option 1: One-liner (after Xcode CLI tools)
curl -fsSL https://raw.githubusercontent.com/Arakiss/dotfiles/main/bootstrap.sh | bash

# Option 2: Manual
git clone https://github.com/Arakiss/dotfiles.git ~/dotfiles
cd ~/dotfiles
./bootstrap.sh
```

The bootstrap script handles everything:
- Xcode Command Line Tools
- Homebrew installation
- SSH key generation (and prompts to add to GitHub)
- Dotfiles installation
- All Homebrew packages

## Quick Install (Existing Setup)

If you already have Homebrew and SSH configured:

```bash
git clone git@github.com:Arakiss/dotfiles.git ~/dotfiles
cd ~/dotfiles
./install.sh
```

## What's Included

### ZSH (Modular)
- **Modular structure** - Easy to extend and maintain
- Oh-My-Zsh with curated plugins
- Modern CLI: `lsd`, `bat`, `fzf`, `zoxide`, `atuin`
- Docker power aliases (battery saving)
- Bun, Supabase, GitHub CLI shortcuts
- Ghostty memory monitoring
- zsh-autosuggestions & syntax-highlighting
- **Productivity tools**: `pet` (workflows), `thefuck` (command corrections)
- Local overrides via `~/.zshrc.local`

### Starship Prompt
- Catppuccin Mocha theme
- Nerd Font icons
- Git status with detailed indicators
- Language version detection

### Ghostty Terminal
- Multiple presets (cyber, minimal, cozy, pro)
- Custom shaders
- Config scripts
- **Workflow snippets** (`pet`) - Warp-like parameterized commands
- **Session management** (`tmux`) - Curated config with Tokyo Night theme
- **AI tools guide** - BYOK recommendations (Claude Code, aider, Gemini CLI)
- **Terminal sharing** (`tmate`) - Share sessions via SSH URL

### Cursor Editor
- Settings and keybindings synced
- Auto-skipped if Cursor not installed

### Homebrew

**CLI Tools (31+):**
- Shell: `zsh-autosuggestions`, `zsh-syntax-highlighting`, `zsh-completions`
- Modern CLI: `lsd`, `bat`, `fzf`, `zoxide`, `atuin`, `eza`, `starship`
- Dev: `gh`, `mise`, `fnm`, `uv`, `tmux`, `ast-grep`
- Database: `supabase`, `libpq`
- Image: `imagemagick`, `jpegoptim`, `pngquant`
- Docs: `pandoc`, `epubcheck`, `tldr`
- Productivity: `thefuck`, `pet`, `tmate`

**Dev Apps (6):**
- Docker, Ghostty, Warp, Google Chrome, Obsidian, Claude

**Fonts:**
- JetBrains Mono + Nerd Font

Install with: `brew bundle --file=homebrew/Brewfile`

## Structure

```
dotfiles/
├── bootstrap.sh              # NEW MACHINE: Full setup
├── install.sh                # Existing machine: Link dotfiles
├── zsh/
│   ├── .zshrc                # Main loader
│   ├── .zshenv
│   ├── config/
│   │   ├── options.zsh       # ZSH options & history
│   │   └── plugins.zsh       # Oh-My-Zsh setup
│   ├── aliases/
│   │   ├── docker.zsh
│   │   ├── git.zsh
│   │   ├── bun.zsh
│   │   ├── supabase.zsh
│   │   ├── system.zsh
│   │   ├── tools.zsh         # lsd, bat, tldr
│   │   └── productivity.zsh  # pet, thefuck
│   ├── functions/
│   │   └── ghostty.zsh
│   └── tools/
│       └── init.zsh          # Tool initialization
├── git/
│   ├── .gitconfig.template   # Template (auto-expands $HOME)
│   └── ssh_config.template   # Template (auto-expands $HOME)
├── config/
│   ├── starship/
│   ├── ghostty/              # Symlink → ~/ghostty-warp (separate repo)
│   ├── atuin/
│   ├── mise/
│   └── cursor/
├── scripts/
│   ├── update.sh             # Sync dotfiles
│   └── macos-defaults.sh     # System preferences
└── homebrew/
    └── Brewfile
```

## Scripts

### bootstrap.sh
Full setup for a new machine. Handles:
1. Xcode Command Line Tools
2. Homebrew installation
3. SSH key generation
4. Cloning this repo
5. Running install.sh

### install.sh
Links all dotfiles and installs Homebrew packages. Uses templates to automatically adapt paths to your machine.

### scripts/update.sh
Sync dotfiles between machines:
```bash
./scripts/update.sh          # Pull + push (default)
./scripts/update.sh pull     # Pull only
./scripts/update.sh push     # Push with commit prompt
./scripts/update.sh status   # Show git status
./scripts/update.sh backup   # Backup current configs
```

### scripts/macos-defaults.sh
Developer-friendly macOS settings (run once after fresh install):
```bash
./scripts/macos-defaults.sh
```
Configures keyboard speed, Finder, Dock, trackpad, screenshots, and more.

## Multi-Machine Support

The dotfiles automatically detect your `$HOME` directory and adapt:
- **Templates** (`*.template`) are processed during install
- **No hardcoded paths** - works on any Mac username
- **SSH keys** are generated per-machine if missing

### Work-Specific Git
Create work-specific config in your projects directory:
```bash
mkdir -p ~/Projects/work
echo '[user]
    name = Your Work Name
    email = work@company.com' > ~/Projects/work/.gitconfig
```

## Requirements

- macOS (Apple Silicon or Intel)
- [Nerd Font](https://www.nerdfonts.com/) (JetBrains Mono included in Brewfile)

## Related Repos

| Repo | Description |
|------|-------------|
| [Arakiss/ghostty-warp](https://github.com/Arakiss/ghostty-warp) | Ghostty terminal config (cloned automatically by install.sh) |
| [Arakiss/claude-config](https://github.com/Arakiss/claude-config) | Claude Code config (CLAUDE.md, skills, commands) |
| [Arakiss/lisa](https://github.com/Arakiss/lisa) | Lisa plugin for iterative loops |

---

**Updated:** February 2026
