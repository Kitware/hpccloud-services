# Docker file for 18.04 Ubuntu with 3.6 Python

ARG UBUNTU_VERSION=18.04
ARG PYTHON_VERSION=3.6

FROM ubuntu:${UBUNTU_VERSION}

LABEL maintainer="patrick.oleary@kitware.com" \
      version="1.0"

# Add LANG default to en_US.UTF-8
ENV LANG en_US.UTF-8

FROM python:${PYTHON_VERSION}

RUN pip install supervisor && \
    mkdir /var/log/supervisor && \
    chmod 0777 /var/log/supervisor

# overwrite this with 'CMD []' in a dependent Dockerfile
CMD ["/bin/bash"]