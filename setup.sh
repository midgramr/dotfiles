#!/bin/bash

set -ux

# Install Homebrew
command -v brew &> /dev/null
if [[ $? != 0 ]]; then
  bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Brew utilities
cat utils.txt | xargs brew install

# Configs
cat packages.txt | xargs stow --adopt --dotfiles -R -t ~ -v

# Git
git config --global core.pager delta
git config --global interactive.diffFilter 'delta --color-only'
git config --global delta.navigate true

# Need node to install some LSPs
command -v node &> /dev/null
if [[ $? != 0 ]]; then
  nvm install node 
fi

# Tmux
tpm_path='~/.tmux/plugins/tpm'
ls "$tpm_path" &> /dev/null
if [[ $? != 0 ]]; then
  git clone https://github.com/tmux-plugins/tpm "$tpm_path"
fi

# Oh-My-ZSH
ZSH="$HOME/.oh-my-zsh"
ls "$ZSH" &> /dev/null
if [[ $? != 0 ]]; then
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

# vim: ft=bash
