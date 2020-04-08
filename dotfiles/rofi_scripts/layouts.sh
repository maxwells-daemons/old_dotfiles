#!/bin/sh

if [[ -z "$@" ]];
then ls ${XDG_CONFIG_HOME}/i3/layouts
else
    i3-msg "append_layout ${XDG_CONFIG_HOME}/i3/layouts/"$1 > /dev/null
fi
