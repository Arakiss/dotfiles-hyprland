# Dotfiles

Personal shell configuration for syncing across machines.

## Quick Install

```bash
git clone git@github.com:Arakiss/dotfiles.git ~/dotfiles
cd ~/dotfiles
./install.sh
```

## New Machine Bootstrap

For a fresh macOS install, run the full bootstrap:
```bash
curl -fsSL https://raw.githubusercontent.com/Arakiss/dotfiles/main/scripts/bootstrap.sh | bash
```

This installs Homebrew, Oh-My-Zsh, Bun, fnm, mise, and all dotfiles.

## Contents

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
├── zsh/
│   ├── .zshrc              # Main loader
│   ├── .zshenv
│   ├── config/
│   │   ├── options.zsh     # ZSH options & history
│   │   └── plugins.zsh     # Oh-My-Zsh setup
│   ├── aliases/
│   │   ├── docker.zsh
│   │   ├── git.zsh
│   │   ├── bun.zsh
│   │   ├── supabase.zsh
│   │   ├── system.zsh
│   │   ├── tools.zsh       # lsd, bat, tldr
│   │   └── productivity.zsh # pet, thefuck
│   ├── functions/
│   │   └── ghostty.zsh
│   └── tools/
│       └── init.zsh        # Tool initialization
├── git/
│   ├── .gitconfig
│   └── ssh_config
├── config/
│   ├── starship/
│   ├── ghostty/
│   │   ├── ai/             # AI tools guide
│   │   ├── workflows/      # pet snippets
│   │   └── tmux/           # tmux config
│   ├── atuin/
│   ├── mise/
│   └── cursor/
├── scripts/
│   ├── bootstrap.sh        # New machine setup
│   ├── update.sh           # Sync dotfiles
│   └── macos-defaults.sh   # System preferences
├── homebrew/
│   └── Brewfile
└── install.sh
```

## Scripts

### bootstrap.sh
Full setup for a new machine. Installs Homebrew, Oh-My-Zsh, Bun, fnm, mise, and runs `install.sh`.

### update.sh
Sync dotfiles between machines:
```bash
./scripts/update.sh          # Pull + push (default)
./scripts/update.sh pull     # Pull only
./scripts/update.sh push     # Push with commit prompt
./scripts/update.sh status   # Show git status
./scripts/update.sh backup   # Backup current configs
```

### macos-defaults.sh
Developer-friendly macOS settings (run once after fresh install):
```bash
./scripts/macos-defaults.sh
```
Configures keyboard speed, Finder, Dock, trackpad, screenshots, and more.

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

## Related Repos

| Repo | Description |
|------|-------------|
| [Arakiss/claude-config](https://github.com/Arakiss/claude-config) | Claude Code config (CLAUDE.md, skills, commands) |
| [Arakiss/lisa](https://github.com/Arakiss/lisa) | Lisa plugin for iterative loops |

---

**Updated:** January 2026
