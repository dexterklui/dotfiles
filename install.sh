#!/usr/bin/env bash
BASEDIR=$(dirname $0)
cd $BASEDIR || exit

ln -s ${PWD}/bashrc ~/.bashrc
ln -s ${PWD}/vimrc ~/.vimrc
ln -s ${PWD}/tridactylrc ~/.config/tridactyl/tridactylrc
