# Docker file for compute PyFR 1.8.0

ARG BASE_IMAGE=kitware/hpccloud:slurm-ssh

FROM ${BASE_IMAGE}
LABEL maintainer="patrick.oleary@kitware.com" \
      version="1.0" \
      pyfr.version="1.8.0"

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        gcc-6 \
        g++-6 \
        g++-6-multilib \
        gfortran-6 \
        openmpi-bin \
        libopenmpi-dev \
        libopenblas-dev \
        liblapack-dev \
        libhdf5-dev \
        libmetis-dev \
        strace \
        unzip \
        wget && \
    update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-6 60 \
                        --slave /usr/bin/g++ g++ /usr/bin/g++-6 \
                        --slave /usr/bin/gfortran gfortran /usr/bin/gfortran-6 && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

RUN pip3 install appdirs \
                 numpy \
                 pytools \
                 mako \
                 gimmik \
                 mpmath \
                 mpi4py \
                 h5py

# Install PyFR 1.8.0
RUN wget -q -O PyFR-1.8.0.zip https://github.com/PyFR/PyFR/archive/v1.8.0.zip && \
    unzip -qq PyFR-1.8.0.zip && \
    cd PyFR-1.8.0 && \
    python3 setup.py install
