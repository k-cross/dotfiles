# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
alias vi='nvim'
alias grun='java org.antrl.v4.runtime.misc.TestRig'
alias slack='/home/owl/Documents/slack-2.1.2/usr/bin/slack'
setopt nonomatch
unsetopt beep
#autoload -U compinit promptinit
#compinit
#promptinit
#
#autoload -U colors && colors

bindkey -v

# End of lines configured by zsh-newuser-install
PATH="/usr/local/heroku/bin:$bin:$PATH"
PATH="$HOME/.local/bin:$bin:$PATH"



########### Antigen Start #############
source ~/.zsh/antigen/antigen.zsh

# Load the oh-my-zsh's library.
antigen use oh-my-zsh

# Bundles from the default repo (robbyrussell's oh-my-zsh).
antigen bundle tmux
antigen bundle git
antigen bundle colorize
antigen bundle color-man-pages
antigen bundle pip
antigen bundle lein
antigen bundle command-not-found

# Syntax highlighting bundle.
antigen bundle zsh-users/zsh-syntax-highlighting

# Load the theme.
antigen theme nanotech

# Tell antigen that you're done.
antigen apply
########### Antigen  End  #############
