export ZSH_DIR="$HOME/.zsh"

fd -e sh . "$ZSH_DIR" | while read -r FILE; do
    source "$FILE"
done

# vim: ft=zsh
