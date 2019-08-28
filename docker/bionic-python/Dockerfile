# Docker file for 18.04 Ubuntu with 3.6 Python
#
# To replace basic Ubuntu image with one ready for NVidia egl
# builds, specify the BASE_IMAGE build argument when building:
#
#   docker build --build-arg BASE_IMAGE=nvidia/opengl:1.0-glvnd-devel-ubuntu18.04 -t kitware/hpccloud:nvidia-bionic-python .
#

ARG BASE_IMAGE=ubuntu:18.04

FROM ${BASE_IMAGE}

LABEL maintainer="patrick.oleary@kitware.com" \
      version="1.0"

RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    git \
    locales \
    python3.6 \
    python3-dev \
    python3-setuptools \
    python3-pip && \
    update-alternatives --install /usr/bin/python python /usr/bin/python3 1 && \
    locale-gen en_US.UTF-8 && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Add LANG default to en_US.UTF-8
ENV LANGUAGE en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LC_ALL en_US.UTF-8

RUN pip3 install supervisor && \
    mkdir /var/log/supervisor && \
    chmod 0777 /var/log/supervisor

# overwrite this with 'CMD []' in a dependent Dockerfile
CMD ["/bin/bash"]
