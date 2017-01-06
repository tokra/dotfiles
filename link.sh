echo "Creating profiles symlinks..."
if [ -f ~/.bashrc ]; then
    mv ~/.bashrc ~/.bashrc.bak
fi
if [ -f ~/.bash_profile ]; then
    mv ~/.bash_profile ~/.bash_profile.bak
fi
ln -s ~/dotfiles/.bashrc ~/.bashrc
ln -s ~/dotfiles/.bash_profile ~/.bash_profile
echo "Linked .bashrc and .bash_profile... done"