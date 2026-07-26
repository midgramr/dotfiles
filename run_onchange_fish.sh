#!/usr/bin/env fish

curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | fish -c "source && fisher install jorgebucaran/fisher && fisher install jorgebucaran/nvm.fish" || true
