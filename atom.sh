#!/bin/sh

has() {
  type "$1" > /dev/null 2>&1
}

source ./lib/atom

echo "atom"
[ -d ${HOME}/.atom ] && run_atom
