#docker build . -f dl.dockerfile -t "gcr.io/dl-comp/dl:latest"
#docker push "gcr.io/dl-comp/dl:latest"
#docker run --gpus all -p 8888:8888 gcr.io/dl-comp/dl:latest jupyter lab \
#       --allow-root \
#       --ip=0.0.0.0 \
#       --no-browser

FROM nvidia/cuda:10.0-devel-ubuntu18.04

ENV DEBIAN_FRONTEND=noninteractive
ARG CUDA_VER=100
ARG JULIA_VER=1.5.1
ARG JULIA_URL=https://julialang-s3.julialang.org/bin/linux/x64/1.5

EXPOSE 8888
USER root

WORKDIR /

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

COPY requirements.jl /tmp/
RUN julia /tmp/requirements.jl

COPY requirements.txt /tmp/
RUN echo "mxnet-cu${CUDA_VER}" >> /tmp/requirements.txt
RUN python3 -m pip install -r /tmp/requirements.txt

RUN jupyter notebook --generate-config -y
RUN echo "c.NotebookApp.token = '7u%OV1xWG&7m'" >> /root/.jupyter/jupyter_notebook_config.py
RUN echo "c.NotebookApp.disable_check_xsrf = True" >> /root/.jupyter/jupyter_notebook_config.py

#RUN git clone --recursive https://github.com/apache/incubator-mxnet mxnet
#RUN mkdir /mxnet/build

#WORKDIR /mxnet/build

#RUN cmake ..
#RUN cmake --build .

#WORKDIR /mxnet

# To install the MXNet Python binding navigate to the root of the MXNet folder
# then run the following:
#RUN python3 -m pip install --user -e ./python
#RUN python3 -m pip install --user graphviz==0.8.4 jupyter

#WORKDIR /

# To use the Julia binding you need to set the MXNET_HOME and LD_LIBRARY_PATH
# environment variables. For example,
#ENV MXNET_HOME=$HOME/mxnet
#ENV LD_LIBRARY_PATH=$HOME/mxnet/build:$LD_LIBRARY_PATH
#RUN julia --color=yes --project=./ -e \
#      'using Pkg; \
#       Pkg.develop(PackageSpec(name="MXNet", path = joinpath(ENV["MXNET_HOME"], "julia")))'

RUN mkdir /_dev
RUN git clone https://github.com/d2l-ai/d2l-en-colab /_dev/d2l
