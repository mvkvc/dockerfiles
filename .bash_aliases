alias gtop="watch -n3 nvidia-smi"
alias testnv="docker run --rm --gpus all nvidia/driver:450.80.02-ubuntu20.04 nvidia-smi"
alias testtf="docker run --rm --gpus all tf130 nvidia-smi"
alias testub="docker run --rm --gpus all ub2004 nvidia-smi"

# Research
alias buildtf="docker build --no-cache -f dockerfiles/tf130.dockerfile -t tf130 ."
alias runtf="docker run -it --rm --gpus all -p 8888:8888 tf130 /bin/bash"

# Personal
alias buildub="docker build -f dockerfiles/ub2004.dockerfile -t ub2004 ."
alias runub="docker run -it -it --gpus all -p 8888:8888 ub2004 /bin/bash"
alias jupub="docker run --gpus all -p 8888:8888 ub2004 jupyterlab \
      --allow-root \
      --ip=0.0.0.0 \
      --no-browser"
