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

while getopts :fh opt; do
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

link_files() {
  for f in .??*
  do
    [[ ${f} = ".git" ]]       && continue
    [[ ${f} = ".gitignore" ]] && continue
    [[ ${f} = ".config" ]]    && continue
    [ -n "${OVERWRITE}" -a -e ${HOME}/${f} ] && rm -f ${HOME}/${f}
    if [ ! -e ${HOME}/${f} ]; then
      ln -snfv ${DOT_DIRECTORY}/${f} ${HOME}/${f}
    fi
  done

  link_config

  echo $(tput setaf 2)Deploy dotfiles complete!. ✔︎$(tput sgr0)
}

link_config() {
  local config_src="${DOT_DIRECTORY}/.config"
  local config_dst="${HOME}/.config"
  mkdir -p "${config_dst}"
  for d in "${config_src}"/*/
  do
    local name=$(basename "${d}")
    [ -n "${OVERWRITE}" -a -e "${config_dst}/${name}" ] && rm -rf "${config_dst}/${name}"
    if [ ! -e "${config_dst}/${name}" ]; then
      ln -snfv "${config_src}/${name}" "${config_dst}/${name}"
    fi
  done
}

initialize() {
  run_brew

  [ ! -d ${HOME}/.tmux/plugins/tpm ] && git clone https://github.com/tmux-plugins/tpm ${HOME}/.tmux/plugins/tpm

  echo "$(tput setaf 2)Initialize complete!. ✔︎$(tput sgr0)"
}


command=$1
[ $# -gt 0 ] && shift

case ${command} in
  deploy)
    link_files
    ;;
  init*)
    initialize
    ;;
  *)
    echo "unknow command: ${command}"
    usage
    ;;
esac

exit 0
