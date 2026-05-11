#!/bin/bash

# NOTE: This script should be idempotent

set -ux

# Install Homebrew
homebrew_url="https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh"
command -v brew &>/dev/null || bash -c "$(curl -fsSL "$homebrew_url")"

cat formulas.txt | xargs brew install
./resync.sh

# Git
git config --global core.pager delta
git config --global interactive.diffFilter 'delta --color-only'
git config --global delta.navigate true

# TODO: install fonts
