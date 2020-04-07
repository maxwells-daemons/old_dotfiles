#!/bin/sh

if [[ -z "$@" ]];
then ls $HOME/.config/i3/layouts
else
    i3-msg "append_layout ${HOME}/.config/i3/layouts/"$1 > /dev/null
fi
