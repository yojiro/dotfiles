# Claude Code 内では極力軽くする
if [[ -n "$CLAUDECODE" ]]; then
  export PATH="/opt/homebrew/bin:/opt/homebrew/sbin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"
  export PATH="$HOME/.local/bin:$HOME/.bun/bin:$HOME/.poetry/bin:$PATH"
  export PIPENV_VENV_IN_PROJECT=1
  return
fi

eval "$(/opt/homebrew/bin/brew shellenv)"
autoload -Uz compinit && compinit -C

export XDG_CONFIG_HOME=$HOME/.config
export XDG_CACHE_HOME=$HOME/.cache
export XDG_DATA_HOME=$HOME/.local/share

export GOPATH=$HOME/Work/golang
export PATH=$GOPATH/bin:$PATH
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.poetry/bin:$PATH"
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"

export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

export DOCKER_HOST="unix://${HOME}/.colima/default/docker.sock"
export PIPENV_VENV_IN_PROJECT=1

if [[ -o interactive ]]; then
  zstyle ':completion:*:*:git:*' script /Applications/Xcode.app/Contents/Developer/usr/share/git-core/git-completion.zsh
  source /Applications/Xcode.app/Contents/Developer/usr/share/git-core/git-prompt.sh
  bindkey -e

  # Ghostty の場合のみ Focus Reporting を制御する
  # iTerm2 では iTerm2 側のネイティブ機能に任せるため printf しない
  # $TERM_PROGRAM は tmux 内で "tmux" に上書きされるため GHOSTTY_BIN_DIR で検出する
  if [[ -n "$GHOSTTY_BIN_DIR" ]]; then
    _focus_on()  { printf "\e[?1004h"; }
    _focus_off() { printf "\e[?1004l"; }

    if [[ -n "$TMUX" ]]; then
      _focus_on()  { printf "\ePtmux;\e\e[?1004h\e\\"; }
      _focus_off() { printf "\ePtmux;\e\e[?1004l\e\\"; }
    fi

    autoload -Uz add-zsh-hook
    add-zsh-hook precmd  _focus_on
    add-zsh-hook preexec _focus_off
    add-zsh-hook zshexit _focus_off
  fi

  if command -v im-select > /dev/null 2>&1; then
    _reset_ime_on_focus() {
      /opt/homebrew/bin/im-select com.apple.keylayout.ABC
      [[ -n "$widgets" ]] && zle .reset-prompt
    }
    zle -N focus-in _reset_ime_on_focus
    bindkey '^[[I' focus-in
  fi

  precmd() {
    __git_ps1 %m '%# ' ' (%s)'
  }
fi

if command -v pyenv > /dev/null 2>&1; then
  eval "$(pyenv init -)"
fi

alias ipmi='ipmitool -I lanplus'

[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"

source ~/.zshrc.local 2>/dev/null
