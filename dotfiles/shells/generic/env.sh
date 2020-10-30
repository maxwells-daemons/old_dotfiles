#
# ~/.config/shells/generic/env.sh
# Environment variables to be set for all shells.
#

### Basic environment variables
export EDITOR=nvim

### Set up XDG base directory
export XDG_CONFIG_HOME=${HOME}/.config
export XDG_CACHE_HOME=${HOME}/.cache
export XDG_DATA_HOME=${HOME}/.local/share
export XDG_DATA_DIRS=/usr/local/share:/usr/share
export XDG_CONFIG_DIRS=/etc/xdg

### Configure programs
# X
export XAUTHORITY=${XDG_RUNTIME_DIR}/Xauthority
export XINITRC=${XDG_CONFIG_HOME}/X11/xinitrc
export XSERVERRC=${XDG_CONFIG_HOME}/X11/xserverrc

# bash
export HISTFILE=${XDG_DATA_HOME}/bash/history

# less
export LESSKEY=${XDG_CONFIG_HOME}/less/lesskey
export LESSHISTFILE=${XDG_CACHE_HOME}/less/history

# gpg
export GNUPGHOME=${XDG_DATA_HOME}/gnupg

# node
export NODE_REPL_HISTORY=${XDG_DATA_HOME}/node_repl_history
export NPM_CONFIG_USERCONFIG=${XDG_CONFIG_HOME}/npm/npmrc

# fzf
export FZF_DEFAULT_COMMAND='rg --files --no-ignore-vcs --hidden'

# CUDA
export CUDA_CACHE_PATH=${XDG_CACHE_HOME}/nv

# Pyenv
export PYENV_ROOT=${XDG_DATA_HOME}/pyenv

# Jupyter
export IPYTHONDIR=${XDG_CONFIG_HOME}/jupyter
export JUPYTER_CONFIG_DIR=${XDG_CONFIG_HOME}/jupyter

### Path setup
export PATH=$PATH:${HOME}/.local/bin:${HOME}/bin/scripts
