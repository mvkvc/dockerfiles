FROM nvidia/cuda:11.0-cudnn8-devel-ubuntu18.04
ENV DEBIAN_FRONTEND=noninteractive

EXPOSE 8888
USER root
WORKDIR /

RUN sudo wget \
    	https://dvc.org/deb/dvc.list \
    	-O /etc/apt/sources.list.d/dvc.list

RUN apt-get update && apt-gest install -y \
	build-essential \
	git \
	vim \
	python3-pip \
	dvc

RUN git clone https://github.com/mvkvc/options-research
RUN python3 -m pip install -r /options-research/docker/requirements.txt

RUN jupyter notebook --generate-config -y
RUN echo "c.NotebookApp.token = '7u%OV1xWG&7m'" >> /root/.jupyter/jupyter_notebook_config.py
RUN echo "c.NotebookApp.disable_check_xsrf = True" >> /root/.jupyter/jupyter_notebook_config.py
