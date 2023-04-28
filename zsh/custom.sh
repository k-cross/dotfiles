# Aliases
alias imx="iex -S mix"
alias ipx="iex -S mix phx.server"
alias itx="MIX_ENV=test iex -S mix"
alias gco="git checkout"
alias gs="git status"
alias gds="git diff --stat"
alias vv='nvim'

# Functions
pubip() {
 PUBLIC_IP=`curl 'https://api.ipify.org'`
 echo $PUBLIC_IP | pbcopy
 echo $PUBLIC_IP
}

# Environment Variables

## FZF
export FZF_DEFAULT_COMMAND='fd --type f'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

## Erlang
export KERL_CONFIGURE_OPTIONS="--disable-debug --without-javac"
export ERL_AFLAGS="-kernel shell_history enabled"

## Rust
export RUST_LOG=trace
export RUST_BACKTRACE=1
