#!/bin/bash
brewList=`brew list`
brewCaskList=`brew cask list`
function brewContains () {
  if [[ $brewList == *"$1"* ]]; then
    echo "Formula: $1 exists..."
    return 0;
  else
    echo "Formula: $1 does not exist !!!"
    return 1;
  fi
}
function brewCaskContains () {
  if [[ $brewCaskList == *"$1"* ]]; then
    echo "Cask: $1 exists..."
    return 0;
  else
    echo "Cask: $1 does not exist !!!"
    return 1;
  fi
}
brewContains 'android-sdk'
brewContains 'ant'
brewContains 'gradle'
brewContains 'maven'
brewContains 'node'
brewContains 'python'
brewContains 'python3'
brewContains 'rsync'
brewContains 'wget'
brewContains 'docker'
brewContains 'docker-machine'

brewCaskContains 'google-chrome'

brewContains 'TEST_BREW'
brewCaskContains 'TEST_CASK'
