#!/bin/sh

# Config
[ -z ${XDG_CONFIG_HOME} ] && export XDG_CONFIG_HOME=${HOME}/.config
BASE_DIR=$(dirname $(realpath $0))
DOTFILES_DIR=$BASE_DIR/dotfiles

echo "Setting up config home: ${XDG_CONFIG_HOME}"
mkdir -pv $XDG_CONFIG_HOME
echo

echo "Setting up XDG user directories"
ln -sfv ${DOTFILES_DIR}/user-dirs.dirs ${XDG_CONFIG_HOME}/user-dirs.dirs
echo

echo "Linking shell configuration"
ln -sfnv ${DOTFILES_DIR}/shells ${XDG_CONFIG_HOME}/shells
echo

echo "Configuring bash"
ln -sfv ${DOTFILES_DIR}/shells/bash/bash_profile ${HOME}/.bash_profile
ln -sfv ${DOTFILES_DIR}/shells/bash/bashrc ${HOME}/.bashrc
echo

echo "Configuring vim"
mkdir -pv ${XDG_DATA_HOME}/vim/undo
mkdir -pv ${XDG_DATA_HOME}/vim/swap
mkdir -pv ${XDG_DATA_HOME}/vim/backup
mkdir -pv ${HOME}/.vim/colors
ln -sfv ${DOTFILES_DIR}/vim/base16-gigavolt.vim $HOME/.vim/colors/base16-gigavolt.vim
ln -sfv ${DOTFILES_DIR}/vim/vimrc $HOME/.vim/vimrc

if [ -z ${HOME}/.vim/autoload/plug.vim ]; then
    curl -fLo ${HOME}/.vim/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi
echo

echo "Configuring neovim"
ln -sfnv ${DOTFILES_DIR}/nvim ${XDG_CONFIG_HOME}/nvim
if [ -z ${XDG_DATA_HOME}/nvim/site/autoload/plug.vim ]; then
    sh -c 'curl -fLo ${XDG_DATA_HOME}/nvim/site/autoload/plug.vim --create-dirs \
           https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
fi
echo

echo "Linking XDG config directories"
ln -sfnv ${DOTFILES_DIR}/alsa       ${XDG_CONFIG_HOME}/alsa
ln -sfnv ${DOTFILES_DIR}/dunst      ${XDG_CONFIG_HOME}/dunst
ln -sfnv ${DOTFILES_DIR}/git        ${XDG_CONFIG_HOME}/git
ln -sfnv ${DOTFILES_DIR}/htop       ${XDG_CONFIG_HOME}/htop
ln -sfnv ${DOTFILES_DIR}/i3         ${XDG_CONFIG_HOME}/i3
ln -sfnv ${DOTFILES_DIR}/kitty      ${XDG_CONFIG_HOME}/kitty
ln -sfnv ${DOTFILES_DIR}/npm        ${XDG_CONFIG_HOME}/npm
ln -sfnv ${DOTFILES_DIR}/picom      ${XDG_CONFIG_HOME}/picom
ln -sfnv ${DOTFILES_DIR}/polybar    ${XDG_CONFIG_HOME}/polybar
ln -sfnv ${DOTFILES_DIR}/rofi       ${XDG_CONFIG_HOME}/rofi
ln -sfnv ${DOTFILES_DIR}/systemd    ${XDG_CONFIG_HOME}/systemd
ln -sfnv ${DOTFILES_DIR}/X11        ${XDG_CONFIG_HOME}/X11
ln -sfnv ${DOTFILES_DIR}/yay        ${XDG_CONFIG_HOME}/yay
ln -sfnv ${DOTFILES_DIR}/tmux       ${XDG_CONFIG_HOME}/tmux
echo

echo "Linking other files"
ln -sfv $BASE_DIR/other-files/webcam-settings.txt ${XDG_CONFIG_HOME}/webcam-settings.txt

echo "Done!"
