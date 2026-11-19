function fzf_nvim_all
    fd --hidden --no-ignore --exclude .git | fzf --scheme=path --bind 'enter:become(nvim {})'
end
