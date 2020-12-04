#alias dlbuild='sudo docker build /home/marko/dev/. -f dl-docker/dlcu110.dockerfile -t "gcr.io/dl-comp/dl:latest"'
#alias dlpull='sudo docker pull "gcr.io/dl-comp/dl:latest"'
#alias dlpush='sudo docker push "gcr.io/dl-comp/dl:latest"'
#alias dlrun='sudo docker run --gpus all -p 8888:8888 gcr.io/dl-comp/dl:latest jupyter notebook \
#       --allow-root \
#       --ip=0.0.0.0 \
#       --no-browser'


FROM nvidia/cuda:11.0-devel-ubuntu20.04

ENV DEBIAN_FRONTEND=noninteractive
ARG JULIA_VER=1.5.3
ARG JULIA_URL=https://julialang-s3.julialang.org/bin/linux/x64/1.5

EXPOSE 8888
USER root

WORKDIR /
COPY _dev /_dev

RUN apt-get update && apt-get install -y \
	curl tar tmux build-essential git ninja-build ccache libopenblas-dev \
	libopencv-dev python3-opencv

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

COPY dl-docker/requirements.jl /tmp/
RUN julia /tmp/requirements.jl

COPY dl-docker/requirements.txt /tmp/
RUN python3 -m pip install -r /tmp/requirements.txt

RUN jupyter notebook --generate-config -y
RUN echo "c.NotebookApp.token = '7u%OV1xWG&7m'" >> /root/.jupyter/jupyter_notebook_config.py
RUN echo "c.NotebookApp.disable_check_xsrf = True" >> /root/.jupyter/jupyter_notebook_config.py
