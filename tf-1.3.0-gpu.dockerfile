FROM tensorflow/tensorflow:1.3.0-gpu-py3
ENV DEBIAN_FRONTEND=noninteractive

EXPOSE 8888
USER root
WORKDIR /

RUN apt-get update && apt-get install -y \
	build-essential \
	apt-utils \
	apt-transport-https \
	ca-certificates \
	wget \
	git \
	vim \
	python3.6 \
	python3-tk \
	python3-pip

RUN wget \
  https://dvc.org/deb/dvc.list \
  -O /etc/apt/sources.list.d/dvc.list
RUN apt update
RUN apt install -y dvc

RUN git clone https://github.com/mvkvc/options-research ddpg_daibing
RUN python3.6 -m pip install --upgrade pip
RUN python3.6 -m pip install -r ddpg_daibing/requirements.txt
