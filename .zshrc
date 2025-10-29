# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
# Nice themes:
# amuse
# minimal
# typewritten
# spaceship (slow)
ZSH_THEME="minimal"

zstyle ':omz:update' mode auto      # update automatically without asking

plugins=(
  git
  autojump
  zsh-autosuggestions
  eza
  vi-mode
)

source $ZSH/oh-my-zsh.sh

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi

# Node
source $(brew --prefix nvm)/nvm.sh

# pnpm
export PNPM_HOME="/Users/n1v3x/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

# Git
function git-prune-branches {
  git fetch --prune
  git branch -vv | grep ': gone]' | awk '{print $1}' | xargs git branch -D
}

# Variables
export PATH="$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"
export DBUS_SESSION_BUS_ADDRESS="unix:path=$DBUS_LAUNCHD_SESSION_BUS_SOCKET"
export MANPAGER='nvim +Man!'
# export JAVA_HOME=$(/usr/libexec/java_home)

# Aliases
alias s="kitten ssh" # Auto copies terminfo file to remote
export IBMCLOUD_API_KEY=YoLvXT_oepqBmLJLefxr5eSr0IYPz30RzfAS2lH-hU6G

# The following lines have been added by Docker Desktop to enable Docker CLI completions.
fpath=(/Users/kevinzhang/.docker/completions $fpath)
autoload -Uz compinit
compinit
# End of Docker CLI completions

# vim: ft=zsh
