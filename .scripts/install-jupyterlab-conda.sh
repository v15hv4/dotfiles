#!/usr/bin/env bash

# install nodejs for extensions
conda install nodejs -c conda-forge --repodata-fn=repodata.json -y

# install jupyterlab
conda install jupyter jupyterlab -c conda-forge -y

# install jupyterlab-vim
pip install --upgrade jupyterlab-vim

# create default ipython profile
ipython profile create

# disable jedi for better autocompletion
sed -i "s/.*\(c.Completer.use_jedi\).*/\1 = True/g" ~/.ipython/profile_default/ipython_config.py
