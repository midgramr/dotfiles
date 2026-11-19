function fzf_nvim
    fd --hidden --no-require-git --exclude .git --exclude node_modules | fzf --scheme=path --bind 'enter:become(nvim {})'
end
