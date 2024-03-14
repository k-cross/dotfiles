#!/bin/sh

# install homebrew first
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

brew install ripgrep fzf fd bat git git-delta neovim alacritty zellij qemu gpg gawk starship

# install latest rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
