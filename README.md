# Dotfiles

Personal dotfiles for **CachyOS (Arch Linux)** with **Hyprland** — inspired by [Omarchy](https://github.com/basecamp/omarchy) (DHH's Arch rice from Basecamp).

A curated, modular desktop environment built around the Tokyo Night aesthetic with full theme switching across all components.

## Features

- **17 color themes** with 41 curated wallpapers — Tokyo Night, Catppuccin, Nord, Gruvbox, Hackerman, Rose Pine, and more
- **One-command theme switching** that updates Hyprland, Waybar, Ghostty, Rofi, Mako, Hyprlock, btop, and GTK simultaneously
- **Ghostty terminal** with 5 themes, 4 presets, 5 font configs, tmux integration, and a `gconfig` switcher
- **Modular Hyprland config** — split into bindings, input, look-and-feel, apps, autostart, and environment files
- **95+ utility scripts** — system toggles, app launchers, restart helpers, package management, and theme tools
- **Dual-monitor setup** with machine-specific config separation (local overrides stay out of the repo)
- **Wayland-native stack** — swaybg, grim+slurp, cliphist, mako, hyprlock, hypridle, swayosd

## Stack

| Component      | Tool                                                                                            |
| -------------- | ----------------------------------------------------------------------------------------------- |
| WM             | [Hyprland](https://hyprland.org)                                                                |
| Bar            | [Waybar](https://github.com/Alexays/Waybar)                                                     |
| Terminal       | [Ghostty](https://ghostty.org) (primary) / [Alacritty](https://alacritty.org) (secondary)       |
| Launcher       | [Rofi](https://github.com/lbonn/rofi) (Wayland fork)                                            |
| Notifications  | [Mako](https://github.com/emersion/mako)                                                        |
| Shell          | Zsh + [Starship](https://starship.rs)                                                           |
| Multiplexer    | [tmux](https://github.com/tmux/tmux)                                                            |
| Editor         | [Neovim](https://neovim.io) + LazyVim                                                           |
| Lock           | [Hyprlock](https://github.com/hyprwm/hyprlock) + [Hypridle](https://github.com/hyprwm/hypridle) |
| Screenshots    | grim + slurp + satty                                                                            |
| Clipboard      | cliphist + wl-clipboard                                                                         |
| System Monitor | [btop](https://github.com/aristocratos/btop)                                                    |
| Git TUI        | [Lazygit](https://github.com/jesseduffield/lazygit)                                             |

## Structure

```
~/.dotfiles/
├── bin/                    # 95+ scripts (symlinked to ~/.local/bin/)
├── config/
│   ├── hypr/               # Modular Hyprland config
│   ├── waybar/             # Bar config + themed CSS
│   ├── ghostty/            # Primary terminal
│   │   ├── themes/         # 5 color themes
│   │   ├── presets/        # 4 theme+font combos
│   │   ├── fonts/          # 5 font configs
│   │   ├── tmux/           # Matching tmux config
│   │   └── gconfig         # Quick switcher script
│   ├── alacritty/          # Secondary terminal
│   ├── mako/               # Notifications
│   ├── rofi/               # Launcher theme
│   ├── tmux/               # Ctrl+Space prefix
│   ├── btop/               # System monitor
│   ├── lazygit/            # Git TUI
│   ├── starship/           # Shell prompt
│   ├── fontconfig/         # Font rendering
│   ├── ghostty/            # Ghostty terminal
│   ├── swayosd/            # On-screen display
│   ├── walker/             # Walker launcher
│   ├── imv/                # Image viewer
│   ├── environment.d/      # Wayland env vars
│   ├── systemd/            # User services
│   ├── zsh/                # Shell config
│   ├── git/                # Git config
│   └── fastfetch/          # System info
├── themes/                 # 17 themes, 41 wallpapers
│   ├── tokyo-night/        # Default
│   ├── catppuccin/         # catppuccin-latte also available
│   ├── gruvbox/
│   ├── nord/
│   ├── hackerman/
│   ├── rose-pine/
│   ├── kanagawa/
│   ├── matte-black/
│   ├── vantablack/
│   ├── osaka-jade/
│   ├── ethereal/
│   ├── everforest/
│   ├── miasma/
│   ├── ristretto/
│   ├── flexoki-light/
│   └── white/
├── default/                # Upstream default configs
├── applications/           # .desktop files + icons
└── install-packages.sh     # Package installer
```

## Installation

```bash
git clone git@github.com:Arakiss/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
bash install-packages.sh    # Install all packages
./bin/omarchy-install        # Symlink everything
```

## Key Bindings

All bindings use `SUPER` (Windows key) as the main modifier.

### Apps

| Binding                 | Action         |
| ----------------------- | -------------- |
| `SUPER + Enter`         | Ghostty        |
| `SUPER + Shift + Enter` | Alacritty      |
| `SUPER + Space`         | Rofi launcher  |
| `SUPER + Shift + B`     | Firefox        |
| `SUPER + Alt + Enter`   | Ghostty + tmux |

### Window Management

| Binding                      | Action          |
| ---------------------------- | --------------- |
| `SUPER + W`                  | Close window    |
| `SUPER + F`                  | Fullscreen      |
| `SUPER + T`                  | Toggle floating |
| `SUPER + Arrow Keys`         | Move focus      |
| `SUPER + Shift + Arrow Keys` | Swap windows    |
| `SUPER + -/=`                | Resize width    |

### Workspaces

| Binding               | Action                   |
| --------------------- | ------------------------ |
| `SUPER + 1-0`         | Switch workspace         |
| `SUPER + Shift + 1-0` | Move window to workspace |
| `SUPER + Tab`         | Next workspace           |
| `SUPER + S`           | Scratchpad               |

### System

| Binding                        | Action            |
| ------------------------------ | ----------------- |
| `SUPER + Ctrl + Space`         | Next wallpaper    |
| `SUPER + Ctrl + Shift + Space` | Theme switcher    |
| `SUPER + L`                    | Lock screen       |
| `SUPER + V`                    | Clipboard history |
| `SUPER + B`                    | Toggle Waybar     |
| `Print`                        | Screenshot (full) |
| `SUPER + Print`                | Screenshot (area) |

## Theme System

Each theme includes:

- `colors.conf` — Shell variables for the theme switcher
- `colors.toml` — Upstream Omarchy color definitions
- `backgrounds/` — Curated wallpapers
- `btop.theme` — btop color scheme
- `neovim.lua` — Neovim colorscheme (LazyVim plugin spec)
- `icons.theme` — GTK icon theme
- `preview.png` — Theme preview

### Switch themes

```bash
# Interactive (Rofi menu)
omarchy-theme-set

# Direct
omarchy-theme-set hackerman

# Cycle wallpaper
omarchy-wallpaper-next
```

## Ghostty Terminal

The primary terminal is [Ghostty](https://ghostty.org) with a modular config system. Switch themes, fonts, and presets with `gconfig`:

```bash
# Presets (theme + font combos)
gconfig cyber       # Tokyo Night + Fira Code
gconfig minimal     # Nord + Iosevka
gconfig cozy        # Gruvbox + JetBrains Mono
gconfig pro         # Dracula + Cascadia Code

# Individual switches
gconfig theme dracula
gconfig font fira-code
gconfig status      # Show current config
gconfig reset       # Restore defaults
```

Ghostty keybinds (inside the terminal):

| Binding            | Action            |
| ------------------ | ----------------- |
| `Ctrl+Shift+T`     | New tab           |
| `Ctrl+Shift+D`     | Vertical split    |
| `Ctrl+Shift+O`     | Horizontal split  |
| `Ctrl+Shift+Z`     | Toggle split zoom |
| `Ctrl+Shift+Arrow` | Navigate splits   |
| `Ctrl+Shift+1-9`   | Jump to tab       |
| `Ctrl+Tab`         | Next tab          |
| `Ctrl++/-`         | Font size         |

See [ghostty-warp](https://github.com/Arakiss/ghostty-warp) for the standalone Ghostty config repo.

## Monitor Setup

Monitor configuration is machine-specific and kept out of the repo:

```bash
# Auto-detect and generate local config
omarchy-monitors-setup
# Result: ~/.config/hypr/monitors-local.conf (not tracked)
```

## Credits

- [Omarchy](https://github.com/basecamp/omarchy) by DHH / Basecamp — inspiration, scripts, themes, and wallpapers
- [Hyprland](https://hyprland.org) — the Wayland compositor
- [Tokyo Night](https://github.com/enkia/tokyo-night-vscode-theme) — the default color scheme

## License

Personal dotfiles. Themes and wallpapers from [Omarchy](https://github.com/basecamp/omarchy) are subject to their original license.
