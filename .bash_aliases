alias testopt="docker run --rm --gpus all nvidia/cuda:8.0-devel-ubuntu16.04 nvidia-smi"

# Python image for research
alias buildopt="docker build -f dockerfiles/cu80opt.dockerfile -t options ."
alias runopt="docker run -it --gpus all -p 8888:8888 options"
alias jupopt="docker run -it --gpus all -p 8888:8888 options jupyterlab
      --allow-root \
      --ip=0.0.0.0 \
      --no-browser"

# Python and Julia general image
alias builddl="docker build -f dockerfiles/cu110dl.dockerfile -t dlgen ."
alias rundl="docker run -it -it --gpus all -p 8888:8888 dlgen"
alias jupdl="docker run --gpus all -p 8888:8888 dlgen jupyterlab \
      --allow-root \
      --ip=0.0.0.0 \
      --no-browser"
