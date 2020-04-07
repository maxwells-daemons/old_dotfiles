#!/bin/sh

SCRIPT_DIR=$(dirname $(realpath $0))
DOTFILES_DIR=${SCRIPT_DIR}/dotfiles

# Config
COLORSCHEME="gigavolt"

echo "== Setting up base16 templates and colorschemes =="
cd submodules/base16-builder-python
pybase16.py update
pybase16.py build -o "${SCRIPT_DIR}/base16_output" -s $COLORSCHEME \
    -t dunst -t i3 -t kitty -t rofi -t shell -t vim -t xresources

echo "== Installing fonts =="
(mkdir ~/.fonts 2> /dev/null) || true
ln -sf ${SCRIPT_DIR}/fonts/*.ttf ~/.fonts
fc-cache

echo "== Installing Kitty config =="
pybase16.py inject -s ${COLORSCHEME} -f ${DOTFILES_DIR}/kitty.conf
ln -sf ${DOTFILES_DIR}/kitty.conf ${HOME}/.config/kitty/kitty.conf
