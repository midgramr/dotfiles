#!/bin/bash

set -eux

cat utils.txt | xargs brew install
cat packages.txt | xargs stow --adopt --dotfiles -R -t ~ -v

# Git
git config --global core.pager delta
git config --global interactive.diffFilter 'delta --color-only'
git config --global delta.navigate true

# Need node to install some LSPs
nvm install node 

# Tmux
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# vim: ft=bash
