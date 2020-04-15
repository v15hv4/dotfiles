#!/usr/bin/env bash
INSTALL_DIR=$HOME

install_dotfiles() {
	dfiles_list=("vim" "vimrc")
	cd "$INSTALL_DIR"
	git clone https://github.com/v15hv4/dotfiles.git vdf_temp --recurse-submodules
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
