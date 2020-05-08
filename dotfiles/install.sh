#!/bin/bash
echo "=> Instalando dotfiles"
git clone git://github.com/boris/dotfiles.git ~/.dotfiles

echo "=> Installing oh-my-zsh"
git clone git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
mkdir -p ~/.oh-my-zsh/custom/themes

#echo "Instalando rbenv"
#git clone git://github.com/sstephenson/rbenv.git ~/.rbenv
#
#echo "Instalando plugins para rbenv"
#mkdir -p ~/.rbenv/plugins
#git clone git://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build
#
#echo "Instalando config de Vim"
#git clone git://github.com/boris/vim.git ~/.vim
#ln -sf ~/.vim/vimrc ~/.vimrc

echo "Instalando tmux y powerline"
sudo apt update ; sudo apt install tmux powerline

echo "Symlinks varios"
ln -sf ~/.dotfiles/zsh/bquiroz.zsh-theme ~/.oh-my-zsh/custom/themes/bquiroz.zsh-theme
ln -sf ~/.dotfiles/zsh/zshrc ~/.zshrc
ln -sf ~/.dotfiles/git/gitconfig ~/.gitconfig
ln -sf ~/.dotfiles/screen/screenrc ~/.screenrc
ln -sf ~/.dotfiles/tmux/tmux.conf ~/.tmux.conf
ln -sf ~/.dotfiles/zsh/aliases.zsh ~/.oh-my-zsh/custom/aliases.zsh
ln -sf ~/.dotfiles/zsh/plugins/juju ~/.oh-my-zsh/custom/plugins/juju
ln -sf ~/.dotfiles/i3 ~/.config/i3

sudo ln -sf ~/.dotfiles/utils/bang /usr/local/bin/bang
sudo ln -sf ~/.dotfiles/utils/vpn /usr/local/bin/bpn
