#!/usr/bin/env bash
DOTFILES_PATH=$HOME/dotfiles

# set to 0 to avoid backing up old dotfiles
BACKUP_OLD=1

INSTALL_PACKAGES=(google-chrome-stable kitty zsh tmux neovim zoxide exa bat duf rsync wlr-randr tofi xdg-desktop-portal-wayland xdg-desktop-portal-wlr swaylock-effects swayidle flameshot-git grim xclip wl-clipboard waybar dunst pamixer bashtop)
REMOVE_PACKAGES=(xdg-desktop-portal-gnome xdg-desktop-portal-gtk)
FONTS=(apple-fonts otf-geist otf-geist-mono otf-font-awesome noto-fonts-emoji)
FILES=(.gitconfig .p10k.zsh .tmux.conf .zsh_aliases .zshrc .config/)

# install packages
echo "installing packages..."
## sync packages
yay -Syu --noconfirm
## install required packages
yay -S ${INSTALL_PACKAGES[@]} --noconfirm
## remove unnecessary packages
yay -R ${REMOVE_PACKAGES[@]} --noconfirm
## install fonts
yay -S ${FONTS[@]} --noconfirm

# install zsh plugins
echo "installing zsh plugins..."
## oh-my-zsh
sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
## zsh-autosuggestions
git clone --depth=1 https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
## powerlevel10k
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
## autoenv
git clone --depth=1 https://github.com/zpm-zsh/autoenv ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/autoenv

# copying dotfiles
echo "linking dotfiles..."
for dotfile in "${FILES[@]}"; do
  if [ "${dotfile:0-1}" = "/" ]
    for subdotfile in "$DOTFILES_PATH/$dotfile"; do
      [[ (-f $DOTFILE_PATH/$dotfile/$subdotfile) && $BACKUP_OLD ]] && mv $DOTFILE_PATH/$dotfile/$subdotfile $DOTFILE_PATH/$dotfile/$subdotfile.old
      ln -s $DOTFILES_PATH/$dotfile/$subdotfile $dotfile/$subdotfile
    done
  else
    [[ (-f $HOME/$dotfile) && $BACKUP_OLD ]] && mv $HOME/$dotfile $HOME/$dotfile.old
    ln -s $DOTFILES_PATH/$dotfile $HOME
  fi
done

echo "done!"
