#!/usr/bin/env bash

# load cuda modules
module load cuda/10.2
module load cudnn/7.6.5-cuda-10.2

# display loaded modules
module list

# start jupyter notebook server
jupyter notebook \
  --NotebookApp.allow_origin='https://colab.research.google.com' \
  --port=8888 \
  --NotebookApp.port_retries=0
