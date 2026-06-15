# Session State — Dotfiles Modernization

**Date:** 2026-06-15  
**Branch:** `2021zsh` → PR #1 open against `master`  
**PR URL:** https://github.com/yojiro/dotfiles/pull/1  
**Head commit:** `18590d9` (pushed, up to date with remote)

---

## What Was Done This Session

### Goal
Modernize a long-unmaintained dotfiles repo for a new Apple Silicon MacBook running zsh.

### Commits on Branch

| Commit | Summary |
|--------|---------|
| `461a3d6` | **Core modernization** — bash→zsh, dein→lazy.nvim, pyenv/pip→uv, add Ghostty/Karabiner/Hammerspoon configs, rewrite dotfiles.sh |
| `c75411b` | **Modernization policy** — remove Alacritty/vimrc, fix Homebrew list (remove ctags/autoconf/automake, add git), dynamic xcode-select path, alias vim=nvim, ripgrep in telescope, colorscheme pcall, rewrite README |
| `18590d9` | **Review fixes** — .gitconfig hardcoded path, `[[ $? ]]` bug, `local` outside function, uv python install, check_setup.sh improvement |

### Key Changes (cumulative)

**Deleted:**
- `.bash_profile`, `.vimrc`, `.config/alacritty/alacritty.yml`
- `.config/emacs/` (all files), `lib/atom`, `lib/tex`, `atom.sh`
- `.git-completion.bash` (57KB), `.latexmkrc`, `.screenrc`
- `var/py2-pip.txt`, `var/py3-pip.txt`, `var/neovim2-pip.txt`, `var/neovim3-pip.txt`
- `MEMO/gcloud.md`, `.config/nvim/init.vim`, `.config/nvim/dein.toml`, `.config/nvim/dein_lazy.toml`

**Added:**
- `.zshrc` — full zsh config (CLAUDECODE fast-path, Ghostty focus, im-select IME reset, git prompt)
- `.zprofile` — Homebrew shellenv (Apple Silicon `/opt/homebrew/`)
- `.zshenv` — Volta HOME/PATH
- `.gitignore_global` — `**/.claude/settings.local.json`
- `.hammerspoon/init.lua` — Ghostty focus click replay
- `.config/ghostty/config` — Ghostty terminal config (primary terminal)
- `.config/gh/config.yml` — GitHub CLI prefs (hosts.yml excluded)
- `.config/glow/glow.yml` — Markdown viewer
- `.config/nvim/init.lua` — Neovim full Lua config (lazy.nvim)
- `var/requirements-nvim.txt` — `pynvim` only
- `check_setup.sh` — verification script for clean test environment
- `README.md` — rewritten for current stack

**Updated:**
- `dotfiles.sh` — `.config/` links per-subdir via `link_config()`, removed `-t` tex option
- `lib/brew` — modern install cmd, ghostty/hammerspoon/karabiner/im-select/glow/ripgrep/git, removed obsolete packages
- `lib/python` — uv-based, `uv python install 3` + venv at `~/.local/share/nvim-python`
- `.gitconfig` — `excludesfile = ~/.gitignore_global` (was hardcoded `/Users/yuo/...`)
- `.gitignore` — whitelist ghostty/gh/glow/karabiner, exclude `gh/hosts.yml`, add `.vim/.netrwhist`

---

## Current State

### Repository
- Branch `2021zsh` has 3 commits ahead of `master`
- PR #1 is open, self-reviewed and fixes applied, ready for merge
- Unstaged: `.vim/.netrwhist` (netrw state file, gitignored — ignore)
- Untracked: `karabiner_20210511.json`, `karabiner_20210513.json` (auto-backups, gitignored — ignore)

### Modernization Policy (agreed)

| Axis | Policy |
|------|--------|
| Shell | zsh only, no bash compatibility |
| Python | uv exclusively (pyenv/Poetry deprecated) |
| Node.js | Volta (Bun allowed as additional runtime) |
| Terminal | Ghostty primary |
| Editor | Neovim only |
| Secrets | Never in repo; use `~/.zshrc.local` |
| Tools | Homebrew-managed where possible |

### Sensitive Config (not in repo → `~/.zshrc.local`)
- GitHub PAT (`GITHUB_PERSONAL_ACCESS_TOKEN`)
- `CLUSTER_LLM_API_KEY`, `EXAAI_API_KEY`
- `KUBECONFIG`
- Google Cloud settings (`GOOGLE_CLOUD_PROJECT`, etc.)
- Machine-specific PATHs (arm-gcc, Antigravity)
- Project aliases (`mcdr`, `codex-*`)

---

## Pending / Next Steps

### Must Do Before Merging to master
- [ ] Test on a clean macOS test user account: run `dotfiles.sh initialize && dotfiles.sh deploy`, then `bash check_setup.sh`, paste results to Claude for review

### After Test User Verification
- [ ] Merge PR #1 to `master`
- [ ] Set up new MacBook using the repo

### Known Remaining Gaps (lower priority, post-merge)
- `~/.emacs.d/` still tracked in repo (Cask, init.el, custom-file.el) — can remove if Emacs is fully abandoned
- Volta version not pinned in repo (no `.volta` version file)
- `~/.config/colima/` not tracked — Colima VM config is machine-specific, intentionally excluded
- Font "UDEV Gothic 35NFLG" must be installed manually (not in Homebrew)
- Tmux: TPM installed but no plugins configured (bare minimum)
- LSP setup for Neovim deferred (no nvim-lspconfig yet)

---

## File Map (tracked in repo)

```
dotfiles/
├── dotfiles.sh          # Main install/deploy script
├── check_setup.sh       # Verification script (run on test user)
├── README.md
├── lib/
│   ├── brew             # Homebrew formulae + casks
│   └── python           # uv venv setup for Neovim
├── var/
│   └── requirements-nvim.txt   # pynvim
├── .zshrc               # Main shell config
├── .zprofile            # Login shell (brew shellenv)
├── .zshenv              # Env for all shells (Volta)
├── .gitconfig           # Git config (excludesfile = ~/.gitignore_global)
├── .gitignore_global    # Global gitignore
├── .tmux.conf           # Tmux config
├── .aspell.conf         # Spell checker
├── .pip/pip.conf        # pip config
├── .hammerspoon/
│   └── init.lua         # Ghostty focus click fix
├── .config/
│   ├── nvim/
│   │   ├── init.lua     # Neovim (lazy.nvim, telescope, nvim-cmp, treesitter)
│   │   └── colors/yuo8.vim
│   ├── ghostty/config   # Ghostty terminal
│   ├── gh/config.yml    # GitHub CLI (hosts.yml excluded)
│   ├── glow/glow.yml    # Markdown viewer
│   └── karabiner/       # Keyboard remapping
└── .emacs.d/            # Legacy — consider removing
    ├── init.el
    ├── Cask
    └── custom-file.el
```
