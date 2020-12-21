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
	python3-pip
	apt-get install  ca-certificates

RUN wget \
  https://dvc.org/deb/dvc.list \
  -O /etc/apt/sources.list.d/dvc.list
RUN apt update
RUN apt install -y dvc

RUN git clone https://github.com/mvkvc/options-research ddpg_daibing
RUN python3 -m pip install --upgrade pip
RUN python3 -m pip install -r ddpg_daibing/requirements.txt
RUN python3 -m pip install jupyterlab

RUN jupyter notebook --generate-config -y
RUN echo "c.NotebookApp.token = '7u%OV1xWG&7m'" >> /root/.jupyter/jupyter_notebook_config.py
RUN echo "c.NotebookApp.disable_check_xsrf = True" >> /root/.jupyter/jupyter_notebook_config.py
