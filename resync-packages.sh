#!/bin/bash

cat packages.txt | xargs stow --dotfiles -R -t ~ -v
