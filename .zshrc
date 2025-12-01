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

# Node
source $(brew --prefix nvm)/nvm.sh
# pnpm
export PNPM_HOME="/Users/n1v3x/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

export MANPAGER='nvim +Man!'
export JAVA_HOME=$(/usr/libexec/java_home 2>/dev/null)
export HELPDIR=/usr/share/zsh/$ZSH_VERSION/help

unalias run-help
autoload run-help

alias help=run-help
alias s="kitten ssh" # Auto copies terminfo file to remote
alias interact='~/Development/projects/stuff/interact.py --color'

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
