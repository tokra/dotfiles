#!/bin/bash
# brew additional functions
function brewContains () {
  if [[ $brewList == *"$1"* ]]; then
    #echo "Formula: $1 exists :-)"
    return 0;
  else
    #echo "Formula: $1 does not exist !!!"
    return 1;
  fi
}
function brewCaskContains () {
  if [[ $brewCaskList == *"$1"* ]]; then
    #echo "Cask: $1 exists..."
    return 0;
  else
    #echo "Cask: $1 does not exist !!!"
    return 1;
  fi
}
function brewInstall () {
  if ! brewContains "$1" ; then
    printf 'Installation:\n> [macOs] BREW installing: %s\n' "$1"
    brew install "$1"
  fi
}
function brewCaskInstall () {
  if ! brewCaskContains "$1" ; then
    printf '\nInstallation:\n> [macOs] BREW CASK installing: %s\n' "$1"
    brew cask install "$1"
  fi
}
