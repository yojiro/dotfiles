export XDG_CONFIG_HOME=$HOME/.config
export XDG_CACHE_HOME=$HOME/.cache
export XDG_DATA_HOME=$HOME/.local/share
export GOPATH=$HOME/Work/golang

export PATH=/usr/local/bin:/usr/local/sbin:$PATH 
#export PATH=/usr/local/texlive/2017/bin/x86_64-darwin:$PATH 
export PATH=$PATH:/usr/local/opt/go/libexec/bin
export PATH=$GOPATH/bin:$PATH

export PYENV_ROOT="${HOME}/.pyenv"
export PATH="${PYENV_ROOT}/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"
#eval "$(rbenv init -)"


# comletion setup
[[ -r "/usr/local/etc/profile.d/bash_completion.sh" ]] && . "/usr/local/etc/profile.d/bash_completion.sh"
source ~/.git-completion.bash

# for Google Cloud SDK
source '/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.bash.inc'
source '/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.bash.inc'

# aliases
#alias emacs=/Applications/Emacs.app/Contents/MacOS/Emacs
#alias emacsnw='env TERM="xterm-256color" emacs'
alias ipmi='ipmitool -I lanplus'
#source ~/.bash_profile_secret
alias giste='LANG=UTF-8 GITHUB_URL=https://github.pfidev.jp/ gist -c'


test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"
alias mn2sshuttle='sshuttle -l 127.0.0.1:13000 -v -r jm00z0cm00-office 10.192.0.0/16'

# Setup ssh-agent
if [ -f ~/.ssh-agent ]; then
    . ~/.ssh-agent
fi
if [ -z "$SSH_AGENT_PID" ] || ! kill -0 $SSH_AGENT_PID; then
    ssh-agent > ~/.ssh-agent
    . ~/.ssh-agent
fi
ssh-add -l >& /dev/null || ssh-add

export PATH="$HOME/.poetry/bin:$PATH"
export JCNAME='yuo'
export PFKUBE_MNJG2_DEFAULT_DOCKER_CRED_NAME=pfkube-harbor-cred  # This is used when --target-cluster=mnjg2

alias kubectl='pf kubectl'
alias pfkube='pf pfkube'
alias pftaskqueue='pf pftaskqueue'
alias git-ghost='pf git-ghost'
alias pfbuild='pf pfbuild'
alias hdfs='pf hdfs'

source ~/.bashrc
