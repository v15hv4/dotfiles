#!/bin/sh
INSTALL_TO=$HOME

warn() {
    echo "$1" >&2
}

die() {
    warn "$1"
    exit 1
}

install_vimrc () {
    [ -e "$INSTALL_TO/vimrc" ] && die "$INSTALL_TO/vimrc already exists."
    [ -e "~/.vim" ] && die "~/.vim already exists."
    [ -e "~/.vimrc" ] && die "~/.vimrc already exists."

    cd "$INSTALL_TO"
    git clone git://github.com/v15hv4/vimrc.git wvimrc
    cd wvimrc
	mv vim ~/.vim
    
	# Symlink ~/.vimrc
	cd ~
    ln -s "$HOME/wvimrc/vimrc" .vimrc
    
    echo "Done!"
}

install_vimrc
