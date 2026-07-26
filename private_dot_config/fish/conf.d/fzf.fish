if status is-interactive
    set -l fg0 '#d3c6aa'
    set -l bg0 '#2d353b'
    set -l yellow '#dbbc7f'
    set -l green '#a7c080'
    set -l blue '#7fbbb3'
    set -l bg_green '#425047'
    set -l orange '#e69875'
    set -l gray '#859289'

    set -l colors (string join ',' \
        "fg:$fg0" \
        "selected-fg:$yellow" \
        "bg:$bg0" \
        "hl:$green" \
        "fg+:$fg0" \
        "bg+:$bg_green" \
        "hl+:$green" \
        "info:$gray" \
        "prompt:$orange" \
        "pointer:$fg0" \
        "marker:$blue" \
        "spinner:$green")

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
