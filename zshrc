export ZSH="$HOME/.oh-my-zsh"

# Uncomment the following line to change how often to auto-update (in days).
export UPDATE_ZSH_DAYS=30

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

plugins=(asdf colorize command-not-found macos mix git)

source $ZSH/oh-my-zsh.sh
source $HOME/.config/zsh/custom.sh

eval "$(starship init zsh)"
