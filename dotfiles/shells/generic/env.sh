#
# ~/.config/shells/generic/env.sh
# Environment variables to be set for all shells.
#

### Basic environment variables
export EDITOR=nvim

### Set up path
export PATH=$PATH:${HOME}/.local/bin:${HOME}/bin/scripts

### Set up XDG base directory
export XDG_CONFIG_HOME=${HOME}/.config
export XDG_CACHE_HOME=${HOME}/.cache
export XDG_DATA_HOME=${HOME}/.local/share
export XDG_DATA_DIRS=/usr/local/share:/usr/share
export XDG_CONFIG_DIRS=/etc/xdg

### Configure programs
# ssh-agent
export SSH_AUTH_SOCK=${XDG_RUNTIME_DIR}/ssh-agent.socket

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

# Python
export PYTHONHISTFILE=${XDG_DATA_HOME}/python/python_history

# Jax
export XLA_FLAGS=--xla_gpu_cuda_data_dir=/opt/cuda

# Pyenv
export PYENV_ROOT=${XDG_DATA_HOME}/pyenv
export PYENV_VIRTUALENV_DISABLE_PROMPT=1

# Jupyter
export IPYTHONDIR=${XDG_CONFIG_HOME}/jupyter
export JUPYTER_CONFIG_DIR=${XDG_CONFIG_HOME}/jupyter

# VS Code
export VSCODE_PORTABLE=${XDG_DATA_HOME}/vscode

# Lean tools (Elan and Mathlib)
export ELAN_HOME=${XDG_DATA_HOME}/elan
export MATHLIB_CACHE_DIR=${XDG_CACHE_HOME}/mathlib
export PATH=$PATH:${XDG_DATA_HOME}/elan/bin

# Ruby (Gem and Bundler)
export GEM_HOME=${XDG_DATA_HOME}/gem
export GEM_SPEC_CACHE=${XDG_CACHE_HOME}/gem
export PATH=$PATH:${XDG_DATA_HOME}/gem/bin

export BUNDLE_USER_CONFIG=${XDG_CONFIG_HOME}/bundle
export BUNDLE_USER_CACHE=${XDG_CACHE_HOME}/bundle
export BUNDLE_USER_PLUGIN=${XDG_DATA_HOME}/bundle

# Docker
export DOCKER_CONFIG=${XDG_CONFIG_HOME}/docker

# GTK
export GTK2_RC_FILES=${XDG_CONFIG_HOME}/gtk-2.0/gtkrc

# pkg
export PKG_CACHE_PATH=${XDG_CACHE_HOME}/pkg
