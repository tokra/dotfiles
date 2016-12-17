#!/bin/bash

#####################################################################
# Functions
function cmdExists () {
    type "$1" &> /dev/null ;
}

function formulaInstalled () {
  brew ls --versions "$1" > /dev/null
}

function brewInstall () {
  if ! formulaInstalled "$1" ; then
    printf 'Installation:\n> [macOs] BREW installing: %s\n' "$1"
    brew install android-sdk
  fi
}

function caskInstalled () {
  brew cask ls --versions sublime-text "$1" &> /dev/null
}

function caskInstall () {
  if ! caskInstalled "$1" ; then
    printf '\nInstallation:\n> [macOs] BREW CASK installing: %s\n' "$1"
    brew cask install "$1"
  fi
}

#####################################################################
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

#####################################################################
# Mac Homebrew
if [[ "$isMac" == true ]]; then
  if ! cmdExists brew ; then
    printf 'Installation:\n> [macOs] RUBY installing BREW'
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    brew update
    brewInstall 'brew-cask'
    brew tap caskroom/cask
    brew tap caskroom/versions
  fi
fi

#####################################################################
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
# Mac Homebrew apps
if [[ "$isMac" == true ]]; then
  # coreutils: greadlink etc.
  brewInstall 'coreutils'
  # Android SDK
  brewInstall 'android-sdk'
  # Docker
  brewInstall 'docker'
  brewInstall 'docker-machine'
fi 

#####################################################################
# Mac homebrew cask : Applications
if [[ "$isMac" == true ]]; then
  # Java 7
  caskInstall 'java7'
  # Java 8
  caskInstall 'java'
  # iTerm2
  caskInstall 'iterm2'
  # Sublime
  caskInstall 'sublime-text'
  # Visual Studio code
  caskInstall 'visual-studio-code'
   # Android Studio
  caskInstall 'android-studio'
  # Source Tree
  caskInstall 'sourcetree'
  # Virtual Box
  caskInstall 'virtualbox'
  # Mac ports
  caskInstall 'macports'
  # smc fan control
  caskInstall 'smcfancontrol'

  ############# 
  # Google Chrome
  caskInstall 'google-chrome'
  # Google Drive
  caskInstall 'google-drive'
  # Mozilla Firefox
  caskInstall 'firefox'
  # Filezilla
  caskInstall 'filezilla'
  # gfx card status
  caskInstall 'gfxcardstatus'
  # better touch tool
  caskInstall 'bettertouchtool'
  # App Zapper
  caskInstall 'appzapper'
  # Adobe Creative Cloud
  caskInstall 'adobe-creative-cloud'
  # Adobe Acrobat Reader
  caskInstall 'adobe-reader'
  # Slack
  caskInstall 'slack'
  # Skitch
  caskInstall 'skitch'
  # Team Viewer
  caskInstall 'teamviewer'
  # XN View MP
  caskInstall 'xnviewmp'
  # XtraFinder
  caskInstall 'xtrafinder'
  # Zoom.us 
  caskInstall 'zoomus'
  # Real VNC
  caskInstall 'real-vnc'
  # Skype
  caskInstall 'skype'

  ############# FOR FUN
  # Spotify
  caskInstall 'spotify'
  # Djay pro 
  caskInstall 'djay-pro'
  # Kid3
  caskInstall 'kid3'
  # Messenger
  caskInstall 'messenger'
  # Steam
  caskInstall 'steam'
  # Trasmission Remote Gui
  caskInstall 'transmission-remote-gui'
  # Viber
  caskInstall 'viber'
  # Whats app
  caskInstall 'whatsapp'
  # VLC Media Player
  caskInstall 'vlc'
  # Gopro Studio
  caskInstall 'gopro-studio'
  # HandBrake
  caskInstall 'handbrake'
  # Vinoteka
  caskInstall 'vinoteka'
fi

#####################################################################
# Paths
export PATH=/usr/local/bin:$PATH

if [[ "$isMac" == true ]]; then
  export PATH=/Applications:$PATH

  ## SCM tool
  export PATH=/opt/jazz/scmtools/eclipse:$PATH

  # Android Home
  export ANDROID_HOME=`brew --prefix android-sdk`
  launchctl setenv ANDROID_HOME $ANDROID_HOME

  # MacPorts Installer addition on 2015-08-13_at_15:10:48: adding an appropriate PATH variable for use with MacPorts.
  export PATH="/opt/local/bin:/opt/local/sbin:$PATH"
  # Finished adapting your PATH environment variable for use with MacPorts.


  #THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
  export SDKMAN_DIR="/Users/tokra/.sdkman"
  [[ -s "/Users/tokra/.sdkman/bin/sdkman-init.sh" ]] && source "/Users/tokra/.sdkman/bin/sdkman-init.sh"
fi
