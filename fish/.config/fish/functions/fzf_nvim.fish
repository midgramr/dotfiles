function fzf_nvim
    eval "bfs $BFS_FLAGS" | fzf --scheme=path --bind 'enter:become(nvim {})'
end
