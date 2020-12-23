#!/bin/bash

apt-get update

# Install nvidia driver
apt-get install -y ubuntu-drivers-common
ubuntu-drivers devices
ubuntu-drivers autoinstall
#apt-get install -y nvidia-driver-450
