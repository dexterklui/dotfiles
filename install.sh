#!/usr/bin/env bash
BASEDIR=$(dirname $0)
cd $BASEDIR || exit

ln -s ${PWD}/bashrc ~/.bashrc
