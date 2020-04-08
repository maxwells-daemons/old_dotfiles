#!/bin/sh

# Config
COLORSCHEME=${1:-gigavolt}

BASE_DIR=$(dirname $(realpath $0))
DOTFILES_DIR=$BASE_DIR/dotfiles
SCRIPT_DIR=$BASE_DIR/bin
SUBMODULE_DIR=$BASE_DIR/submodules

echo "Setting up"
mkdir -p $XDG_HOME_CONFIG
cd $SUBMODULE_DIR/base16-builder-python

# echo "Building base16 templates and colorschemes"
pybase16.py update
pybase16.py build -o "$BASE_DIR/base16_output" -s $COLORSCHEME \
    -t dunst -t i3 -t kitty -t rofi -t shell -t vim -t xresources

echo "Installing base16-shell"
ln -sf $SUBMODULE_DIR/base16-shell $XDG_HOME_CONFIG

echo "Installing fonts"
mkdir -p $HOME/.fonts
ln -sf $BASE_DIR/fonts/*.ttf $HOME/.fonts
fc-cache

echo "Installing Liquid Prompt"
mkdir -p $XDG_HOME_CONFIG/liquidprompt
mkdir -p $XDG_HOME_CONFIG/liquidprompt_theme
ln -sf $SUBMODULE_DIR/liquidprompt $XDG_HOME_CONFIG
ln -sf $DOTFILES_DIR/liquidprompt/liquidpromptrc $XDG_HOME_CONFIG/liquidpromptrc
ln -sf $DOTFILES_DIR/liquidprompt/custom.ps1 $XDG_HOME_CONFIG/liquidprompt_theme/custom.ps1
ln -sf $DOTFILES_DIR/liquidprompt/custom.theme $XDG_HOME_CONFIG/liquidprompt_theme/custom.theme

echo "Installing EGPU service"
sudo ln -sf $DOTFILES_DIR/setup-egpu.service /etc/systemd/system/setup-egpu.service

echo "Configuring Kitty"
pybase16.py inject -s $COLORSCHEME -f $DOTFILES_DIR/kitty.conf
ln -sf $DOTFILES_DIR/kitty.conf $XDG_HOME_CONFIG/kitty/kitty.conf

echo "Configuring i3"
pybase16.py inject -s $COLORSCHEME -f $DOTFILES_DIR/i3/config
ln -sf $DOTFILES_DIR/i3 $XDG_HOME_CONFIG/
ln -sf $DOTFILES_DIR/rofi_scripts $XDG_HOME_CONFIG/

echo "Configuring zathura"
pybase16.py inject -s $COLORSCHEME -f $DOTFILES_DIR/zathurarc
mkdir -p $XDG_HOME_CONFIG/zathura
ln -sf $DOTFILES_DIR/zathurarc $XDG_HOME_CONFIG/zathura/zathurarc

echo "Configuring dunst"
pybase16.py inject -s $COLORSCHEME -f $DOTFILES_DIR/dunstrc
mkdir -p $XDG_HOME_CONFIG/dunst
ln -sf $DOTFILES_DIR/dunstrc $XDG_HOME_CONFIG/dunst/dunstrc

echo "Configuring shell tools"
pybase16.py inject -s $COLORSCHEME -f $DOTFILES_DIR/X/Xresources
ln -sf $DOTFILES_DIR/shell/profile $HOME/.profile
ln -sf $DOTFILES_DIR/shell/bash_profile $HOME/.bash_profile
ln -sf $DOTFILES_DIR/shell/bashrc $HOME/.bashrc
ln -sf $DOTFILES_DIR/X/xinitrc $HOME/.xinitrc
ln -sf $DOTFILES_DIR/X/Xmodmap $HOME/.Xmodmap
ln -sf $DOTFILES_DIR/X/Xresources $HOME/.Xresources
ln -sf $DOTFILES_DIR/git/gitattributes $HOME/.gitattributes
ln -sf $DOTFILES_DIR/git/gitconfig $HOME/.gitconfig
ln -sf $DOTFILES_DIR/git/gitignore_global $HOME/.gitignore_global
ln -sf $DOTFILES_DIR/ghci $HOME/.ghci
ln -sf $DOTFILES_DIR/ripgrep_ignore $XDG_HOME_CONFIG/.ripgrep_ignore
ln -sf $DOTFILES_DIR/compton.conf $XDG_HOME_CONFIG/compton.conf
