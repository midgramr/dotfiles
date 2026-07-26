#!/bin/bash

# Terminate already running bar instances
polybar-msg cmd quit

# Launch bar1 and bar2
echo "---" | tee -a /tmp/polybar1.log /tmp/polybar2.log
polybar 2>&1 | tee -a /tmp/polybar1.log & disown

echo "Bars launched..."
