# tmux Configuration

A curated tmux configuration that complements Ghostty Warp's aesthetics and productivity features.

## Installation

```bash
# Symlink to home directory
ln -s ~/.config/ghostty/tmux/tmux.conf ~/.tmux.conf

# Reload if tmux is running
tmux source-file ~/.tmux.conf
```

## Key Bindings

All bindings use the default prefix `Ctrl-b`.

### Pane Management

| Key | Action |
|-----|--------|
| `prefix + \|` | Split vertically |
| `prefix + -` | Split horizontally |
| `prefix + h/j/k/l` | Navigate panes (vim-style) |
| `prefix + H/J/K/L` | Resize panes |
| `prefix + z` | Toggle pane zoom |

### Window Management

| Key | Action |
|-----|--------|
| `prefix + c` | New window (current directory) |
| `prefix + ,` | Rename window |
| `prefix + n/p` | Next/previous window |
| `Alt + 1-5` | Quick switch to window 1-5 |

### Copy Mode

| Key | Action |
|-----|--------|
| `prefix + [` | Enter copy mode |
| `v` | Begin selection (in copy mode) |
| `y` | Copy to clipboard |
| `q` | Exit copy mode |

### Other

| Key | Action |
|-----|--------|
| `prefix + r` | Reload config |
| `prefix + d` | Detach session |
| `prefix + $` | Rename session |

## Terminal Sharing (tmate)

Share your terminal session with others:

```bash
# Start shared session
tmate

# Get SSH URL
tmate show-messages

# Share the URL with collaborators
```

### Read-only sharing

```bash
# Get read-only URL
tmate show-messages | grep "ssh.*-ro"
```

## Plugin Manager (Optional)

### Install TPM

```bash
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```

### Recommended Plugins

Uncomment in `tmux.conf`:

```bash
set -g @plugin 'tmux-plugins/tpm'
set -g @plugin 'tmux-plugins/tmux-sensible'
set -g @plugin 'tmux-plugins/tmux-resurrect'  # Save/restore sessions
set -g @plugin 'tmux-plugins/tmux-continuum'  # Auto-save sessions
```

Install plugins: `prefix + I`

## Theme Variants

The included config uses Tokyo Night colors. For other themes, modify the status bar colors:

### Nord
```bash
set -g status-style 'bg=#2e3440 fg=#d8dee9'
set -g pane-active-border-style 'fg=#88c0d0'
```

### Gruvbox
```bash
set -g status-style 'bg=#282828 fg=#ebdbb2'
set -g pane-active-border-style 'fg=#b8bb26'
```

### Dracula
```bash
set -g status-style 'bg=#282a36 fg=#f8f8f2'
set -g pane-active-border-style 'fg=#bd93f9'
```

## Comparison with Warp

| Feature | Warp | tmux |
|---------|------|------|
| Split panes | Yes | Yes |
| Tab/windows | Yes | Yes |
| Session persistence | Automatic | With plugins |
| Session sharing | Cloud | tmate (SSH) |
| Mouse support | Yes | Yes |
| Vim keybindings | Yes | Yes |
| Cost | Subscription | Free |

## Tips

1. **Learn the prefix key** - All commands start with `Ctrl-b`
2. **Use sessions** - Organize projects in different sessions
3. **Detach, don't close** - `prefix + d` keeps session running
4. **Pair with tmate** - Share sessions for collaboration
