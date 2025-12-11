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
# pnpm
export PNPM_HOME="/Users/n1v3x/Library/pnpm"
case ":$PATH:" in
*":$PNPM_HOME:"*) ;;
*) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

export MANPAGER='nvim +Man!'
export JAVA_HOME=$(/usr/libexec/java_home 2>/dev/null)

# fzf
export FZF_DEFAULT_OPTS='--style=minimal --cycle'
export FZF_CTRL_T_OPTS="--walker-skip .git,node_modules,target"
source <(fzf --zsh)

# Show only directories when autocompleting ls **<TAB>
_fzf_complete_ls() {
  _fzf_complete -- "$@" < <(eza -aD --git-ignore)
}

# Customize preview depending on command
_fzf_comprun() {
  local command=$1
  shift

  case "$command" in
    cd|ls)        fzf --preview 'tree -C -L 2 {} | head -200' "$@" ;;
    export|unset) fzf --preview "eval 'echo \$'{}"            "$@" ;;
    *)            fzf --preview 'bat -n --color=always {}'    "$@" ;;
  esac
}

# Zsh help utility
export HELPDIR=/usr/share/zsh/$ZSH_VERSION/help
unalias run-help
autoload run-help
alias help=run-help

alias s='kitten ssh'
alias interact='~/Development/projects/stuff/interact.py --color'
alias fd='fd -H -E .git'
alias bat='bat --theme-dark gruvbox-dark'

function git-prune-branches {
  git fetch --prune
  git branch -vv | grep ': gone]' | awk '{print $1}' | xargs git branch -D
}

function rg {
  command rg -p "${@}" | less -R
}

function nvimhelp {
  nvim +"help $1" +only +"no q <Cmd>q<CR>"
}

# vim: ft=zsh
