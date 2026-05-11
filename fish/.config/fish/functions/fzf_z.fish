function fzf_z
    set -f dir (eval "bfs -type d $BFS_FLAGS" | fzf --scheme=path)
    if test -n "$dir"
        z $dir
    end
end
