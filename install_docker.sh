#!/bin/bash

# Add repo and update
distribution=$(. /etc/os-release;echo $ID$VERSION_ID) \
   && curl -s -L https://nvidia.github.io/nvidia-docker/gpgkey | sudo apt-key add - \
   && curl -s -L https://nvidia.github.io/nvidia-docker/$distribution/nvidia-docker.list | sudo tee /etc/apt/sources.list.d/nvidia-docker.list
apt-get update

# Install docker
curl https://get.docker.com | sh \
  && systemctl start docker \
  && systemctl enable docker

# Install nvidia-docker
apt-get install -y nvidia-docker2
systemctl restart docker

# Test install
docker run --rm --gpus all nvidia/cuda:11.1-base nvidia-smi
