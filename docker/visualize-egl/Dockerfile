# Docker file for visualize EGL ParaView 5.6.0
#
# Build options
#
#   PARAVIEW_TAG
#
#     "master", "v5.6.0", <branch-name>, etc...
#
#   SUPERBUILD_REPO
#
#     allows cloning from a fork
#
#   SUPERBUILD_TAG
#
#     "master", "v5.6.0", <branch-name>, etc...
#

FROM kitware/hpccloud:nvidia-slurm-ssh

LABEL maintainer="patrick.oleary@kitware.com" \
      version="1.0" \
      ParaView.version="5.6.0"

ARG PARAVIEW_TAG=v5.7.0-RC1
ARG SUPERBUILD_TAG=v5.7.0-RC1
ARG SUPERBUILD_REPO=https://gitlab.kitware.com/paraview/paraview-superbuild.git

RUN apt-get update && apt-get install -y --no-install-recommends \
        autoconf \
        automake \
        build-essential \
        ca-certificates \
        chrpath \
        curl \
        gfortran \
        git \
        libtool \
        mpich \
        openssl \
        python2.7-dev \
        python-pip \
        python-setuptools \
        pkg-config \
        wget && \
    rm -rf /var/lib/apt/lists/* && \
    python2 -m pip install mako

RUN mkdir -p /home/demo/cmake/3.13.4 && \
    mkdir -p /home/demo/pvsb/longerpathlongerpathlongerpathlongerpath/build

COPY ./docker/visualize-egl/cmake/Docker-Ubuntu-18_04.cmake /home/demo/pvsb/Docker-Ubuntu-18_04.cmake

# Get CMake, then clone the ParaView superbuild project
RUN cd /home/demo/cmake/3.13.4 && \
    curl -L https://cmake.org/files/v3.13/cmake-3.13.4-Linux-x86_64.tar.gz | tar --strip-components=1 -xzv && \
    cd /home/demo/pvsb/longerpathlongerpathlongerpathlongerpath && \
    git clone --recursive ${SUPERBUILD_REPO} src && \
    cd src && git checkout ${SUPERBUILD_TAG} && git submodule update && cd .. && \
    cd build && \
    /home/demo/cmake/3.13.4/bin/cmake -C /home/demo/pvsb/Docker-Ubuntu-18_04.cmake "-GUnix Makefiles" ../src && \
    make -j"$(nproc)" install && \
    rm -rf /home/demo/pvsb && rm -rf /home/demo/cmake

WORKDIR /opt/paraview

EXPOSE 9090
