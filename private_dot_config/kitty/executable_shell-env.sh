#!/bin/sh
exec env fish -ilc '
    printf "env PATH=%s\n" (string join : -- $PATH) >&3
    printf "env FZF_DEFAULT_OPTS=%s\n" "$FZF_DEFAULT_OPTS" >&3
' 3>&1 >/dev/null
