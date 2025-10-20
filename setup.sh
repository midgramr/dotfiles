#!/bin/zsh

# NOTE: need to run this script from the setup directory
DOTFILES=$(pwd)
CONFIGS=(
	 '.clang-format'
	 '.clangd'
	 '.editorconfig'
	 '.gitconfig'
	 '.lintr'
	 '.tmux.conf'
	 '.vimrc'
	 '.zshrc'
)

for cfg in $CONFIGS; do
	rm -f $HOME/$cfg
	ln -s $DOTFILES/$cfg $HOME/$cfg
	echo "Set symlink for $cfg"
done

# Tmux
brew install tmux
rm -rf ~/.tmux/plugins/tpm
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# Oh-My-ZSH
brew install autojump eza
rm -rf $ZSH_CUSTOM/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-autosuggestions.git $ZSH_CUSTOM/plugins/zsh-autosuggestions

# NeoVim
brew install neovim nvm lazygit
nvm install node # needed to install some LSPs
rm -rf ~/.config/nvim
git clone git@github.com:N1v3x2/nvim.git ~/.config/nvim

# Kitty
curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin
rm -rf ~/.config/kitty
git clone git@github.com:N1v3x2/kitty.git ~/.config/kitty

# vim: ft=zsh
