#!/bin/bash
### variables
function curDir () { # resolve currentDirectory even if symlink
    while [ -h "${BASH_SOURCE[0]}" ]; do # resolve $source until the file is no longer a symlink
        currentDirectory="$( cd -P "$( dirname "$source" )" && pwd )"
        source="$(readlink "$source")"
        [[ $source != /* ]] && source="$currentDirectory/$source" # if $source was a relative symlink, we need to resolve it relative to the path where the symlink file was located
    done
    echo "$( cd -P "$( dirname "$source" )" && pwd )"
}
CD="`curDir`"
HOME="`echo ~`"

### imports
source $CD/scripts/os.sh

### main
echo "Backing up of profiles..."
# .bashrc
if isUbuntu ; then
    if [ -f "$HOME/.bashrc" ]; then
        echo "> backing up old file: .bashrc"
        mv $HOME/.bashrc $HOME/.bashrc.file.bak
    fi
    if [ -L "$HOME/.bashrc" ]; then
        echo "> backing up old symlink: .bashrc"
     mv $HOME/.bashrc $HOME/.bashrc.symlink.bak
    fi
fi

# .bash_profile
if [ -f "$HOME/.bash_profile" ]; then
    echo "> backing up old file: .bash_profile"
    mv $HOME/.bash_profile $HOME/.bash_profile.file.bak
fi
if [ -L "$HOME/.bash_profile" ]; then
    echo "> backing up old symlink: .bash_profile"
    mv $HOME/.bash_profile $HOME/.bash_profile.symlink.bak
fi

# .bash_aliases
if [ -f "$HOME/.bash_aliases" ]; then
    echo "> backing up old file: .bash_aliases"
    mv $HOME/.bash_profile $HOME/.bash_aliases.file.bak
fi
if [ -L "$HOME/.bash_aliases" ]; then
    echo "> backing up old symlink: .bash_aliases"
    mv $HOME/.bash_profile $HOME/.bash_aliases.symlink.bak
fi
echo "Backing up of profiles... done"

# creating symlinks
printf "\nCreating symlinks to '$CD' profile files...\n"
if isUbuntu ; then
    echo "> symlink: .bashrc"
    ln -s $CD/.bashrc ~/.bashrc
fi

echo "> symlink: .bash_profile"
ln -s $CD/.bash_profile ~/.bash_profile

echo "> symlink: .bash_aliases"
ln -s $CD/.bash_aliases ~/.bash_aliases

echo "Creating symlinks to '$CD' profile files... done"

