#!/bin/bash
function curDir () { # resolve currentDirectory even if symlink
    while [ -h "${BASH_SOURCE[0]}" ]; do # resolve $source until the file is no longer a symlink
        currentDirectory="$( cd -P "$( dirname "$source" )" && pwd )"
        source="$(readlink "$source")"
        [[ $source != /* ]] && source="$currentDirectory/$source" # if $source was a relative symlink, we need to resolve it relative to the path where the symlink file was located
    done
    echo "$( cd -P "$( dirname "$source" )" && pwd )"
}

function 1dirUp () {
    echo "$1" | rev | cut -d'/' -f2- | rev
}

function 2dirUp () {
    OneDirUp=`echo "$1" | rev | cut -d'/' -f2- | rev`
    TwoDirUp=`echo "$OneDirUp" | rev | cut -d'/' -f2- | rev`
    echo "$TwoDirUp"
}