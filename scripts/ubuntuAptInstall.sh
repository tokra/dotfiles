#!/bin/bash
### variables & functions
function curDir () { # resolve currentDirectory even if symlink
    while [ -h "${BASH_SOURCE[0]}" ]; do # resolve $source until the file is no longer a symlink
        currentDirectory="$( cd -P "$( dirname "$source" )" && pwd )"
        source="$(readlink "$source")"
        [[ $source != /* ]] && source="$currentDirectory/$source" # if $source was a relative symlink, we need to resolve it relative to the path where the symlink file was located
    done
    echo "$( cd -P "$( dirname "$source" )" && pwd )"
}
my_dir="`curDir`"

### imports
source $my_dir/common.sh
source $my_dir/os.sh
source $my_dir/ubuntuAptTools.sh

### main
if isUbuntu ; then
    # debconf-utils
    aptGetInstall 'debconf-utils'

    # mc 
    aptGetInstall 'mc'

    # mcedit
    aptGetInstall 'mcedit'
fi

