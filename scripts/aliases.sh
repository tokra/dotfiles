#####################################################################
# Aliases
if isMacOs ; then
  alias ls='ls -GFh'
  alias ll='ls -l'
  alias la='ls -la'
  alias eclipse_sudo='sudo /opt/kcdev/Eclipse.app/Contents/MacOS/eclipse &'
  alias eclipse='/opt/kcdev/Eclipse.app/Contents/MacOS/eclipse &'
  alias sublime='/Applications/Sublime\ Text.app/Contents/MacOS/Sublime\ Text >> /dev/null 2>&1 &'
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
