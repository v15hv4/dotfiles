#!/usr/bin/env bash

install_dotfiles() {
	dfiles_list=("vim" "vimrc" "config/kitty" "mozilla" "config/nvim" "zshrc")
	git clone https://github.com/v15hv4/dotfiles.git vdf_temp --recurse-submodules
	cd "$HOME"
	for i in ${!dfiles_list[@]}
	do
		dfile=${dfiles_list[$i]}
		if [ -f "."$dfile ] || [ -d "."$dfile ]
		then
			rm -rf $dfile".old"
			mv "."$dfile $dfile".old"
		fi
		mv vdf_temp/$dfile "."$dfile
	done
	rm -rf vdf_temp
}

install_dotfiles
