FROM tensorflow/tensorflow:1.3.0-gpu-py3
ENV DEBIAN_FRONTEND=noninteractive

EXPOSE 8888
USER root
WORKDIR /

RUN add-apt-repository ppa:deadsnakes/ppa

RUN apt-get update && apt-get install -y \
	git \
	nano \
	vim \
	wget \
	curl \
	build-essential \
	apt-utils \
	apt-transport-https \
	ca-certificates \
	gnupg \
	software-properties-common \
	python3.6 \
	python3-tk

RUN git clone https://github.com/mvkvc/options-research ddpg_daibing

RUN curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
RUN python3.6 get-pip.py
RUN python3.6 -m pip install -r ddpg_daibing/requirements.txt

RUN wget \
	https://dvc.org/deb/dvc.list \
	-O /etc/apt/sources.list.d/dvc.list
RUN apt update
RUN apt install -y dvc

WORKDIR /ddpg_daibing

RUN export GOOGLE_APPLICATION_CREDENTIALS="/ddpg_daibing/docker_auth.json"
RUN dvc pull
RUN python3.6 ./main_code.py
RUN curl https://notify.run/2tIWdaItl7cWhQpB -d "Training complete"