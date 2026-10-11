if status is-interactive
    set -g fish_vi_force_cursor 1
    set -g fish_cursor_default block
    set -g fish_cursor_insert line
    set -g fish_cursor_external line
    set -g fish_cursor_replace_one underscore
    set -g fish_cursor_visual block
    fish_vi_key_bindings

    switch (uname)
        case Darwin
            bind \cp 'pwd | pbcopy'
        case Linux
            bind \cp 'pwd | xsel -b'
    end
end
