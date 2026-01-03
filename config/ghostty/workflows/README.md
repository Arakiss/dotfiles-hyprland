# Workflow Snippets

Ghostty Warp includes [pet](https://github.com/knqyf263/pet), a CLI snippet manager that provides parameterized command workflows - similar to Warp's Workflows feature.

## Quick Start

```bash
# Run setup
./workflows/pet-setup.sh

# Or install manually
brew install knqyf263/pet/pet
```

## Usage

### Basic Commands

```bash
# Search snippets interactively
pet search

# Search and execute
pet exec

# Create new snippet
pet new

# List all snippets
pet list
```

### Aliases

```bash
pw   # pet search (workflow)
pe   # pet exec
pn   # pet new
pl   # pet list
```

### Example: Using a Parameterized Snippet

```bash
$ pw "rebase"
# Select: "Interactive rebase last N commits"
# Prompted: n=5
# Output: git rebase -i HEAD~5
```

## Included Snippets

### Git (`snippets/git.toml`)
- Interactive rebase
- Cherry-pick commits
- Git bisect for debugging
- Stash management
- Branch cleanup
- Patch creation

### Docker (`snippets/docker.toml`)
- Build/run containers
- Port and volume mapping
- Docker Compose commands
- Cleanup commands
- Log viewing

### Development (`snippets/dev.toml`)
- npm/Node.js operations
- Process management
- File operations
- Network/HTTP requests
- SSH/remote operations

## Creating Your Own Snippets

```bash
# Interactive creation
pet new

# Or add directly to ~/.config/pet/snippet.toml
```

### Snippet Format

```toml
[[snippets]]
  description = "My custom command"
  command = "echo 'Hello, <name>!'"
  tag = ["custom", "greeting"]
  output = ""
```

### Parameter Syntax

- `<param>` - Required parameter
- `<param=default>` - Parameter with default value

```toml
# Example with default
command = "git rebase -i HEAD~<n=5>"
# Prompts for 'n', defaults to 5
```

## Syncing Snippets

Pet stores snippets in `~/.config/pet/snippet.toml`.

To sync across machines:
```bash
# Option 1: Use pet's built-in Gist sync
pet configure
# Set: gist.gist_id = "your-gist-id"

# Option 2: Symlink to dotfiles
ln -s ~/dotfiles/pet-snippets.toml ~/.config/pet/snippet.toml
```

## Comparison with Warp Workflows

| Feature | Warp | Ghostty + pet |
|---------|------|---------------|
| Parameterized commands | Yes | Yes |
| Fuzzy search | Yes | Yes (via fzf) |
| Sync across machines | Cloud | Gist or git |
| Team sharing | Cloud | Git repo |
| AI-generated workflows | Yes | No |
| Cost | Subscription | Free |

## Tips

1. **Tag your snippets** for better search
2. **Use defaults** for common values: `<branch=main>`
3. **Combine with fzf** for powerful filtering
4. **Export/import** snippets for team sharing
