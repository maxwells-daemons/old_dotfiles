#!/bin/sh

# Config
COLORSCHEME=${1:-gigavolt}

echo "== Setting up =="
SCRIPT_DIR=$(dirname $(realpath $0))
DOTFILES_DIR=${SCRIPT_DIR}/dotfiles
CONFIG_DIR=${HOME}/.config
mkdir -p $CONFIG_DIR
cd submodules/base16-builder-python

echo "== Building base16 templates and colorschemes =="
pybase16.py update
pybase16.py build -o "${SCRIPT_DIR}/base16_output" -s $COLORSCHEME \
    -t dunst -t i3 -t kitty -t rofi -t shell -t vim -t xresources

echo "== Installing fonts =="
mkdir -p ${HOME}/.fonts
ln -sf ${SCRIPT_DIR}/fonts/*.ttf ${HOME}/.fonts
fc-cache

echo "== Configuring Kitty =="
pybase16.py inject -s ${COLORSCHEME} -f ${DOTFILES_DIR}/kitty.conf
ln -sf ${DOTFILES_DIR}/kitty.conf ${CONFIG_DIR}/kitty/kitty.conf

echo "== Configuring i3 =="
pybase16.py inject -s ${COLORSCHEME} -f ${DOTFILES_DIR}/i3/config
ln -sf ${DOTFILES_DIR}/i3 ${CONFIG_DIR}/
