fg0='#d4be98'
bg0='#282828'
yellow='#d8a657'
green='#a9b665'
blue='#7daea3'
bg_green='#34381b'
orange='#e78a4e'
gray='#a89984'

colors="\
fg:$fg0,\
selected-fg:$yellow,\
bg:$bg0,\
hl:$green,\
fg+:$fg0,\
bg+:$bg_green,\
hl+:$green,\
info:$gray,\
prompt:$orange,\
pointer:$fg0,\
marker:$blue,\
spinner:$green"

export FZF_DEFAULT_OPTS="\
--cycle \
--layout=reverse \
--highlight-line \
--gutter=' ' \
--pointer='>' \
--marker='+' \
--no-bold \
--no-scrollbar \
--color=$colors"

export FZF_ALT_C_COMMAND=""

source <(fzf --zsh)
