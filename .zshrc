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
export FZF_DEFAULT_OPTS='--style=minimal --cycle --tmux=80% --layout=default'
export FZF_CTRL_T_OPTS="--walker-skip .git,node_modules,target"
source <(fzf --zsh)

_fzf_complete_ls() {
  _fzf_complete -- "$@" < <(eza -aD --git-ignore)
}

_fzf_complete_nvim() {
  _fzf_complete -- "$@" < <(fd -t f)
}

_fzf_comprun() {
  local command=$1
  shift

  case "$command" in
    cd|ls)        fzf --preview 'tree -C -L 2 {} | head -200' "$@" ;;
    export|unset) fzf --preview "eval 'echo \$'{}"            "$@" ;;
    ssh)          fzf --preview 'dig {}'                      "$@" ;;
    *)            fzf --preview 'bat -n --color=always {}'    "$@" ;;
  esac

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

# Override builtin ruby/gem
export PATH=$(brew --prefix)/opt/ruby/bin:$PATH

gems="$(echo $(brew --prefix)/lib/ruby/gems/3.4.0/gems/**/bin | tr ' ' :)"
export PATH="$PATH:$gems"

alias s='kitten ssh'
alias interact='~/Development/projects/stuff/interact.py --color'
alias fd='fd -H -E .git'
alias bat='bat --theme-dark gruvbox-dark'
# NOTE: this overrides the builtin `bg`
alias bg='batgrep'
alias cd='pushd -q'
alias pd='popd -q'

function nvimhelp {
  nvim +"help $1" +only +"no q <Cmd>q<CR>"
}

# vim: ft=zsh
