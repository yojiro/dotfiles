# dotfiles

macOS (Apple Silicon) 環境を統一するための dotfiles。
git clone してセットアップスクリプトを実行するだけで新しい Mac に同じ環境を再現できる。

## 前提条件

- macOS (Apple Silicon)
- Xcode Command Line Tools

```sh
xcode-select --install
```

## セットアップ

```sh
git clone git@github.com:yojiro/dotfiles.git ~/dotfiles

# Homebrew・アプリ・Python provider のインストール
~/dotfiles/dotfiles.sh initialize

# dotfiles をホームディレクトリへシンボリックリンク
~/dotfiles/dotfiles.sh deploy
```

強制上書き（既存のファイルを置き換える）:

```sh
~/dotfiles/dotfiles.sh -f deploy
```

## 構成

| コンポーネント | 設定ファイル | 備考 |
|---|---|---|
| Shell | `.zshrc` / `.zprofile` / `.zshenv` | zsh 専用 |
| Terminal | `.config/ghostty/config` | Ghostty (primary) |
| Git | `.gitconfig` | `.config/gh/config.yml` (GitHub CLI) |
| Keyboard | `.config/karabiner/karabiner.json` | Karabiner-Elements |
| Window manager | `.hammerspoon/init.lua` | Ghostty focus fix |
| Markdown viewer | `.config/glow/glow.yml` | glow |
| Node.js | `.zshenv` (Volta) | バージョン管理は Volta |

## インストールされるもの

**Homebrew formulae:** autossh, clang-format, cmake, colima, coreutils, docker, docker-compose, gh, git, glow, gnupg, go, im-select, ipmitool, jq, krew, kubernetes-cli, mdcat, mosh, nkf, openssl, pandoc, python@3.14, ripgrep, telnet, tmux, tmux-xpanes, uv, wget

**Homebrew casks:** codex, font-hackgen-nerd, font-plemol-jp-nf, font-ricty-diminished, font-udev-gothic-nf, ghostty, hammerspoon, iterm2, karabiner-elements, tailscale-app, zoom

## 機密・環境固有の設定

リポジトリには含めない。`~/.zshrc.local` に記述すると `.zshrc` から自動で読み込まれる。

```sh
# ~/.zshrc.local の例
export GITHUB_TOKEN=...
export KUBECONFIG="$HOME/.kube/config"
export GOOGLE_CLOUD_PROJECT=my-project
export PATH="/opt/homebrew/opt/arm-gcc-bin@8/bin:$PATH"
```

## フォント

Ghostty の設定で `UDEV Gothic 35NFLG` を使用。[UDEV Gothic](https://github.com/yuru7/udev-gothic) から手動でインストールする。

## 検証

クリーンなテストユーザーで動作確認する場合:

```sh
bash ~/dotfiles/check_setup.sh
```

結果を確認し、FAIL 項目があれば該当箇所を調査する。
