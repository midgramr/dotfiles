if status is-interactive
    bind -M insert ctrl-g 'git diff' repaint
    bind -M insert ctrl-f fzf_nvim
    bind -M insert ctrl-z fzf_z
end
