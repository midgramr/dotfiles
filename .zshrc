# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
# Nice themes:
# amuse
# minimal
# typewritten
ZSH_THEME="spaceship"

zstyle ':omz:update' mode auto      # update automatically without asking

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

plugins=(
	git
	autojump
	zsh-autosuggestions
	eza
	vi-mode
)

source $ZSH/oh-my-zsh.sh

# User configuration

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi

# PERSONAL SETTINGS
export OPENAI_API_KEY="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"

source $(brew --prefix nvm)/nvm.sh

function git-prune-branches() {
    git fetch --prune
    git branch -vv | grep ': gone]' | awk '{print $1}' | xargs git branch -D
}

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/opt/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/opt/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/opt/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/opt/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

# pnpm
export PNPM_HOME="/Users/n1v3x/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

export PATH="$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"
export DBUS_SESSION_BUS_ADDRESS="unix:path=$DBUS_LAUNCHD_SESSION_BUS_SOCKET"
export MANPAGER='nvim +Man!'

# vim: ft=zsh
