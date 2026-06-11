#!/bin/bash

cat configs.txt | xargs stow --dotfiles -R -t "$HOME" -v
