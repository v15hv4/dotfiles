#!/usr/bin/env bash

# download update
rm -rf discord_latest.tar.gz Discord/
wget -O discord_latest.tar.gz "https://discordapp.com/api/download?platform=linux&format=tar.gz"

# uninstall existing
sudo rm -rf /usr/share/pixmaps/discord* /usr/share/applications/discord* /usr/share/discord* ~/.config/discord*

# install update
tar -xvf discord_latest.tar.gz
sudo mv Discord/discord.png /usr/share/pixmaps
sudo mv Discord/discord.desktop /usr/share/applications
sudo mv Discord /usr/share/discord
