#!/bin/sh

DOTFILES_DIR=$(dirname $(realpath $0))

# Config
COLORSCHEME="gigavolt"

# Build base16 colorscheme and templates
echo "== base16 setup =="
cd submodules/base16-builder-python
# pybase16.py update
pybase16.py build -o "${DOTFILES_DIR}/base16_output" -s $COLORSCHEME \
    -t dunst -t i3 -t kitty -t rofi -t shell -t vim -t xresources
