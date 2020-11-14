#
# ~/.config/shells/zsh/.zshenv
# Startup commands for every zsh shell.
#

# Set generic environment variables
source ~/.config/shells/generic/env.sh

# Set Antigen's path correctly
ANTIGEN_CHECK_FILES=${HOME}/.config/shells/zsh/.zshrc
ADOTDIR=${XDG_DATA_HOME}/antigen


# Save 1000 lines of history in $XDG_DATA_HOME/zsh/history
HISTFILE=~/.local/share/zsh/history
HISTSIZE=1000
SAVEHIST=1000
