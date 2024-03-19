#!/bin/bash

# path to clone repo into
INSTALL_ROOT=/home/$USER/dotfiles

# add unstable repo
echo "deb http://ftp.us.debian.org/debian sid main" | sudo tee -a /etc/apt/sources.list
sudo apt update && sudo apt upgrade

# install essentials
sudo apt install git zsh x11-xserver-utils

# clone repo
git clone https://github.com/v15hv4/dotfiles $INSTALL_ROOT

# install utils
sudo apt install bspwm sxhkd polybar rofi kitty dunst lightdm \
  light bat exa duf tmux curl rsync htop gpg feh unzip psmisc \
  nodejs python3 python-is-python3

# install zsh plugins
## oh-my-zsh
sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
## zsh-autosuggestions
git clone --depth=1 https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
## powerlevel10k
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

# install latest picom
sudo apt install libconfig-dev libdbus-1-dev libegl-dev libev-dev libgl-dev libepoxy-dev libpcre2-dev libpixman-1-dev libx11-xcb-dev libxcb1-dev libxcb-composite0-dev libxcb-damage0-dev libxcb-dpms0-dev libxcb-glx0-dev libxcb-image0-dev libxcb-present-dev libxcb-randr0-dev libxcb-render0-dev libxcb-render-util0-dev libxcb-shape0-dev libxcb-util-dev libxcb-xfixes0-dev libxext-dev meson ninja-build uthash-dev -y
wget -O /tmp/picom.tar.gz https://github.com/yshui/picom/archive/refs/tags/v11.2.tar.gz
tar xf /tmp/picom.tar.gz -C /tmp
CWD=`pwd` && cd /tmp/picom-11.2
meson setup --buildtype=release build
ninja -C build
cd $CWD

# install chrome
curl -s https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo sh -c "gpg --dearmor > /usr/share/keyrings/google-chrome-keyring.gpg"
sudo apt update && sudo apt upgrade
wget -O /tmp/libu2f.deb http://archive.ubuntu.com/ubuntu/pool/main/libu/libu2f-host/libu2f-udev_1.1.4-1_all.deb
sudo dpkg -i /tmp/libu2f.deb
wget -O /tmp/chrome.deb https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo dpkg -i /tmp/chrome.deb
sudo apt install -f -y

# install albert
wget -O /tmp/albert.deb https://download.opensuse.org/repositories/home:/manuelschneid3r/Debian_12/amd64/albert_0.23.0-0+605.1_amd64.deb
sudo dpkg -i /tmp/albert.deb
sudo apt install -f -y

# install tailscale
curl -fsSL https://tailscale.com/install.sh | sh

# install fonts
ln -s $INSTALL_ROOT/fonts ~/.local/share
fc-cache

# install configs
for conf in `\ls $INSTALL_ROOT/.config`; do
  ln -s $INSTALL_ROOT/.config/$conf $HOME/.config
done

# install dots
for dot in `\ls -ap $INSTALL_ROOT | grep -v "/"` | grep "^\."; do
  ln -s $INSTALL_ROOT/$dot $HOME
done
