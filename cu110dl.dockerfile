FROM nvidia/cuda:11.1-cudnn8-devel-ubuntu18.04
ENV DEBIAN_FRONTEND=noninteractive
ARG JULIA_VER=1.5.3
ARG JULIA_URL=https://julialang-s3.julialang.org/bin/linux/x64/1.5

EXPOSE 8888
USER root
WORKDIR /

RUN mkdir _dev

RUN apt-get update && apt-get install -y \
	curl tar tmux build-essential git ninja-build ccache libopenblas-dev \
	libopencv-dev python3-opencv wget vim

RUN wget \
  https://dvc.org/deb/dvc.list \
  -O /etc/apt/sources.list.d/dvc.list
RUN apt-get update && apt-get install -y dvc

RUN curl -LO https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh && \
	bash Miniconda3-latest-Linux-x86_64.sh -p /miniconda -b && \
	rm Miniconda3-latest-Linux-x86_64.sh
ENV PATH=/miniconda/bin:${PATH}

RUN conda update -y conda && \
	conda install -y -c conda-forge jupyterlab
RUN mkdir /.local # && chown ${USER_ID} /.local

RUN curl -LO ${JULIA_URL}/julia-${JULIA_VER}-linux-x86_64.tar.gz && \
	tar -xf julia-${JULIA_VER}-linux-x86_64.tar.gz && \
	rm -rf julia-${JULIA_VER}-linux-x86_64.tar.gz && \
	ln -s /julia-${JULIA_VER}/bin/julia /usr/local/bin/julia
RUN mkdir /.julia # && chown ${USER_ID} /.julia

RUN jupyter notebook --generate-config -y
RUN echo "c.NotebookApp.token = '7u%OV1xWG&7m'" >> /root/.jupyter/jupyter_notebook_config.py
RUN echo "c.NotebookApp.disable_check_xsrf = True" >> /root/.jupyter/jupyter_notebook_config.py
