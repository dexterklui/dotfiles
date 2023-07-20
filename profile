#! /usr/bin/sh
# loaded for zsh login shell
# ~/.profile
#

if [ -f "$HOME/.config/bash_env" ]; then
	. "$HOME/.config/bash_env"
elif [ -f "$HOME/.bash_env" ]; then
	. "$HOME/.bash_env"
fi

# vi: ft=sh
