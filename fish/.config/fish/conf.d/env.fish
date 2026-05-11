if status is-interactive
    fish_add_path "$HOME/.cargo/bin"
    fish_add_path -a "/usr/local/bin"
    fish_add_path -a "$HOME/.local/bin"
    fish_add_path -a "/Applications/Obsidian.app/Contents/MacOS"
    fish_add_path -a "/Applications/kitty.app/Contents/MacOS"

    eval "$(/opt/homebrew/bin/brew shellenv)"

    set -gx BFS_FLAGS "-exclude \( -name .git -o -name node_modules \) -mindepth 1 -printf '%P\\n'"
    set -gx EDITOR "nvim"
    set -gx MANPAGER "nvim +Man!"
    set -gx JAVA_HOME "$(/usr/libexec/java_home 2>/dev/null)"
    set -gx HOMEBREW_NO_ENV_HINTS 1
    set -gx SHELL "/opt/homebrew/bin/fish"
end
