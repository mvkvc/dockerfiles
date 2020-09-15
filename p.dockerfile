#docker build . -f dl.dockerfile -t "gcr.io/dl-comp/p:latest"
#docker push "gcr.io/dl-comp/p:latest"
#docker run --gpus all -p 8888:8888 gcr.io/dl-comp/p:latest jupyter lab \
#       --allow-root \
#       --ip=0.0.0.0 \
#       --no-browser

FROM gcr.io/deeplearning-platform-release/pytorch-gpu

EXPOSE 8888
USER root

WORKDIR /

COPY requirements.txt /tmp/
RUN python3 -m pip install -r /tmp/requirements.txt

RUN jupyter notebook --generate-config -y
RUN echo "c.NotebookApp.token = '7u%OV1xWG&7m'" >> /root/.jupyter/jupyter_notebook_config.py
RUN echo "c.NotebookApp.disable_check_xsrf = True" >> /root/.jupyter/jupyter_notebook_config.py

# ADD https://github.com/krallin/tini/releases/download/v0.14.0/tini /tini
# RUN chmod +x /tini
# ENTRYPOINT ["/tini", "--"]
# CMD ["jupyter-notebook", "--ip=0.0.0.0", "--allow-root", "--no-browser", "--port=8888"]
