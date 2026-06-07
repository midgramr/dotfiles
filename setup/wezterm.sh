brew install --cask wezterm

# install terminfo
tempfile=$(mktemp) &&
    curl -o $tempfile https://raw.githubusercontent.com/wezterm/wezterm/main/termwiz/data/wezterm.terminfo &&
    tic -x -o ~/.terminfo $tempfile &&
    rm $tempfile

luarocks install wezterm-types
