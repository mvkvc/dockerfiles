alias testdocker="docker run --rm --gpus all nvidia/cuda:11.1-base nvidia-smi"

# Python image for research
alias buildopt="docker build -f ~/dockerfiles/cu110opt.dockerfile -t options ."
alias runopt="docker run -it --gpus all --name options"
alias jupopt="docker run -it --gpus all -p 8888:8888 --name options jupyterlab
      --allow-root \
      --ip=0.0.0.0 \
      --no-browser"

# Python and Julia general image
alias builddl="docker build -f ~/dockerfiles/cu110dl.dockerfile -t dlgen ."
alias rundl="docker run -it --gpus all --name dlgen"
alias jupdl="docker run --gpus all -p 8888:8888 --name dlgen jupyterlab \
      --allow-root \
      --ip=0.0.0.0 \
      --no-browser"
