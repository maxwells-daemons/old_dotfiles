#
# ~/.config/shells/generic/interactive.sh
# Configs applicable to all interactive shells.
#

# Aliases
alias ls='ls --color=auto'
alias diff='diff --color=auto'
alias grep='grep --color=auto'
alias ip='ip --color=auto'
alias wget='wget --hsts-file=${XDG_CACHE_HOME}/wget-hsts'
alias protoc_python='PYENV_VERSION=tools python -m grpc.tools.protoc'

# Fix allowing coc-python to use (hardcoded) system paths for tooling and
# virtualenv paths for libraries (via :CocCommand python.setInterpreter).
alias nvim='PYENV_VERSION=system nvim'

# Kitty
if [ $TERM = "xterm-kitty" ]; then
    # Automatically copy terminfo to servers on SSH
    alias ssh='kitty +kitten ssh'

    # Pipe into / out of clipboard
	alias clip='kitty +kitten clipboard'
	alias pasteclip='kitty +kitten clipboard --get-clipboard'
fi

# Pyenv
eval "$(pyenv init -)"
