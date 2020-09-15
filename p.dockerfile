FROM gcr.io/deeplearning-platform-release/pytorch-gpu

EXPOSE 8888
USER root
WORKDIR /

# ADD https://github.com/krallin/tini/releases/download/v0.14.0/tini /tini
# RUN chmod +x /tini

ADD python /_dev

RUN pip install pytorch-lightning

RUN jupyter notebook --generate-config -y
RUN echo "c.NotebookApp.token = '7u%OV1xWG&7m'" >> /root/.jupyter/jupyter_notebook_config.py
RUN echo "c.NotebookApp.disable_check_xsrf = True" >> /root/.jupyter/jupyter_notebook_config.py

# ENTRYPOINT ["/tini", "--"]
# CMD ["jupyter-notebook", "--ip=0.0.0.0", "--allow-root", "--no-browser", "--port=8888"]
