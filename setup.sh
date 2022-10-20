#!/usr/bin/env bash

CONFIGS_PATH=$HOME/.config
DOTFILES_PATH=$HOME/dotfiles
FONTS_PATH=$HOME/.local/share/fonts

INSTALL_YAY=$(command -v yay)
BACKUP_OLD=1

PACKAGES=(alsa-utils imagemagick feh kitty neovim nodejs npm pulseaudio redshift rofi tmux unzip wget zsh)
CONFS=(kitty nvim)
DOTFILES=(.p10k.zsh .tmux.conf .vim .vimrc .zsh_aliases .zshrc .scripts)

# install yay
if [ -z "$INSTALL_YAY" ]; then
	echo "yay not found, installing..."
	sudo pacman -S base-devel git
	cd /opt
	sudo git clone https://aur.archlinux.org/yay-git.git
	sudo chown -R $USER:$USER ./yay-git
	cd yay-git
	makepkg -si
	cd $HOME
fi

# install all other packages using yay
echo "installing packages..."
yay -S "${PACKAGES[@]}"

# install zsh plugins
echo "installing zsh plugins..."
# oh-my-zsh
sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
# zsh-autosuggestions
git clone --depth=1 https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
# powerlevel10k
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
# autoenv
git clone --depth=1 https://github.com/zpm-zsh/autoenv ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/autoenv

# install vim-plug
echo "installing vim-plug..."
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

# copy config files
echo "linking configs..."
[[ ! -d $CONFIGS_PATH ]] && mkdir $CONFIGS_PATH
for config in "${CONFS[@]}"; do
	[[ (-f $CONFIGS_PATH/$config) && $BACKUP_OLD ]] && mv $CONFIGS_PATH/$config $CONFIGS_PATH/$config.old
	ln -s $DOTFILES_PATH/$config $CONFIGS_PATH
done

# copying dotfiles
echo "linking dotfiles..."
for dotfile in "${DOTFILES[@]}"; do
	[[ (-f $HOME/$dotfile) && $BACKUP_OLD ]] && mv $HOME/$dotfile $HOME/$dotfile.old
	ln -s $DOTFILES_PATH/$dotfile $HOME
done

# install fonts
echo "installing fonts..."
[[ ! -d $FONTS_PATH ]] && mkdir $FONTS_PATH
wget -nc https://github.com/ToxicFrog/Ligaturizer/releases/download/v5/LigaturizedFonts.zip -P /tmp
unzip /tmp/LigaturizedFonts.zip -d /tmp/LigaturizedFonts
mv /tmp/LigaturizedFonts/LigalexMono* $FONTS_PATH

# clear yay cache
yay -Scc
yay -R $(yay -Qtdq)

# success!
echo "done."
