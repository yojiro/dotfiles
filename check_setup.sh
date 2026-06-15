#!/bin/bash
# dotfiles セットアップ検証スクリプト
# クリーンなテストユーザー環境で dotfiles.sh initialize + deploy 後に実行する
# 結果を Claude に貼り付けてレビューしてもらう

PASS=0; FAIL=0

check() {
  local desc="$1"; local cmd="$2"
  if eval "$cmd" &>/dev/null; then
    echo "PASS: $desc"; ((PASS++))
  else
    echo "FAIL: $desc"; ((FAIL++))
  fi
}

echo "=== Symlinks ==="
check ".zshrc symlink"         "[ -L ~/.zshrc ] && [ -f ~/.zshrc ]"
check ".zprofile symlink"      "[ -L ~/.zprofile ]"
check ".zshenv symlink"        "[ -L ~/.zshenv ]"
check ".tmux.conf symlink"     "[ -L ~/.tmux.conf ]"
check ".gitconfig symlink"     "[ -L ~/.gitconfig ]"
check ".gitignore_global"      "[ -L ~/.gitignore_global ]"
check ".config/ghostty linked" "[ -L ~/.config/ghostty ]"
check ".config/gh linked"      "[ -L ~/.config/gh ]"
check ".config/glow linked"    "[ -L ~/.config/glow ]"
check ".config/karabiner linked" "[ -L ~/.config/karabiner ]"
check ".hammerspoon linked"    "[ -L ~/.hammerspoon ]"

echo ""
echo "=== Homebrew formulae ==="
check "brew installed"   "command -v brew"
check "git (brew)"       "brew list git"
check "uv installed"     "command -v uv"
check "ripgrep installed" "command -v rg"
check "glow installed"   "command -v glow"
check "im-select installed" "command -v im-select"
check "tmux installed"   "command -v tmux"

echo ""
echo "=== Homebrew casks ==="
check "ghostty cask"          "brew list --cask ghostty"
check "hammerspoon cask"      "brew list --cask hammerspoon"
check "karabiner cask"        "brew list --cask karabiner-elements"

echo ""
echo "=== Extras ==="
check "volta installed"            "command -v volta"
check "claude installed"           "command -v claude"
check "github-mcp-server installed" "command -v github-mcp-server"
check "gemini-cli installed"       "command -v gemini"
check "codex (npm) installed"      "npm list -g @openai/codex 2>/dev/null | grep -q codex"
check "cccost installed"           "command -v cccost"
check "ccusage installed"          "command -v ccusage"

echo ""
echo "=== Shell ==="
check "zsh git prompt available" "zsh -ic 'type __git_ps1' 2>/dev/null"

echo ""
echo "=============================="
echo "Result: ${PASS} passed, ${FAIL} failed"
echo "=============================="
