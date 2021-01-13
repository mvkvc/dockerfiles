FROM tensorflow/tensorflow:1.3.0-gpu-py3
ENV DEBIAN_FRONTEND=noninteractive

EXPOSE 8888
USER root
WORKDIR /

RUN add-apt-repository ppa:deadsnakes/ppa

RUN apt-get update && apt-get install -y \
	git \
	vim \
	wget \
	build-essential \
	apt-utils \
	apt-transport-https \
	ca-certificates \
	gnupg \
	software-properties-common \
	python3.6 \
	python3-tk

RUN git clone https://github.com/mvkvc/options-research ddpg_daibing

RUN export GOOGLE_APPLICATION_CREDENTIALS="/ddpg_daibing/docker_auth.json"

# RUN wget https://bootstrap.pypa.io/get-pip.py
# RUN python3.6 get-pip.py
# RUN python3.6 -m pip install -r ddpg_daibing/requirements.txt

# RUN python3.6 -m pip install notify-run
# RUN notify-run configure https://notify.run/[2tIWdaItl7cWhQpB]

# RUN wget \
# 	https://dvc.org/deb/dvc.list \
# 	-O /etc/apt/sources.list.d/dvc.list
# RUN apt update
# RUN apt install -y dvc

# WORKDIR /ddpg_daibing

# RUN dvc pull
# RUN python3.6 ./main_code.py
# RUN python3.6 ./notify.py