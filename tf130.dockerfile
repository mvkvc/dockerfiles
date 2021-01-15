FROM tensorflow/tensorflow:1.3.0-gpu-py3
ENV DEBIAN_FRONTEND=noninteractive

EXPOSE 8888
USER root
WORKDIR /

RUN echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] http://packages.cloud.google.com/apt cloud-sdk main" | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list && curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key --keyring /usr/share/keyrings/cloud.google.gpg  add - && apt-get update -y && apt-get install google-cloud-sdk -y
RUN gcloud beta auth application-default login

RUN add-apt-repository ppa:deadsnakes/ppa

RUN apt-get update && apt-get install -y \
	git \
	wget \
	build-essential \
	apt-utils \
	apt-transport-https \
	ca-certificates \
	gnupg \
	software-properties-common \
	python3.6

RUN git config --global url."https://mvkvc@e73705c2d00f9be66d59d768180df4ebc251f83e@github.com/".insteadOf "https://github.com/"
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

RUN dvc pull