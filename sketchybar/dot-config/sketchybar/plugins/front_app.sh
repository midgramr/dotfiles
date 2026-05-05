#!/bin/sh

source "$CONFIG_DIR/icon_map.sh"
source "$CONFIG_DIR/colors.sh"

__icon_map "$INFO"

app=(
    icon="$icon_result"
    label="$INFO"
    icon.font="sketchybar-app-font:Regular:16.0"
    icon.color="$FG"
    label.color="$FG"
    # background.color="$BG"
    background.corner_radius=4
    background.height=25
    icon.padding_left=8
    label.padding_right=8
)

if [ "$SENDER" = "front_app_switched" ]; then
    sketchybar --set "$NAME" "${app[@]}"
fi
