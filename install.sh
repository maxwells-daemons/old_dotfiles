#!/bin/sh

# Config
COLORSCHEME=${1:-gigavolt}

BASE_DIR=$(dirname $(realpath $0))
DOTFILES_DIR=$BASE_DIR/dotfiles
SCRIPT_DIR=$BASE_DIR/bin
SUBMODULE_DIR=$BASE_DIR/submodules

echo "Setting up"
mkdir -p $XDG_CONFIG_HOME
cd $SUBMODULE_DIR/base16-builder-python

echo "Building base16 templates and colorschemes"
pybase16.py update
pybase16.py build -o "$BASE_DIR/base16_output" -s $COLORSCHEME \
    -t dunst -t i3 -t kitty -t rofi -t shell -t vim -t xresources

echo "Installing base16-shell"
ln -sf $SUBMODULE_DIR/base16-shell $XDG_CONFIG_HOME

echo "Installing fonts"
mkdir -p $HOME/.fonts
ln -sf $BASE_DIR/fonts/*.ttf $HOME/.fonts
fc-cache

echo "Installing Liquid Prompt"
mkdir -p $XDG_CONFIG_HOME/liquidprompt
mkdir -p $XDG_CONFIG_HOME/liquidprompt_theme
ln -sf $SUBMODULE_DIR/liquidprompt $XDG_CONFIG_HOME
ln -sf $DOTFILES_DIR/liquidprompt/liquidpromptrc $XDG_CONFIG_HOME/liquidpromptrc
ln -sf $DOTFILES_DIR/liquidprompt/custom.ps1 $XDG_CONFIG_HOME/liquidprompt_theme/custom.ps1
ln -sf $DOTFILES_DIR/liquidprompt/custom.theme $XDG_CONFIG_HOME/liquidprompt_theme/custom.theme

echo "Installing EGPU service"
sudo ln -sf $DOTFILES_DIR/setup-egpu.service /etc/systemd/system/setup-egpu.service

echo "Configuring Kitty"
pybase16.py inject -s $COLORSCHEME -f $DOTFILES_DIR/kitty.conf
ln -sf $DOTFILES_DIR/kitty.conf $XDG_CONFIG_HOME/kitty/kitty.conf

echo "Configuring Vim and Neovim"
mkdir -p $HOME/.vim/colors
ln -sf $DOTFILES_DIR/vim/base16-gigavolt.vim $HOME/.vim/colors/base16-gigavolt.vim
ln -sf $DOTFILES_DIR/vim/vimrc $HOME/.vimrc
ln -sf $DOTFILES_DIR/nvim $XDG_CONFIG_HOME

echo "Configuring i3"
pybase16.py inject -s $COLORSCHEME -f $DOTFILES_DIR/i3/config
ln -sf $DOTFILES_DIR/i3 $XDG_CONFIG_HOME/
ln -sf $DOTFILES_DIR/rofi_scripts $XDG_CONFIG_HOME/

echo "Configuring zathura"
pybase16.py inject -s $COLORSCHEME -f $DOTFILES_DIR/zathurarc
mkdir -p $XDG_CONFIG_HOME/zathura
ln -sf $DOTFILES_DIR/zathurarc $XDG_CONFIG_HOME/zathura/zathurarc

echo "Configuring dunst"
pybase16.py inject -s $COLORSCHEME -f $DOTFILES_DIR/dunstrc
mkdir -p $XDG_CONFIG_HOME/dunst
ln -sf $DOTFILES_DIR/dunstrc $XDG_CONFIG_HOME/dunst/dunstrc

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
ln -sf $DOTFILES_DIR/ripgrep_ignore $XDG_CONFIG_HOME/.ripgrep_ignore
ln -sf $DOTFILES_DIR/compton.conf $XDG_CONFIG_HOME/compton.conf
ln -sf $DOTFILES_DIR/flake8 $XDG_CONFIG_HOME/flake8
ln -sf $DOTFILES_DIR/polybar $XDG_CONFIG_HOME/polybar/config
