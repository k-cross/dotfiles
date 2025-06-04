export ZSH="$HOME/.oh-my-zsh"

# Uncomment the following line to change how often to auto-update (in days).
export UPDATE_ZSH_DAYS=30

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

plugins=(colored-man-pages command-not-found macos mix git)

export EDITOR=nvim
export VISUAL=$EDITOR

source $ZSH/oh-my-zsh.sh
source $HOME/.config/zsh/custom.sh

eval "$(/opt/homebrew/bin/brew shellenv)"
eval "$(starship init zsh)"
eval "$(mise activate zsh)"
