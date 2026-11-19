if status is-interactive
    set -l colors (string join ',' \
        "fg:#a09384" \
        "selected-fg:#fcba81" \
        "bg:#171311" \
        "hl:#ea9875" \
        "fg+:#e6d5c2" \
        "bg+:#201b19" \
        "hl+:#fcba81" \
        "info:#73665b" \
        "prompt:#d1766e" \
        "pointer:#ea9875" \
        "marker:#43b16a" \
        "spinner:#ea9875" \
        "query:#e6d5c2" \
        "header:#4e89a2" \
        "border:#362f2c" \
        "scrollbar:#362f2c" \
        "separator:#362f2c")

    set -gx FZF_DEFAULT_OPTS (string join ' ' -- \
        "--cycle" \
        "--layout=reverse" \
        "--highlight-line" \
        "--gutter=' '" \
        "--pointer='>'" \
        "--marker='+'" \
        "--no-bold" \
        "--color=$colors")
    set -gx FZF_ALT_C_COMMAND ''
    set -gx _ZO_FZF_OPTS "$FZF_DEFAULT_OPTS"

    fzf --fish | source
end
