#!/usr/bin/env bash
BASEDIR=$(dirname $0)
cd $BASEDIR || exit

ln -s ${PWD}/bashrc ~/.bashrc && echo 'Installed ~/.bashrc'
ln -s ${PWD}/bash_aliases ~/.bash_aliases && echo 'Installed ~/.bash_aliases'
ln -s ${PWD}/vimrc ~/.vimrc && echo 'Installed ~/.vimrc'
ln -s ${PWD}/tridactylrc ~/.config/tridactyl/tridactylrc && echo 'Installed ~/.config/tridactyl/tridactylrc'

# Vim
cp -i ${PWD}/vim/syntax/git.vim ~/.vim/syntax/git.vim && echo 'Copied/overwritten ~/.vim/syntax/git.vim'
