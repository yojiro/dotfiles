# The next line updates PATH for the Google Cloud SDK.
source '/Users/yuo/google-cloud-sdk/path.bash.inc'

# The next line enables bash completion for gcloud.
source '/Users/yuo/google-cloud-sdk/completion.bash.inc'


export XDG_CONFIG_HOME=$HOME/.config
export XDG_CACHE_HOME=$HOME/.cache
export XDG_DATA_HOME=$HOME/.local/share

export PATH=/usr/local/bin:/usr/local/sbin:$PATH 
export PATH=/usr/local/texlive/2016/bin/x86_64-darwin:$PATH 

export PYENV_ROOT="${HOME}/.pyenv"
export PATH="${PYENV_ROOT}/bin:$PATH"
eval "$(pyenv init -)"
eval "$(rbenv init -)"

# comletion setup
if [ -f $(brew --prefix)/etc/bash_completion ]; then
	    . $(brew --prefix)/etc/bash_completion
fi
source ~/.git-completion.bash

# aliases
alias coizmosd='ssh yuo@202.32.183.171 -p 10011'
alias mc5n0501='ssh yuo@202.32.183.171 -p 20022'
alias emacs=/Applications/Emacs.app/Contents/MacOS/Emacs
alias emacsnw='env TERM="xterm-256color" emacs'

