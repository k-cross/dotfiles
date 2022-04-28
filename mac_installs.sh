#!/bin/sh

# install homebrew first
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

brew install ripgrep fzf fd bat asdf git git-delta neovim tmux qemu tree-sitter gpg gawk

# install latest rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

# install asdf
echo -e "\n. $(brew --prefix asdf)/libexec/asdf.sh" >> ${ZDOTDIR:-~}/.zshrc

source ${ZDOTDIR:-~}/.zshrc

asdf plugin-add erlang
asdf plugin-add elixir
