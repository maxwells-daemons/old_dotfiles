#!/bin/sh

basedir=$HOME/bin/scripts/

if [[ -z "$@" ]];
then find $basedir -name "*.sh" | sed 's/.*\/,//;s/\.sh//'
else
    eval $basedir$1
    i3-msg move window to scratchpad
fi
