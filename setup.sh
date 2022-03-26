#!/usr/bin/env bash

DOTFILES_PATH=$HOME/dotfiles
DOTFILES=(.tmux.conf .vim .vimrc .zsh_aliases .zshrc .scripts)

BACKUP_OLD=1
INSTALL_MINICONDA=1
ZSH_INSTALLED=$(command -v zsh)

GIT_EMAIL=vishva2912@gmail.com
GIT_USERNAME=v15hv4

# install miniconda
if [ ! -z "$INSTALL_MINICONDA" ]; then
	mkdir -p ~/miniconda3
	wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda3/miniconda.sh
	bash ~/miniconda3/miniconda.sh -b -u -p ~/miniconda3
	rm -rf ~/miniconda3/miniconda.sh
	~/miniconda3/bin/conda init bash
	~/miniconda3/bin/conda init zsh
fi

# install zsh plugins and set as default shell (if zsh is installed)
if [ ! -z "$ZSH_INSTALLED" ]; then
	echo "installing zsh plugins..."
	# remove existing oh-my-zsh folder if it exists
	rm -rf ~/.oh-my-zsh

	# oh-my-zsh
	sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

	# zsh-autosuggestions
	git clone --depth=1 https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
fi

# copying dotfiles
echo "linking dotfiles..."
for dotfile in "${DOTFILES[@]}"; do
	[[ (-f $HOME/$dotfile) && $BACKUP_OLD ]] && mv $HOME/$dotfile $HOME/$dotfile.old
	ln -s $DOTFILES_PATH/$dotfile $HOME
done

# configure git
git config --global user.email "$GIT_EMAIL"
git config --global user.name "$GIT_USERNAME"
git config --global core.editor "vim"

# success!
echo "done."
