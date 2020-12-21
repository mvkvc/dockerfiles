#!/bin/bash

# Add repo and update
distribution=$(. /etc/os-release;echo $ID$VERSION_ID) \
   && curl -s -L https://nvidia.github.io/nvidia-docker/gpgkey | sudo apt-key add - \
   && curl -s -L https://nvidia.github.io/nvidia-docker/$distribution/nvidia-docker.list | sudo tee /etc/apt/sources.list.d/nvidia-docker.list
apt-get update

# Install nvidia driver
apt-get install ubuntu-drivers-common -y
ubuntu-drivers devices
apt-get install nvidia-driver-450 -y

# Install docker
curl https://get.docker.com | sh \
  && systemctl start docker \
  && systemctl enable docker

# Install nvidia-docker
apt-get install -y nvidia-docker2
systemctl restart docker

# Update commands and test install
git clone https://github.com/mvkvc/dockerfiles
cp dockerfiles/.bash_aliases ~/.bash_aliases
source .bash_aliases
testdocker
