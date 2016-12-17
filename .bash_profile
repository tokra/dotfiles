#!/bin/bash
#######################
# Functions
#######################
function cmdExists () {
    type "$1" &> /dev/null ;
}

function brewPackageInstalled () {
  brew ls --versions "$1" > /dev/null
}

function brewPackageInstalled2 () {
  brew info "$1" >/dev/null 2>&1
}

function brewCaskInstalled () {
  brew cask info "$1" &> /dev/null
}

#######################
# OS detection
platform='unknown'
unamestr=`uname`
isUbuntu=false
isMac=false
if [[ "$unamestr" == 'Linux' ]]; then
  platform='linux'
  ubuntu_str=`cat /etc/os-release | grep ^NAME= | cut -f2 -d'"' | xargs`
  if [[ "$ubuntu_str" == 'Ubuntu' ]]; then
    isUbuntu=true
  fi
elif [[ "$unamestr" == 'Darwin' ]]; then
  platform='macos'
  isMac=true
elif [[ "$unamestr" == 'FreeBSD' ]]; then
  platform='freebsd'
fi

#######################
# Mac Homebrew
if [[ "$isMac" == true ]]; then
  if ! cmdExists brew ; then
    printf 'Installation:\n> RUBY installing of BREW (macos)'
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  fi
fi

#######################
# Git + Git aware prompt
if [[ ! -d ~/.bash/ ]]; then
  echo 'Installation of Git aware prompts:'
  mkdir ~/.bash
  cd ~/.bash
  if ! cmdExists git ; then
    if [[ "$isUbuntu" == true ]]; then
      printf 'Installation:\n> APT installing of GIT (ubuntu)'
      sudo apt-get install git
    elif [[ "$isMac" == true ]]; then
      printf 'Installation:\n> BREW installing of GIT (macos)'
      brew install git
    fi 
  fi
  if [[ ! -d ~/.bash/git-aware-prompt ]]; then
    printf 'Git:\n> Cloning git-aware-prompt...'
    git clone git://github.com/jimeh/git-aware-prompt.git
  fi
fi
export GITAWAREPROMPT=~/.bash/git-aware-prompt
source "${GITAWAREPROMPT}/main.sh"
export PS1="\[\033[36m\]\u\[\033[m\]@\[\033[32m\]\h:\[\033[33;1m\]\w\[\033[m\] \[$txtcyn\]\$git_branch\[$txtred\]\$git_dirty\[$txtrst\]\$ " 
export SUDO_PS1="\[$bakred\]\u@\h\[$txtrst\] \w\$ "
export CLICOLOR=1
export LSCOLORS=ExFxBxDxCxegedabagacad

#####################################################################
# Other development tools: node.js, ruby, sass, compass
if [[ "$isMac" == true ]]; then
  if ! cmdExists npm ; then
    printf 'Installation:\n> BREW installing node.js (macos)'
    brew install node
  fi
elif [[ "$isUbuntu" == true ]]; then
  if ! cmdExists ruby ; then
    printf 'Installation:\n> APT installing ruby (ubuntu)'
    sudo apt-get install -y ruby-full
  fi
  if ! cmdExists npm ; then
    printf 'Installation:\n> APT installing node.js (ubuntu)'
    curl -sL https://deb.nodesource.com/setup_7.x | sudo -E bash -
    sudo apt-get install -y nodejs
    sudo apt-get install -y build-essential
  fi
fi

# sass & compass
if ! cmdExists sass ; then
  printf 'Installation:\n> GEM installing sass'
  sudo gem install sass
fi
if ! cmdExists compass ; then
  printf 'Installation:\n> GEM installing compass'
  sudo gem install compass
fi
export COMPASS=`which compass`
export NPM=`which npm`

#####################################################################
# Aliases
if [[ "$isMac" == true ]]; then
  alias ls='ls -GFh'
  alias ll='ls -l'
  alias la='ls -la'
fi
if [[ "$isUbuntu" == true ]]; then
  alias ls='ls -GFh --color'
  alias ll='ls -l --color'
  alias la='ls -la --color'
fi
alias cd..='cd ..'
alias cs....='cd ../..'
alias cls='clear'
alias clr='clear'
if [[ "$isMac" == true ]]; then
  alias eclipse_sudo='sudo /opt/kcdev/Eclipse.app/Contents/MacOS/eclipse &'
  alias eclipse='/opt/kcdev/Eclipse.app/Contents/MacOS/eclipse &'
  alias sublime='/Applications/Sublime\ Text.app/Contents/MacOS/Sublime\ Text >> /dev/null 2>&1 &'
fi

#####################################################################
# Java
if [[ "$isMac" == true ]]; then
  export JAVA_HOME=$(/usr/libexec/java_home)
elif [[ "$isUbuntu" == true ]]; then
  if ! cmdExists java ; then
    printf 'Installation:\n> APT installing java (ubuntu)'
    sudo add-apt-repository ppa:webupd8team/java
    sudo apt-get update
    sudo apt-get install -y oracle-java8-installer
  fi 
fi

#####################################################################
# Android SDK
if [[ "$isMac" == true ]]; then
  if ! brewPackageInstalled android-sdk ; then
    printf 'Installation:\n> BREW installing android-sdk (macos)'
    brew install android-sdk
  fi
  export ANDROID_HOME=`brew --prefix android-sdk`
  launchctl setenv ANDROID_HOME $ANDROID_HOME
fi

# Mac brew cask : Applications
if [[ "$isMac" == true ]]; then
  # Sublime
  if ! brewCaskInstalled sublime-text ; then
    printf 'Installation:\n> BREW CASK installing: sublime-text (macos)'
    brew cask install sublime-text
  fi
  # Visual Studio code
  if ! brewCaskInstalled visual-studio-code ; then
    printf 'Installation:\n> BREW CASK installing: visual-studio-code (macos)'
    brew cask install visual-studio-code
  fi
  # Google chrome
  if ! brewCaskInstalled google-chrome ; then
    printf 'Installation:\n> BREW CASK installing: google-chrome (macos)'
    brew cask install google-chrome
  fi
fi
#######################
# Paths
export PATH=/usr/local/bin:$PATH

if [[ "$isMac" == true ]]; then
  export PATH=/Applications:$PATH

  ## SCM tool
  export PATH=/opt/jazz/scmtools/eclipse:$PATH

  # MacPorts Installer addition on 2015-08-13_at_15:10:48: adding an appropriate PATH variable for use with MacPorts.
  export PATH="/opt/local/bin:/opt/local/sbin:$PATH"
  # Finished adapting your PATH environment variable for use with MacPorts.


  #THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
  export SDKMAN_DIR="/Users/tokra/.sdkman"
  [[ -s "/Users/tokra/.sdkman/bin/sdkman-init.sh" ]] && source "/Users/tokra/.sdkman/bin/sdkman-init.sh"
fi
