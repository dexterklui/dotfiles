#!/usr/bin/env bash
##############################################################################
BASEDIR=$(dirname $0)
cd $BASEDIR || exit

# bash {{{1
##############################################################################
ln -s ${PWD}/bashrc ~/.bashrc && echo 'Installed ~/.bashrc'
ln -s ${PWD}/bash_aliases ~/.bash_aliases && echo 'Installed ~/.bash_aliases'

# Vim {{{1
##############################################################################
# .vimrc {{{2
########################################
ln -s ${PWD}/vimrc ~/.vimrc && echo 'Installed ~/.vimrc'

# .vim/syntax {{{2
########################################
cp -i ${PWD}/vim/syntax/git.vim ~/.vim/syntax/git.vim && echo 'Copied/overwritten ~/.vim/syntax/git.vim'

# .vim/plugin {{{2
########################################
cp -i ${PWD}/vim/plugin/DQColorscheme.vim ~/.vim/plugin/DQColorscheme && echo 'Copied/overwritten ~/.vim/plugin/DQColorscheme.vim'
cp -i ${PWD}/vim/plugin/DQFoldText.vim ~/.vim/plugin/DQFoldText.vim && echo 'Copied/overwritten ~/.vim/plugin/DQFoldText.vim'
cp -i ${PWD}/vim/plugin/DQNote.vim ~/.vim/plugin/DQNote.vim && echo 'Copied/overwritten ~/.vim/plugin/DQNote.vim'
cp -i ${PWD}/vim/plugin/DQNYank.vim ~/.vim/plugin/DQNYank.vim && echo 'Copied/overwritten ~/.vim/plugin/DQNYank.vim'
cp -i ${PWD}/vim/plugin/DQToggleConceal.vim ~/.vim/plugin/DQToggleConceal.vim && echo 'Copied/overwritten ~/.vim/plugin/DQToggleConceal.vim'
cp -i ${PWD}/vim/plugin/DQTreeDiagram.vim ~/.vim/plugin/DQTreeDiagram.vim && echo 'Copied/overwritten ~/.vim/plugin/DQTreeDiagram.vim'
cp -i ${PWD}/vim/plugin/DQVim.vim ~/.vim/plugin/DQVim.vim && echo 'Copied/overwritten ~/.vim/plugin/DQVim.vim'

# tridactylrc {{{1
##############################################################################
ln -s ${PWD}/tridactylrc ~/.config/tridactyl/tridactylrc && echo 'Installed ~/.config/tridactyl/tridactylrc'
#}}}1
##############################################################################
# vi: fdm=marker
