if status is-interactive
    set -l fg0 '#d4be98'
    set -l bg0 '#282828'
    set -l yellow '#d8a657'
    set -l green '#a9b665'
    set -l blue '#7daea3'
    set -l bg_green '#34381b'
    set -l orange '#e78a4e'
    set -l gray '#a89984'

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
