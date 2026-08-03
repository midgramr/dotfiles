#!/usr/bin/env bash
set -uo pipefail

pane="$1"
msg="$2"
cwd="$3"

body="$msg"
if [[ -n "$cwd" ]]; then
  body="$body
$cwd"
fi

if [[ -z "$pane" ]]; then
  notify-send -a "Claude Code" "Claude Code" "$body"
  exit 0
fi

id=$(( 20000 + pane ))
action=$(dunstify -a "Claude Code" -u normal -r "$id" -A "focus,Focus pane" "Claude Code" "$body")

if [[ "$action" == "focus" ]]; then
  info=$(wezterm cli list --format json)
  clients=$(wezterm cli list-clients --format json)
  active_ws=$(jq -r '.[0].workspace // empty' <<<"$clients")
  focused=$(jq -r '.[0].focused_pane_id // empty' <<<"$clients")

  # the handler only fires for panes in the active workspace, so deliver the
  # request there and let it navigate to "$pane" wherever it lives
  tty=$(jq -r --argjson p "${focused:-0}" '.[] | select(.pane_id == $p) | .tty_name' <<<"$info" | head -1)
  if [[ -z "$tty" ]]; then
    tty=$(jq -r --arg ws "$active_ws" '.[] | select(.workspace == $ws) | .tty_name' <<<"$info" | head -1)
  fi
  if [[ -z "$tty" ]]; then
    tty=$(jq -r --argjson p "$pane" '.[] | select(.pane_id == $p) | .tty_name' <<<"$info" | head -1)
  fi

  if [[ -n "$tty" ]] && [[ -w "$tty" ]]; then
    printf '\033]1337;SetUserVar=%s=%s\007' claude_focus "$(printf '%s' "$pane" | base64)" > "$tty"
  fi

  win=$(xdotool search --class wezterm | head -1)
  if [[ -n "$win" ]]; then
    i3-msg "[id=$win] focus" >/dev/null 2>&1
  fi
fi

exit 0
