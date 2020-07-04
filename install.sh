#!/usr/bin/env bash
##############################################################################
BASEDIR=$(dirname $0)
cd $BASEDIR || exit 1

[ -z "$HOME" ] && exit 1
[ -z "$HOST_NAME" ] && HOST_NAME=$(cat /etc/hostname)
[ -z "$XDG_CONFIG_HOME" ] && XDG_CONFIG_HOME=$HOME/.config
[ -z "$XDG_DATA_HOME" ] && XDG_DATA_HOME=$HOME/.local/share
TMP_DOT_SCRIPT=/tmp/$(whoami)_dot_install.sh
touch $TMP_DOT_SCRIPT || exit 1

# bash {{{1
##############################################################################
# Visual select and use 'Tabularize /\%(Installed\)\@<! \zs\ze\~\|&&'
ln -sv ${PWD}/bashrc        ~/.bashrc
ln -sv ${PWD}/bash_aliases  ~/.bash_aliases
ln -sv ${PWD}/bash_env      ~/.bash_env

# okular {{{1
##############################################################################
mkdir $XDG_DATA_HOME/okular/shortcuts
ln -sv ${PWD}/okular/config/* $XDG_CONFIG_HOME/
ln -sv ${PWD}/okular/local/share/okular/shortcuts/* $XDG_DATA_HOME/okular/shortcuts/

# zsh {{{1
##############################################################################
if [[ -e $ZSH ]]; then
    ln -sv ${PWD}/zshrc     ~/.zshrc
    if [[ -e "$ZSH_CUSTOM" ]]; then
        ln -sv ${PWD}/zsh/themes/* -t $ZSH_CUSTOM/themes/
    fi
fi

# Vim {{{1
##############################################################################
if [[ $HOST_NAME == 'dq-x1c' ]]; then
    DSTDIR="$HOME/.vim"
elif [[ $HOST_NAME == 'dqarch' ]]; then
    DSTDIR="$HOME/.config/nvim"
    [ $XDG_CONFIG_HOME ] && DSTDIR=$XDG_CONFIG_HOME/nvim
else
    DSTDIR="$HOME/.config/nvim"
    [ $XDG_CONFIG_HOME ] && DSTDIR=$XDG_CONFIG_HOME/nvim
fi

# .vimrc {{{2
########################################
if [[ $HOST_NAME == 'dq-x1c' ]]; then
    ln -sv ${PWD}/vimrc $HOME/.vimrc
else
    ln -sv ${PWD}/vimrc $DSTDIR/init.vim
fi

# other config files {{{2
########################################
# Create necessary dirs
find vim -type f -name '*.vim' | sed 's|/[^/]*$||' | sort | uniq | sed -E "s|^vim/(.*)$|$DSTDIR/\1|" | xargs mkdir -p
# Make a script to make symbolic link for each vim scripts
find vim -type f -name '*.vim' | sed -E "s|^(.*)$|\1 \1|" | sed -E "s|^([^ ]*) vim/(.*)$|ln -sv $(pwd)/\1 $DSTDIR/\2|" > $TMP_DOT_SCRIPT
sh $TMP_DOT_SCRIPT

# tmux {{{1
##############################################################################
ln -sv ${PWD}/tmux.conf ~/.tmux.conf

# Git {{{1
##############################################################################
ln -sv ${PWD}/gitconfig ~/.gitconfig
ln -sv ${PWD}/gitignore ~/.gitignore

# tridactylrc {{{1
##############################################################################
ln -sv ${PWD}/tridactylrc ~/.config/tridactyl/tridactylrc
#}}}1
# alacritty {{{1
##############################################################################
ln -sv ${PWD}/alacritty/alacritty.yml ~/.config/alacritty/alacritty.yml

# kitty {{{1
##############################################################################
mkdir -p $XDG_CONFIG_HOME/kitty
ln -sv ${PWD}/kitty/kitty.conf $XDG_CONFIG_HOME/kitty/

# others {{{1
##############################################################################
DSTDIR=$HOME/.config
[ -n $XDG_CONFIG_HOME ] && DSTDIR=$XDG_CONFIG_HOME
ln -sv ${PWD}/dircolors $DSTDIR/dircolors
#}}}1
##############################################################################
rm $TMP_DOT_SCRIPT
# vi: fdm=marker sw=4 et
