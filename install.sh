#!/bin/sh

# Config
COLORSCHEME="gigavolt"

echo "== Setting up =="
SCRIPT_DIR=$(dirname $(realpath $0))
DOTFILES_DIR=${SCRIPT_DIR}/dotfiles
CONFIG_DIR=${HOME}/.config
mkdir $CONFIG_DIR 2> /dev/null

echo "== Building base16 templates and colorschemes =="
cd submodules/base16-builder-python
pybase16.py update
pybase16.py build -o "${SCRIPT_DIR}/base16_output" -s $COLORSCHEME \
    -t dunst -t i3 -t kitty -t rofi -t shell -t vim -t xresources

echo "== Installing fonts =="
FONT_DIR=${HOME}/.fonts
mkdir $FONT_DIR 2> /dev/null
ln -sf ${SCRIPT_DIR}/fonts/*.ttf $FONT_DIR
fc-cache

echo "== Configuring Kitty =="
pybase16.py inject -s ${COLORSCHEME} -f ${DOTFILES_DIR}/kitty.conf
ln -sf ${DOTFILES_DIR}/kitty.conf ${CONFIG_DIR}/kitty/kitty.conf
