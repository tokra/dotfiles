#!/bin/bash
# general stuff
function currentDirectory () { # resolve currentDirectory even if symlink
    while [ -h "${BASH_SOURCE[0]}" ]; do # resolve $source until the file is no longer a symlink
        currentDirectory="$( cd -P "$( dirname "$source" )" && pwd )"
        source="$(readlink "$source")"
        [[ $source != /* ]] && source="$currentDirectory/$source" # if $source was a relative symlink, we need to resolve it relative to the path where the symlink file was located
    done
    echo "$( cd -P "$( dirname "$source" )" && pwd )"
}
function directoryUp () {
    echo "$1" | rev | cut -d'/' -f2- | rev
}
SCRIPTS=`directoryUp $(currentDirectory)`

# imports
source $SCRIPTS/fileSystem.sh

# Tests
CD=`curDir`
DU=`1dirUp $(curDir)`
DDU=`2dirUp $(curDir)`

echo "CD        : $CD"
echo "CD..      : $DU"
echo "CD....    : $DDU"