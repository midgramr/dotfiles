BFS_FLAGS="-exclude \( -name .git -o -name node_modules \) \
-mindepth 1 -printf '%P\\n'"

fzf-nvim() {
    tmux set -p cursor-style bar
    eval "bfs $BFS_FLAGS" | fzf --scheme=path --bind 'enter:become(nvim {})'
    tmux set -p cursor-style block
}

fzf-z() {
    tmux set -p cursor-style bar
    dir=$(eval "bfs -type d $BFS_FLAGS" | fzf --scheme=path)
    if [[ -n $dir ]]; then
        z $dir
    fi
    tmux set -p cursor-style block
}

zle-line-pre-redraw() { zle reset-prompt; }

zle -N fzf-nvim
zle -N fzf-z
zle -N zle-line-pre-redraw
bindkey '^b' test-widget
bindkey '^f' fzf-nvim
bindkey '^z' fzf-z
