FROM nvidia/cuda:10.2-cudnn7-runtime-ubuntu18.04
ARG USER_ID=3003
ARG JULIA_VER=1.4.2
ARG JULIA_URL=https://julialang-s3.julialang.org/bin/linux/x64/1.4
ARG JUPYTER_PW=pw

EXPOSE 8888
USER root
WORKDIR /

# ==== Install system dependencies ====

RUN apt-get update && apt-get install -y \
	curl tar tmux

# ========== Install Jupyter ==========

# Install Miniconda
RUN curl -LO https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh && \
	bash Miniconda3-latest-Linux-x86_64.sh -p /miniconda -b && \
	rm Miniconda3-latest-Linux-x86_64.sh
ENV PATH=/miniconda/bin:${PATH}

# Install Jupyter
RUN conda update -y conda && \
	conda install -y -c conda-forge jupyterlab
RUN mkdir /.local && \
	chown ${USER_ID} /.local

# ========== Install Julia ==========

RUN curl -LO ${JULIA_URL}/julia-${JULIA_VER}-linux-x86_64.tar.gz && \
	tar -xf julia-${JULIA_VER}-linux-x86_64.tar.gz && \
	rm -rf julia-${JULIA_VER}-linux-x86_64.tar.gz && \
	ln -s /julia-${JULIA_VER}/bin/julia /usr/local/bin/julia
RUN mkdir /.julia && chown ${USER_ID} /.julia

# ========== Add application user ==========

RUN useradd --no-log-init --system --uid ${USER_ID} \
	--create-home --shell /bin/bash julia-user

USER ${USER_NAME}

# ========== Install IJulia as application user ==========

ADD julia /_dev
RUN julia /_dev/julia-docker/install_packages.jl

RUN jupyter notebook --generate-config -y
RUN echo "c.NotebookApp.token = '7u%OV1xWG&7m'" >> /root/.jupyter/jupyter_notebook_config.py
RUN echo "c.NotebookApp.disable_check_xsrf = True" >> /root/.jupyter/jupyter_notebook_config.py
