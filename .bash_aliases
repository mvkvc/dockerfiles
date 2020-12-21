alias testdocker="docker run --rm --gpus all nvidia/cuda:11.1-base nvidia-smi"

# Python image for research
alias optbuild="docker build -f dockerfiles/optcu110.dockerfile -t options ."
alias optrun="docker run -it --gpus all --name options"
alias optjup="docker run -it --gpus all -p 8888:8888 --name options jupyterlab
      --allow-root \
      --ip=0.0.0.0 \
      --no-browser"

# Python and Julia general image
alias dlbuild="docker build -f dockerfiles/dlcu110.dockerfile -t dlgen ."
alias dltrun="docker run -it --gpus all --name dlgen"
alias dljup="docker run --gpus all -p 8888:8888 --name dlgen jupyterlab \
      --allow-root \
      --ip=0.0.0.0 \
      --no-browser"
