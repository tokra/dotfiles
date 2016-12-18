#!/bin/bash

# resolve currentDirectory even if symlink
source="${BASH_SOURCE[0]}"
while [ -h "$source" ]; do # resolve $source until the file is no longer a symlink
  currentDirectory="$( cd -P "$( dirname "$source" )" && pwd )"
  source="$(readlink "$source")"
  [[ $source != /* ]] && source="$currentDirectory/$source" # if $source was a relative symlink, we need to resolve it relative to the path where the symlink file was located
done
my_dir="$( cd -P "$( dirname "$source" )" && pwd )"

source $my_dir/brewtools.sh
source $my_dir/common.sh
source $my_dir/os.sh
#####################################################################
# Other development tools: node.js, ruby, sass, compass

# node.js, npm
if notExistCommand 'node' ; then
  if isMacOs ; then
    brewInstall 'node'
  elif isUbuntu ; then
    printf 'Installation:\n> APT installing node.js (ubuntu)'
    curl -sL https://deb.nodesource.com/setup_7.x | sudo -E bash -
    sudo apt-get install -y nodejs
    sudo apt-get install -y build-essential
  fi
fi

# ruby : Ubuntu (MacOs should have it preinstalled)
if isUbuntu ; then
  if notExistCommand 'ruby' ; then
    printf 'Installation:\n> APT installing ruby (ubuntu)'
    sudo apt-get install -y ruby-full
  fi
fi

# gem install: sass
if notExistCommand 'sass' ; then
  printf 'Installation:\n> GEM installing sass'
  sudo gem install sass
fi

# gem install: compass
if notExistCommand 'compass' ; then
  printf 'Installation:\n> GEM installing compass'
  sudo gem install compass
fi

# export variables compass and npm for IDE's'
export COMPASS=`which compass`
export NPM=`which npm`