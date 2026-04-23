# OSC 133 support
precmd() {
  print -Pn "\e]133;A\e\\"  # prompt start
}

autoload -U promptinit
promptinit
prompt walters

