brew install asmvik/formulae/yabai

# Add scripting addition (not idempotent)
echo "$(whoami) ALL=(root) NOPASSWD: sha256:$(shasum -a 256 $(which yabai) | cut -d " " -f 1) $(which yabai) --load-sa" | sudo tee /private/etc/sudoers.d/yabai

# May prompt for accessibility permissions
yabai --start-service
