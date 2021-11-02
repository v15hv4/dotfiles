# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home2/vishva.saravanan/miniconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home2/vishva.saravanan/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/home2/vishva.saravanan/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home2/vishva.saravanan/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

# switch to the `ds` environment on startup
conda activate ds
