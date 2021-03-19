#!/usr/bin/env bash

# Documentations {{{1
##############################################################################
# SYNTAX: install.sh [--force] [--all] [APP]...
# With --force the program remove existing destination files while making
# symbolic link.
# With --all install symbolic links for all applications.
# Without -all install symbolic links for only mentioned applications in
# [APP]...

# Preparation and setting up variables {{{1
##############################################################################
BASEDIR=$(dirname $0)
cd $BASEDIR || exit 1
[[ -z $HOME ]]            && exit 1
HOST_NAME=$(cat /proc/sys/kernel/hostname)
[[ -z $XDG_CONFIG_HOME ]] && XDG_CONFIG_HOME=$HOME/.config
[[ -z $XDG_DATA_HOME ]]   && XDG_DATA_HOME=$HOME/.local/share
TMP_DOT_SCRIPT=/tmp/$(whoami)_dot_install.sh
touch $TMP_DOT_SCRIPT || (echo "Can't create $TMP_DOT_SCRIPT! Abort." ; exit 1)

LINK_ARG='-sv'
CP_ARG='-nv'
for i in $@ ; do
    [[ $i = '--force' ]] && LINK_ARG='-svf'
    [[ $i = '--force' ]] && CP_ARG='-v --remove-destination'
done

# bash {{{1
##############################################################################
for i in $@ ; do
    if [[ $i = 'bash' || $i = '--all' ]] ; then
ln $LINK_ARG $PWD/bash/bashrc        ~/.bashrc
ln $LINK_ARG $PWD/bash/bash_aliases  ~/.bash_aliases
ln $LINK_ARG $PWD/bash/bash_env      ~/.bash_env
ln $LINK_ARG $PWD/bash/bash_profile  ~/.bash_profile
        break
    fi
done

# okular {{{1
##############################################################################
for i in $@ ; do
    if [[ $i = 'okular' || $i = '--all' ]] ; then
mkdir -p $XDG_DATA_HOME/okular/shortcuts
cp $CP_ARG $PWD/okular/config/*                       $XDG_CONFIG_HOME/
cp $CP_ARG $PWD/okular/local/share/okular/shortcuts/* $XDG_DATA_HOME/okular/shortcuts/
        break
    fi
done

# zsh {{{1
##############################################################################
for i in $@ ; do
    if [[ $i = 'zsh' || $i = '--all' ]] ; then
ln $LINK_ARG $PWD/zshrc ~/.zshrc
[[ -n $ZSH_CUSTOM ]] && DSTDIR=$ZSH_CUSTOM
[[ -z $ZSH_CUSTOM && -n $ZSH ]] && DSTDIR=$ZSH/custom
[[ -z $ZSH_CUSTOM && -z $ZSH ]] && DSTDIR=$HOME/.oh-my-zsh/custom
mkdir -p $DSTDIR
ln $LINK_ARG $PWD/zsh/themes/* $DSTDIR/themes/
        break
    fi
done

# Vim {{{1
##############################################################################
for i in $@ ; do
    if [[ $i = 'vim' || $i = '--all' ]] ; then

DSTDIR=$XDG_CONFIG_HOME/nvim

# .vimrc and init.vim {{{2
########################################
ln $LINK_ARG $PWD/vimrc ~/.vimrc

# other config files {{{2
########################################
# Create necessary dirs
find vim -type f -name '*.vim' | sed 's|/[^/]*$||' | sort | uniq | sed -E "s|^vim/(.*)$|$DSTDIR/\1|" | xargs mkdir -p
# Make a script to make symbolic link for each vim scripts
find vim -type f -name '*.vim' | sed -E "s|^(.*)$|\1 \1|" | sed -E "s|^([^ ]*) vim/(.*)$|ln $LINK_ARG $PWD/\1 $DSTDIR/\2|" > $TMP_DOT_SCRIPT
bash $TMP_DOT_SCRIPT

        break
    fi
done

# tmux {{{1
##############################################################################
for i in $@ ; do
    if [[ $i = 'tmux' || $i = '--all' ]] ; then
ln $LINK_ARG $PWD/tmux/tmux.conf ~/.tmux.conf
        break
    fi
done

# Git {{{1
##############################################################################
for i in $@ ; do
    if [[ $i = 'git' || $i = '--all' ]] ; then
ln $LINK_ARG $PWD/git/gitconfig ~/.gitconfig
ln $LINK_ARG $PWD/git/gitignore ~/.gitignore
        break
    fi
done

# tridactyl {{{1
##############################################################################
for i in $@ ; do
    if [[ $i = 'tridactyl' || $i = '--all' ]] ; then
mkdir -p $XDG_CONFIG_HOME/tridactyl
ln $LINK_ARG $PWD/tridactyl/tridactylrc $XDG_CONFIG_HOME/tridactyl/tridactylrc
        break
    fi
done

# alacritty {{{1
##############################################################################
for i in $@ ; do
    if [[ $i = 'alacritty' || $i = '--all' ]] ; then
mkdir -p $XDG_CONFIG_HOME/alacritty
ln $LINK_ARG $PWD/alacritty/alacritty.yml $XDG_CONFIG_HOME/alacritty/alacritty.yml
        break
    fi
done

# kitty {{{1
##############################################################################
for i in $@ ; do
    if [[ $i = 'kitty' || $i = '--all' ]] ; then
mkdir -p $XDG_CONFIG_HOME/kitty
ln $LINK_ARG $PWD/kitty/kitty.conf $XDG_CONFIG_HOME/kitty/kitty.conf
        break
    fi
done

# dircolors {{{1
##############################################################################
for i in $@ ; do
    if [[ $i = 'dircolors' || $i = '--all' ]] ; then
ln $LINK_ARG $PWD/dircolors $XDG_CONFIG_HOME/dircolors
        break
    fi
done
#}}}1
##############################################################################
rm $TMP_DOT_SCRIPT
# vi: fdm=marker sw=4 et
