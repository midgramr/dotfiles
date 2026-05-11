if status is-interactive
    set -gx _ZO_FZF_OPTS "$FZF_DEFAULT_OPTS"
    zoxide init fish | source
end
