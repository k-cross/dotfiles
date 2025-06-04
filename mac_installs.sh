#!/bin/sh

brew install \
  ripgrep \
  fzf \
  fd \
  bat \
  git \
  git-delta \
  neovim \
  ghostty \
  zellij \
  mise \
  qemu \
  gpg \
  gawk \
  starship \
  font-0xproto-nerd-font

# install latest rustup and rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

rustup install
rustup component add rust-src
rustup component add rust-analyzer
