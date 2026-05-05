# Only rebuild completions cache once a day
autoload -Uz compinit
if [ "$(date +'%j')" != "$(stat -f '%Sm' -t '%j' ~/.zcompdump 2>/dev/null)" ]; then
    compinit
else
    compinit -C
fi

if [[ -n "$GHOSTTY_RESOURCES_DIR" ]]; then
    source "$GHOSTTY_RESOURCES_DIR"/shell-integration/zsh/ghostty-integration
fi

export HELPDIR=/usr/share/zsh/$ZSH_VERSION/help
unalias run-help
autoload run-help

source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
