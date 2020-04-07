#!/bin/sh

if [[ -z "$@" ]];
then ls $HOME/.screenlayout
else
    eval $("${HOME}/.screenlayout/"$1)
fi
