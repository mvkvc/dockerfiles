#!/bin/bash

# Install NVIDIA drivers
apt-get install ubuntu-drivers-common -y
ubuntu-drivers devices
ubuntu-drivers autoinstall

# Install docker
curl https://get.docker.com | sh \
  && systemctl start docker \
  && systemctl enable docker

# Install nvidia-docker
distribution=$(. /etc/os-release;echo $ID$VERSION_ID) \
   && curl -s -L https://nvidia.github.io/nvidia-docker/gpgkey | sudo apt-key add - \
   && curl -s -L https://nvidia.github.io/nvidia-docker/$distribution/nvidia-docker.list | sudo tee /etc/apt/sources.list.d/nvidia-docker.list
apt-get update
apt-get install -y nvidia-docker2
systemctl restart docker
