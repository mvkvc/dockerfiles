#docker build . -f dl.dockerfile -t "gcr.io/dl-comp/p:latest"
#docker push "gcr.io/dl-comp/p:latest"
#docker run --gpus all -p 8888:8888 gcr.io/dl-comp/p:latest jupyter lab \
#       --allow-root \
#       --ip=0.0.0.0 \
#       --no-browser

FROM nvidia/cuda:10.2-devel-ubuntu18.04

ENV DEBIAN_FRONTEND=noninteractive
ARG CUDA_VER=102
#ARG USER_ID=3003
EXPOSE 8888
USER root

WORKDIR /

RUN apt-get update && apt-get install -y \
	curl tar tmux git

RUN curl -LO https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh && \
	bash Miniconda3-latest-Linux-x86_64.sh -p /miniconda -b && \
	rm Miniconda3-latest-Linux-x86_64.sh
ENV PATH=/miniconda/bin:${PATH}

RUN conda update -y conda && \
	conda install -y -c conda-forge jupyterlab
RUN mkdir /.local # && chown ${USER_ID} /.local

COPY requirements.txt /tmp/
RUN echo "mxnet-cu${CUDA_VER}" >> /tmp/requirements.txt
RUN python3 -m pip install -r /tmp/requirements.txt

RUN jupyter notebook --generate-config -y
RUN echo "c.NotebookApp.token = '7u%OV1xWG&7m'" >> /root/.jupyter/jupyter_notebook_config.py
RUN echo "c.NotebookApp.disable_check_xsrf = True" >> /root/.jupyter/jupyter_notebook_config.py

RUN git clone https://github.com/d2l-ai/d2l-en-colab d2l
