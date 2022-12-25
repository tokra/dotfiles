#!/bin/bash

# resolve currentDirectory even if symlink
source="${BASH_SOURCE[0]}"
while [ -h "$source" ]; do # resolve $source until the file is no longer a symlink
  currentDirectory="$( cd -P "$( dirname "$source" )" && pwd )"
  source="$(readlink "$source")"
  [[ $source != /* ]] && source="$currentDirectory/$source" # if $source was a relative symlink, we need to resolve it relative to the path where the symlink file was located
done
my_dir="$( cd -P "$( dirname "$source" )" && pwd )"

### imports
source $my_dir/os.sh
source $my_dir/homebrewTools.sh

### main
# Mac homebrew cask : Applications
if isMacOs ; then
  ########################## Development tools
  # Android SDK
  brewCaskInstall 'android-sdk'
  # Android platform tools
  brewCaskInstall 'android-platform-tools'
  # Docker toolbox
  brewCaskInstall 'docker-toolbox'
  # Java 8
  #brewCaskInstall 'java'
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
  #brewCaskInstall 'virtualbox'
  # IntelliJ IDEA Community Edition
  #brewCaskInstall 'intellij-idea-ce'
  # https://wkhtmltopdf.org/
  brewCaskInstall 'wkhtmltopdf'
  # Postman
  brewCaskInstall 'postman'
  # Arduino IDE
  brewCaskInstall 'arduino'
  # MongoDB 
  #brewCaskInstall 'mongodb'
  # MongoDB Compass
  brewCaskInstall 'mongodb-compass'
  # PhantomJS
  #brewCaskInstall 'phantomjs'
  # Andry IP Scanner
  brewCaskInstall 'angry-ip-scanner'
  # eclipse-ide
  #brewCaskInstall 'eclipse-ide'
  # eclipse-java
  #brewCaskInstall 'eclipse-java'
  # eclipse-jee
  #brewCaskInstall 'eclipse-jee'
  # Expo xde
  #brewCaskInstall 'expo-xde'

  ########################## System utils
  # App Zapper
  brewCaskInstall 'appzapper'
  # better touch tool
  brewCaskInstall 'bettertouchtool'
  # gfx card status
  brewCaskInstall 'gfxcardstatus'
  # smc fan control
  #brewCaskInstall 'smcfancontrol'
  # Tuxera NTFS
  brewCaskInstall 'tuxera-ntfs'
  
  ########################## Tools for daily use
  # Google Chrome
  brewCaskInstall 'google-chrome'
  # Mozilla Firefox
  #brewCaskInstall 'firefox'
  # Brave browser
  brewCaskInstall 'brave-browser'
  # Slack
  brewCaskInstall 'slack'
  # Skitch
  brewCaskInstall 'skitch'
  # Team Viewer
  #brewCaskInstall 'teamviewer'
  # XN View MP
  brewCaskInstall 'xnviewmp'
  # Zoom.us
  brewCaskInstall 'zoom'
  # Skype
  #brewCaskInstall 'skype'
  # Authy
  brewCaskInstall 'authy'
  # 1password
  brewCaskInstall '1password'
  # Adobe Creative Cloud
  brewCaskInstall 'adobe-creative-cloud'
  # Turbo Boost Switcher
  brewCaskInstall 'turbo-boost-switcher'
  
  ########################## Tools for fun & pleasure
  # Spotify
  brewCaskInstall 'spotify'
  # Djay pro
  #brewCaskInstall 'djay-pro'
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
  # Telegram
  brewCaskInstall 'telegram'
  # VLC Media Player
  brewCaskInstall 'vlc'
  ## CANNOT INSTALL: Gopro Studio
  ## brewCaskInstall 'gopro-studio'
  # HandBrake
  brewCaskInstall 'handbrake'
  # cakebrew
  brewCaskInstall 'cakebrew'
  # The Unarchiver
  brewCaskInstall 'the-unarchiver'
  # Ledger Live
  brewCaskInstall 'ledger-live'
  
  ########################## Tools for use with NAS
  # Trasmission Remote Gui
  brewCaskInstall 'transmission-remote-gui'
  ## CANNOT INSTALL: Plex Home Theater
  ## brewCaskInstall 'plex-home-theater'
  # Deluge (fails to open)
  # brewCaskInstall 'deluge'
fi
