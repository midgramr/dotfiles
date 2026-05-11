fzf-nvim() {
    eval "bfs $BFS_FLAGS" | fzf --scheme=path --bind 'enter:become(nvim {})'
}

fzf-z() {
    dir=$(eval "bfs -type d $BFS_FLAGS" | fzf --scheme=path)
    if [[ -n $dir ]]; then
        z $dir
    fi
}

zle-line-pre-redraw() { zle reset-prompt; }

zle -N fzf-nvim
zle -N fzf-z
zle -N zle-line-pre-redraw
bindkey '^b' test-widget
bindkey '^f' fzf-nvim
bindkey '^z' fzf-z

# vim: ft=zsh
