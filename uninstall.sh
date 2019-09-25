#!/bin/sh
INSTALL_DIR=$HOME

uninstall_vimrc () {
	cd ~
	if [ -f ".vimrc" ]; then
		rm -rf .vimrc
		if [ -f "old.vimrc" ]; then
			mv old.vimrc .vimrc	
		fi
	fi
	if [ -d ".vim" ]; then
		rm -rf .vim
		if [ -d "old.vim" ]; then
			mv old.vim .vim
		fi
	fi

	echo "Uninstalled successfully!"
}

uninstall_vimrc
