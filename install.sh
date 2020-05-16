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
cp -iu ${PWD}/vim/syntax/git.vim ~/.vim/syntax/git.vim

# .vim/plugin {{{2
########################################
cp -iu ${PWD}/vim/plugin/DQColorscheme.vim ~/.vim/plugin/DQColorscheme
cp -iu ${PWD}/vim/plugin/DQFoldText.vim ~/.vim/plugin/DQFoldText.vim
cp -iu ${PWD}/vim/plugin/DQNote.vim ~/.vim/plugin/DQNote.vim
cp -iu ${PWD}/vim/plugin/DQNYank.vim ~/.vim/plugin/DQNYank.vim
cp -iu ${PWD}/vim/plugin/DQToggleConceal.vim ~/.vim/plugin/DQToggleConceal.vim
cp -iu ${PWD}/vim/plugin/DQTreeDiagram.vim ~/.vim/plugin/DQTreeDiagram.vim
cp -iu ${PWD}/vim/plugin/DQVim.vim ~/.vim/plugin/DQVim.vim

# tridactylrc {{{1
##############################################################################
ln -s ${PWD}/tridactylrc ~/.config/tridactyl/tridactylrc && echo 'Installed ~/.config/tridactyl/tridactylrc'
#}}}1
##############################################################################
# vi: fdm=marker
