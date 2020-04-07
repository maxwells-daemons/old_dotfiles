#!/bin/sh

if [[ -z "$@" ]];
then ls ${HOME}/bin/for_robots/screen_layouts
else
    eval $("${HOME}/bin/for_robots/screen_layouts/"$1)
fi
