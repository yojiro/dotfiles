# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this repo is

macOS (Apple Silicon) dotfiles. Scripts symlink everything into `~` so a new Mac can be reproduced by running two commands.

## Setup commands

```sh
# Full install (Homebrew + extras)
~/dotfiles/dotfiles.sh initialize

# Symlink dotfiles into ~
~/dotfiles/dotfiles.sh deploy

# Force-overwrite existing files
~/dotfiles/dotfiles.sh -f deploy

# Verify a setup is correct
bash ~/dotfiles/check_setup.sh
```

## How deploy works

`dotfiles.sh deploy` loops over `.??*` in the repo root and creates symlinks in `~`. It skips `.git`, `.gitignore`, and `.config`. The `.config/` subdirectories are linked individually by `link_config()` (each tool's directory as one symlink).

Files that are **not** symlinked automatically (manually managed or excluded):
- `.config/karabiner/` — Karabiner auto-generates backups there; only `karabiner.json` matters

## Environment-specific / secret config

Nothing secret goes in the repo. Put it in `~/.zshrc.local` — `.zshrc` sources it silently at the end.

## Component map

| Config | Location |
|---|---|
| zsh | `.zshrc` / `.zprofile` / `.zshenv` |
| Terminal | `.config/ghostty/config` |
| Git | `.gitconfig` |
| Keyboard | `.config/karabiner/karabiner.json` |
| Window manager | `.hammerspoon/init.lua` |
| Node.js | `.zshenv` — Volta manages versions |

## `.zshrc` fast-path for Claude Code

When `$CLAUDECODE` is set, `.zshrc` returns early after setting only `PATH`. No brew shellenv, no compinit, no prompt setup. Keep this block minimal.

## Adding Homebrew packages

Edit the `desired_formulae` or cask array in `lib/brew`. The `initialize` command installs only what's missing.

## Adding non-Homebrew tools (`lib/extras`)

`lib/extras` handles tools installed outside Homebrew, called from `initialize` (also runnable standalone as `dotfiles.sh extras`):

| tool | method |
|---|---|
| Claude CLI | `curl -fsSL https://claude.ai/install.sh \| bash` → `~/.local/bin/` |
| github-mcp-server | `gh release download` from `github/github-mcp-server` → `~/.local/bin/` |
| Volta | `curl https://get.volta.sh \| bash` |
| npm globals | `npm install -g` via Homebrew npm |

To add an npm global, append to `desired_packages` in `_install_npm_globals`. To add a new binary tool, add a `_install_<name>()` function and call it from `run_extras()`.
