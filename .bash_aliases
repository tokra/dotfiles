#!/bin/bash

### variables & functions
# resolve currentDirectory even if symlink
source="${BASH_SOURCE[0]}"
while [ -h "$source" ]; do # resolve $source until the file is no longer a symlink
  currentDirectory="$( cd -P "$( dirname "$source" )" && pwd )"
  source="$(readlink "$source")"
  [[ $source != /* ]] && source="$currentDirectory/$source" # if $source was a relative symlink, we need to resolve it relative to the path where the symlink file was located
done
workingDir="$( cd -P "$( dirname "$source" )" && pwd )"

### imports
source $workingDir/scripts/os.sh

#####################################################################
# Aliases
if isMacOs ; then
  alias ls='ls -GFh'
  alias ll='ls -l'
  alias la='ls -la'
  alias eclipse_sudo='sudo /opt/kcdev/Eclipse.app/Contents/MacOS/eclipse &'
  alias eclipse='/opt/kcdev/Eclipse.app/Contents/MacOS/eclipse &'
  #open app from /Applications
  alias sublime='open -a "Sublime Text"'
  alias vscode='open -a "Visual Studio Code"'
  alias sourcetree='open -a "SourceTree"'
  alias edit='open -e'
fi
if isUbuntu ; then
  alias ls='ls -GFh --color'
  alias ll='ls -l --color'
  alias la='ls -la --color'
fi

alias cd..='cd ..'
alias cs....='cd ../..'
alias cls='clear'
alias clr='clear'

# dev
alias gi='git'
alias gs='git status'
alias gc='git commit'
alias ga='git add'

# personal
alias unraid='ssh root@tower'
