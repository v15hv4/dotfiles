#!/usr/bin/env bash

# load cuda modules
module load cuda/11.0
module load cudnn/8-cuda-11.0

# start jupyter notebook server
jupyter notebook \
  --NotebookApp.allow_origin='https://colab.research.google.com' \
  --port=8888 \
  --NotebookApp.port_retries=0
