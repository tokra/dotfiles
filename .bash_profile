#!/bin/bash
source scripts/common.sh

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

# Homebrew installation
if [[ "$isMac" == true ]]; then
  if ! cmdExists brew ; then
    printf 'Installation:\n> [macOs] RUBY installing BREW'
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  fi
fi

# Variables for brew to speed up functions bellow
brewList=''
brewCaskList=''
if [[ "$isMac" == true ]]; then
  brewList=`brew list`
  brewCaskList=`brew cask list`
fi

# link additional own homebrew functions
source scripts/brewtools.sh

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
# Mac Homebrew apps
if [[ "$isMac" == true ]]; then
  ########################## SDK's'
  # Android SDK
  brewInstall 'android-sdk'

  ########################## Build tools
  # Ant
  brewInstall 'ant'
  # Gradle
  brewInstall 'gradle'
  # Maven
  brewInstall 'maven'
  # Node.js
  brewInstall 'node'

  ########################## Daily use cli tools
  # Core utils: grealink etc.
  brewInstall 'coreutils'
  # Python
  brewInstall 'python'
  # Python3
  brewInstall 'python3'
  # Rsync
  brewInstall 'rsync'
  # Wget
  brewInstall 'wget'
fi 

#####################################################################
# Mac homebrew cask : Applications
if [[ "$isMac" == true ]]; then
  ########################## Development tools
  # Docker toolbox
  brewCaskInstall 'docker-toolbox'
  # Java 7
  brewCaskInstall 'java7'
  # Java 8
  brewCaskInstall 'java'
  # iTerm2
  brewCaskInstall 'iterm2'
  # Sublime
  brewCaskInstall 'sublime-text'
  # Visual Studio code
  brewCaskInstall 'visual-studio-code'
   # Android Studio
  brewCaskInstall 'android-studio'
  # Source Tree
  brewCaskInstall 'sourcetree'
  # Virtual Box
  brewCaskInstall 'virtualbox'

  ########################## System utils
  # App Zapper
  brewCaskInstall 'appzapper'
  # better touch tool
  brewCaskInstall 'bettertouchtool'
  # gfx card status
  brewCaskInstall 'gfxcardstatus'
  # Mac ports
  brewCaskInstall 'macports'
  # smc fan control
  brewCaskInstall 'smcfancontrol'
  # XtraFinder
  brewCaskInstall 'xtrafinder'

  ########################## Tools for daily use
  # Google Chrome
  brewCaskInstall 'google-chrome'
  # Google Drive
  brewCaskInstall 'google-drive'
  # Mozilla Firefox
  brewCaskInstall 'firefox'
  # Filezilla
  brewCaskInstall 'filezilla'
  # Adobe Creative Cloud
  brewCaskInstall 'adobe-creative-cloud'
  # Slack
  brewCaskInstall 'slack'
  # Skitch
  brewCaskInstall 'skitch'
  # Team Viewer
  brewCaskInstall 'teamviewer'
  # XN View MP
  brewCaskInstall 'xnviewmp'
  # Zoom.us 
  brewCaskInstall 'zoomus'
  # Real VNC
  brewCaskInstall 'real-vnc'
  # Skype
  brewCaskInstall 'skype'

  ########################## Tools for fun & pleasure
  # Spotify
  brewCaskInstall 'spotify'
  # Djay pro 
  brewCaskInstall 'djay-pro'
  # Kid3
  brewCaskInstall 'kid3'
  # Messenger
  brewCaskInstall 'messenger'
  # Steam
  brewCaskInstall 'steam'
  # Viber
  brewCaskInstall 'viber'
  # Whats app
  brewCaskInstall 'whatsapp'
  # VLC Media Player
  brewCaskInstall 'vlc'
  # Gopro Studio
  brewCaskInstall 'gopro-studio'
  # HandBrake
  brewCaskInstall 'handbrake'

  ########################## Tools for use with NAS
  # Trasmission Remote Gui
  brewCaskInstall 'transmission-remote-gui'
  # Plex Home Theater
  brewCaskInstall 'plex-home-theater'
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
