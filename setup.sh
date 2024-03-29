#!/bin/bash
SCRIPT_DIR=$(cd $(dirname $0); pwd)

echo "=============================="
echo " nerd-fonts will be installed"
echo "=============================="
if [ ! -d /Library/Fonts ]; then
  sudo mkdir -pv /Library/Fonts
fi
cd /Library/Fonts && sudo curl -fLO https://github.com/ryanoasis/nerd-fonts/raw/HEAD/patched-fonts/Hack/Regular/HackNerdFont-Regular.ttf
echo ">>> Done"
echo ""

echo ""
echo "========================"
echo " tmux will be installed"
echo "========================"
brew install tmux

echo ""
echo "======="
echo " setup"
echo "======="
echo ""
echo "setting git... "
if [ -e ~/.gitconfig ]; then
  LOAD_COMMAND_COUNT=$(cat ~/.gitconfig | grep alias | wc -l)
  if [ $LOAD_COMMAND_COUNT -eq 0 ]; then
    cat $SCRIPT_DIR/dotfiles/scripts/gitconfig >> ~/.gitconfig
  fi
else
  cat $SCRIPT_DIR/dotfiles/scripts/gitconfig > ~/.gitconfig
fi
if [ ! -d ~/.config/git ]; then
  mkdir -pv ~/.config/git
fi
ln -siv $SCRIPT_DIR/dotfiles/scripts/gitignore ~/.config/git/ignore
echo ">>> Done"
echo ""

echo ""
echo "setting zsh... "
ln -sfv $SCRIPT_DIR/zsh/zshrc ~/.zshrc
ln -sfv $SCRIPT_DIR/zsh/p10k.zsh ~/.p10k.zsh
git clone --depth=1 https://github.com/ohmyzsh/ohmyzsh.git ~/.oh-my-zsh
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/powerlevel10k
git clone --depth=1 https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone --depth=1 https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
echo ">>> Done"
echo ""

echo ""
echo "setting tmux... "
if [ -d ~/.tmux ]; then
  rm -rf ~/.tmux
fi
ln -sfv $SCRIPT_DIR/dotfiles/tmux.conf ~/.tmux.conf
git clone --depth=1 https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
~/.tmux/plugins/tpm/bin/install_plugins
echo ">>> Done"
echo ""

if [ -d ~/.vim/plugged ]; then
  rm -rf ~/.vim/plugged
fi
if [ -d ~/.vim/undo ]; then
  rm -rf ~/.vim/undo
fi
$SCRIPT_DIR/dotfiles/nvim/configs/basic/install.sh

echo ""
echo "please set your terminal font as 'Hack Nerd Font Regular'"
