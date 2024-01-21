#!/bin/bash
SCRIPT_DIR=$(cd $(dirname $0); pwd)

echo "============================"
echo " Homebrew will be installed"
echo "============================"
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

echo "========================"
echo " tmux will be installed"
echo "========================"
brew install tmux

echo "======="
echo " setup"
echo "======="
echo ""
echo "setting git... "
if [ ! -d ~/.config/git ]; then
  mkdir -pv ~/.config/git
fi
ln -sfv $SCRIPT_DIR/dotfiles/scripts/gitconfig ~/.gitconfig
ln -sfv $SCRIPT_DIR/dotfiles/scripts/gitignore ~/.config/git/ignore
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
git clone --depth=1 https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
ln -sfv $SCRIPT_DIR/dotfiles/tmux.conf ~/.tmux.conf
~/.tmux/plugins/tpm/bin/install_plugins
echo ">>> Done"
echo ""

$SCRIPT_DIR/dotfiles/nvim/configs/basic/install.sh
