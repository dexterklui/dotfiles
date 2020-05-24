#!/usr/bin/env bash
##############################################################################
BASEDIR=$(dirname $0)
cd $BASEDIR || exit

# bash {{{1
##############################################################################
# Visual select and use 'Tabularize /\%(Installed\)\@<! \zs\ze\~\|&&'
ln -s ${PWD}/bashrc        ~/.bashrc       && echo 'Installed ~/.bashrc'
ln -s ${PWD}/bash_aliases  ~/.bash_aliases && echo 'Installed ~/.bash_aliases'

# Vim {{{1
##############################################################################
# .vimrc {{{2
########################################
ln -s ${PWD}/vimrc ~/.vimrc && echo 'Installed ~/.vimrc'

# .vim/syntax {{{2
########################################
cp -iu ${PWD}/vim/syntax/git.vim ~/.vim/syntax/git.vim
cp -iu ${PWD}/vim/syntax/dqn.vim ~/.vim/syntax/dqn.vim
cp -iu ${PWD}/vim/syntax/dqn0.vim ~/.vim/syntax/dqn0.vim

# .vim/plugin {{{2
########################################
cp -iu ${PWD}/vim/plugin/DQColorscheme.vim    ~/.vim/plugin/DQColorscheme.vim
cp -iu ${PWD}/vim/plugin/DQFoldText.vim       ~/.vim/plugin/DQFoldText.vim
cp -iu ${PWD}/vim/plugin/DQNote.vim           ~/.vim/plugin/DQNote.vim
cp -iu ${PWD}/vim/plugin/DQNYank.vim          ~/.vim/plugin/DQNYank.vim
cp -iu ${PWD}/vim/plugin/DQToggleConceal.vim  ~/.vim/plugin/DQToggleConceal.vim
cp -iu ${PWD}/vim/plugin/DQTreeDiagram.vim    ~/.vim/plugin/DQTreeDiagram.vim
cp -iu ${PWD}/vim/plugin/DQVim.vim            ~/.vim/plugin/DQVim.vim

# .vim/ftplugin {{{2
########################################
cp -iu ${PWD}/vim/ftplugin/dqn.vim ~/.vim/ftplugin/dqn.vim

# .vim/colors {{{2
########################################
cp -iu ${PWD}/vim/colors/dqsolarized.vim ~/.vim/colors/dqsolarized.vim

# Git {{{1
##############################################################################
ln -s ${PWD}/gitconfig ~/.gitconfig && echo 'Installed ~/.gitconfig'
ln -s ${PWD}/gitignore ~/.gitignore && echo 'Installed ~/.gitignore'

# tridactylrc {{{1
##############################################################################
ln -s ${PWD}/tridactylrc ~/.config/tridactyl/tridactylrc && echo 'Installed ~/.config/tridactyl/tridactylrc'
#}}}1
##############################################################################
# vi: fdm=marker
