FROM nvidia/cuda:11.0-cudnn8-devel-ubuntu18.04
ENV DEBIAN_FRONTEND=noninteractive

EXPOSE 8888
USER root
WORKDIR /

RUN apt-get update && apt-get install -y \
	build-essential \
  wget \
	git \
	vim \
	python3-pip

RUN wget \
  https://dvc.org/deb/dvc.list \
  -O /etc/apt/sources.list.d/dvc.list
RUN apt-get update && apt-get install -y dvc

RUN git clone https://github.com/mvkvc/options-research
RUN python3 -m pip install -r /options-research/requirements.txt

RUN jupyter notebook --generate-config -y
RUN echo "c.NotebookApp.token = '7u%OV1xWG&7m'" >> /root/.jupyter/jupyter_notebook_config.py
RUN echo "c.NotebookApp.disable_check_xsrf = True" >> /root/.jupyter/jupyter_notebook_config.py
