# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.config/shells/zsh//.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

#
# ~/.config/shells/zsh/.zshrc
# Startup commands for interactive zsh sessions.
#

### Start with generic interactive shell config
source ~/.config/shells/generic/interactive.sh

### Suffix aliases to "open with X"
alias -s pdf=okular
alias -s {svg,gif}=chromium
alias -s {jpg,jpeg,JPG,JPEG,png,pnm,tif,tiff,bmp}="feh -d --draw-tinted"
alias -s {mp3,wav,ogg,avi,h264,mp4,mpg,mpeg}=vlc
alias -s xcf=gimp

### Shell settings
# Share history file amongst all zsh sessions, ignoring duplicates
setopt append_history share_history histignorealldups

# Use extended glob options
setopt extendedglob

# Error when a glob doesn't match
setopt nomatch

# Get updates from background processes immediately
setopt notify

# cd into directories by name
setopt autocd

# No beeping
unsetopt beep

# "emacs-style" input
bindkey -e

# Bind ctrl-r to history search
bindkey "^r" history-incremental-search-backward

### Completion settings
# The following lines were added by compinstall
zstyle :compinstall filename '${HOME}/.config/shells/zsh/.zshrc'

autoload -Uz compinit
compinit -d ${XDG_CACHE_HOME}/zsh/zcompdump-${ZSH_VERSION}
# End of lines added by compinstall

#
# Antigen manages plugins.
#
source /usr/share/zsh/share/antigen.zsh

### Set up oh-my-zsh
antigen use oh-my-zsh

# We'll update manually
DISABLE_UPDATE_PROMPT=true
DISABLE_AUTO_UPDATE=true

# Try to correct unrecognized command names and filenames
ENABLE_CORRECTION=true

# Speed up VCS status checks
DISABLE_UNTRACKED_FILES_DIRTY=true

### Set up plugins
antigen bundles <<EOBUNDLES
    # Add colors to man pages, and the "colored" prefix to try to color other pages
    colored-man-pages

    # Autocompletion support
    docker
    gcloud
    gitfast
    pip
    ripgrep

    # Suggest commands as you type
    zsh-users/zsh-autosuggestions

    # Syntax highlighting in the shell
    zsh-users/zsh-syntax-highlighting

    # Add more completion definitions
    zsh-users/zsh-completions
EOBUNDLES

# zsh-autosuggestions
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20
ZSH_AUTOSUGGEST_USE_ASYNC=1

# Powerlevel10K theme
antigen theme romkatv/powerlevel10k

# Apply changes
antigen apply

### Powerlevel10k prompt
# Load the prompt
[[ ! -f ~/.config/shells/zsh/.p10k.zsh ]] || source ~/.config/shells/zsh/.p10k.zsh
