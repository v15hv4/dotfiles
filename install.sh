#!/bin/sh
INSTALL_TO=$HOME

install_vimrc () {
	cd ~
	if [ -f ".vimrc" ]; then
		if [ -f "old.vimrc" ]; then
			rm -rf old.vimrc
		fi
		mv .vimrc old.vimrc	
	fi	
	if [ -d ".vim" ]; then
		if [ -d "old.vim" ]; then
			rm -rf old.vim
		fi
		mv .vim old.vim
	fi

	cd "$INSTALL_TO"
    git clone git://github.com/v15hv4/vimrc.git wvimrc
	mv wvimrc/vim ~/.vim
    mv wvimrc/vimrc ~/.vimrc
	rm -rf wvimrc

    echo "Done!"
}

install_vimrc
