#!/usr/bin/env bash

# set port
PORT=8888
[ ! -z "$1" ] && PORT=$1

# load cuda modules
module load cuda/10.2
module load cudnn/7.6.5-cuda-10.2

# display loaded modules
module list

# start jupyter notebook server
jupyter notebook \
  --NotebookApp.allow_origin='https://colab.research.google.com' \
  --port=$PORT \
  --NotebookApp.port_retries=0
