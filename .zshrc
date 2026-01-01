# Oh-My-ZSH config
export ZSH="$HOME/.oh-my-zsh"

# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="minimal"

# Update automatically without asking
zstyle ':omz:update' mode auto

plugins=(
  git
  autojump
  zsh-autosuggestions
  eza
  vi-mode
)

source $ZSH/oh-my-zsh.sh
# Oh-My-ZSH config end

source "$(brew --prefix nvm)/nvm.sh"

export MANPAGER='nvim +Man!'
export JAVA_HOME=$(/usr/libexec/java_home 2>/dev/null)

# fzf
export FZF_DEFAULT_OPTS='--style=minimal --cycle --tmux --layout=reverse'
export FZF_CTRL_T_OPTS="--walker-skip .git,node_modules,target"
source <(fzf --zsh)

_fzf_complete_ls() {
  _fzf_complete -- "$@" < <(fd -t d)
}

_fzf_complete_nvim() {
  _fzf_complete -- "$@" < <(fd -t f)
}

# Cht.sh
CHTSH_QUERY_OPTIONS="T"

# Setup completions
fpath=(~/.zsh.d/ $fpath)
autoload -U compinit
compinit

# Zsh help utility
export HELPDIR=/usr/share/zsh/$ZSH_VERSION/help
unalias run-help
autoload run-help
alias help=run-help

# Kitty binaries
export PATH=$PATH:/Applications/kitty.app/Contents/MacOS

# Go binaries
export PATH=$PATH:~/go/bin

# Override builtin ruby/gem
export PATH=$(brew --prefix)/opt/ruby/bin:$PATH

gems="$(echo $(brew --prefix)/lib/ruby/gems/3.4.0/gems/**/bin | tr ' ' :)"
export PATH="$PATH:$gems"

alias interact='~/Development/projects/stuff/interact.py --color'
alias fd='fd -H -E .git'
alias bat='bat --theme-dark gruvbox-dark'
alias bg='batgrep'
alias cd='pushd -q'
alias pd='popd -q'

function nvimhelp {
  nvim +"help $1" +only +"no q <Cmd>q<CR>"
}

# vim: ft=zsh
