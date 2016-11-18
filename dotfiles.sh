#!/bin/bash
# original: https://github.com/okamos/dotfiles.git
set -e
DOT_DIRECTORY="${HOME}/dotfiles"
DOT_TARBALL="https://github.com/yojiro/dotfiles/tarball/master"
REMOTE_URL="git@github.com:yojiro/dotfiles.git"

has() {
  type "$1" > /dev/null 2>&1
}

usage() {
  name=`basename $0`
  cat <<EOF
Usage:
  $name [arguments] [command]

Commands:
  deploy
  initialize

Arguments:
  -f $(tput setaf 1)** warning **$(tput sgr0) Overwrite dotfiles.
  -h Print help (this message)
EOF
  exit 1
}

while getopts :f:h opt; do
  case ${opt} in
    f)
      OVERWRITE=true
      ;;
    h)
      usage
      ;;
  esac
done
shift $((OPTIND - 1))

# Working only OS X.
case ${OSTYPE} in
  darwin*)
    ;;
  *)
    echo $(tput setaf 1)Working only OS X!!$(tput sgr0)
    exit 1
    ;;
esac

# If missing, download and extract the dotfiles repository
if [ ! -d ${DOT_DIRECTORY} ]; then
  echo "Downloading dotfiles..."
  mkdir ${DOT_DIRECTORY}

  if has "git"; then
    git clone --recursive "${REMOTE_URL}" "${DOT_DIRECTORY}"
  else
    curl -fsSLo ${HOME}/dotfiles.tar.gz ${DOT_TARBALL}
    tar -zxf ${HOME}/dotfiles.tar.gz --strip-components 1 -C ${DOT_DIRECTORY}
    rm -f ${HOME}/dotfiles.tar.gz
  fi

  echo $(tput setaf 2)Download dotfiles complete!. ✔︎$(tput sgr0)
fi

cd ${DOT_DIRECTORY}
source ./lib/brew
source ./lib/tex

link_files() {
  for f in .??*
  do
    # Force remove the vim directory if it's already there
    [ -n "${OVERWRITE}" -a -e ${HOME}/${f} ] && rm -f ${HOME}/${f}
    if [ ! -e ${HOME}/${f} ]; then
      # If you have ignore files, add file/directory name here
      [[ ${f} = ".git" ]] && continue
      [[ ${f} = ".gitignore" ]] && continue
      ln -snfv ${DOT_DIRECTORY}/${f} ${HOME}/${f}
    fi
  done

  echo $(tput setaf 2)Deploy dotfiles complete!. ✔︎$(tput sgr0)
}

initialize() {
  run_brew
  run_tex

  [ ! -d ${HOME}/.tmux/plugins/tpm ] && git clone https://github.com/tmux-plugins/tpm ${HOME}/.tmux/plugins/tpm

  if has "pyenv"; then
    latest=`pyenv install --list | grep -v - | grep -oe '\d\.\d\.\d$' | tail -n 1`
    current=`pyenv versions | grep -oe '\d\.\d\{1,\}\.\d\{1,\}\([ ]\|$\)' | tail -n 1 | tr -d "[:space:]"`
    if [ ${current:-x} != ${latest} ]; then
      PYTHON_CONFIGURE_OPTS="--enable-framework"
      pyenv install ${latest}
      pyenv global ${latest}
      pyenv virtualenv -f ${latest} neovim3
      pyenv activate neovim3
      pip install neovim
    fi
  fi

  echo "$(tput setaf 2)Initialize complete!. ✔︎$(tput sgr0)"
}

command=$1
[ $# -gt 0 ] && shift

case $command in
  deploy)
    link_files
    ;;
  init*)
    initialize
    ;;
  *)
    usage
    ;;
esac

exit 0
