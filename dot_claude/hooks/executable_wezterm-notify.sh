#!/usr/bin/env bash
set -uo pipefail

input=$(cat)
msg=$(jq -r '.message // "Claude Code needs your attention"' <<<"$input" 2>/dev/null) || msg="Claude Code needs your attention"
cwd=$(jq -r '.cwd // ""' <<<"$input" 2>/dev/null) || cwd=""

pane="${WEZTERM_PANE:-}"

focused_class=$(i3-msg -t get_tree 2>/dev/null | jq -r 'recurse | objects | select(.focused == true and .window != null) | .window_properties.class // empty' | head -1)

shopt -s nocasematch
if [[ "$focused_class" == *wezterm* ]] && [[ -n "$pane" ]]; then
  focused_panes=$(wezterm cli list-clients --format json 2>/dev/null | jq -r '.[].focused_pane_id')
  while IFS= read -r fp; do
    if [[ "$fp" == "$pane" ]]; then
      exit 0
    fi
  done <<<"$focused_panes"
fi
shopt -u nocasematch

setsid -f /home/kevin-zhang/.claude/hooks/wezterm-notify-action.sh "$pane" "$msg" "$cwd" >/dev/null 2>&1 </dev/null

exit 0
