export XDG_CONFIG_HOME=$HOME/.config
export XDG_CACHE_HOME=$HOME/.cache
export XDG_DATA_HOME=$HOME/.local/share

export PATH=/usr/local/bin:/usr/local/sbin:$PATH 
export PATH=/usr/local/texlive/2016/bin/x86_64-darwin:$PATH 

export PYENV_ROOT="${HOME}/.pyenv"
export PATH="${PYENV_ROOT}/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"
eval "$(rbenv init -)"

# comletion setup
if [ -f $(brew --prefix)/etc/bash_completion ]; then
	    . $(brew --prefix)/etc/bash_completion
fi
source ~/.git-completion.bash

# for Google Cloud SDK
source '/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.bash.inc'
source '/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.bash.inc'

# aliases
alias emacs=/Applications/Emacs.app/Contents/MacOS/Emacs
alias emacsnw='env TERM="xterm-256color" emacs'
source ~/.bash_profile_secret

