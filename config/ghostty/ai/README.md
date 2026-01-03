# AI-Powered Terminal

Modern terminals benefit from AI assistance. Here are the best options for your workflow.

## Recommended Tools

### Claude Code (Recommended)

If you're using Claude Code, you already have AI in your terminal. No additional setup needed.

```bash
# You're already here!
claude "how do I find large files"
```

### Gemini CLI (Free)

Google's free AI assistant with 1,000 requests/day:

```bash
# Install
npm install -g @anthropic/gemini-cli

# Use
gemini "compress all images in this directory"
```

### aider (AI Pair Programming)

Best for code editing and refactoring:

```bash
# Install
pip install aider-chat

# Use with your repo
aider --model claude-3-5-sonnet

# Or with local models
aider --model ollama/codellama
```

### OpenAI Codex CLI

```bash
npm install -g @openai/codex
codex "write a bash script to backup my dotfiles"
```

## Shell Aliases

Add to your `~/.zshrc` if you want quick access:

```bash
# If using aider
alias pair='aider'

# Quick AI query (choose your tool)
alias ai='gemini'
# or
alias ai='claude'
```

## Philosophy

Ghostty Warp doesn't force a specific AI tool because:

1. **You probably already have one** - Claude Code, Cursor, etc.
2. **AI tools evolve fast** - Today's best may be outdated tomorrow
3. **BYOK** - Bring your own key, your own tool

## Comparison

| Tool | Free Tier | Best For |
|------|-----------|----------|
| Claude Code | With subscription | Already using Claude |
| Gemini CLI | 1000/day | Free, fast queries |
| aider | API costs | Code editing/refactoring |
| Codex | API costs | OpenAI ecosystem |

## Local Models (Privacy-First)

For fully offline AI:

```bash
# Install Ollama
brew install ollama

# Run a model
ollama pull codellama
ollama run codellama

# Use with aider
aider --model ollama/codellama
```

No API keys, no internet, complete privacy.
