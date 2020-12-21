alias gtop="watch -n1 nvidia-smi"
alias testopt="docker run --rm --gpus all nvidia/cuda:8.0-devel-ubuntu16.04 nvidia-smi"

# Python image for research
alias buildopt="docker build -f dockerfiles/tf-1.3.0-gpu.dockerfile -t options ."
alias runopt="docker run -it --gpus all -p 8888:8888 options /bin/bash"

# Python and Julia general image
alias builddl="docker build -f dockerfiles/cu110dl.dockerfile -t dlgen ."
alias rundl="docker run -it -it --gpus all -p 8888:8888 dlgen /bin/bash"
alias jupdl="docker run --gpus all -p 8888:8888 dlgen jupyterlab \
      --allow-root \
      --ip=0.0.0.0 \
      --no-browser"
