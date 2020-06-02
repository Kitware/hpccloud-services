# Docker file for compute Parflow

ARG BASE_IMAGE=kitware/hpccloud:slurm-ssh

FROM ${BASE_IMAGE}
LABEL maintainer="patrick.oleary@kitware.com" \
      version="1.0" \
      parflow.version="master"

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        wget \
        gcc-6 \
        g++-6 \
        g++-6-multilib \
        gfortran-6 \
        libopenblas-dev \
        liblapack-dev \
        openssh-client \
        openssh-server \
        openmpi-bin \
        libopenmpi-dev \
        tcl-dev \
        tk-dev \
        cmake \
        cmake-curses-gui && \
    update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-6 60 \
                        --slave /usr/bin/g++ g++ /usr/bin/g++-6 \
                        --slave /usr/bin/gfortran gfortran /usr/bin/gfortran-6 && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Allow root to mpiexec (not in current openmpi version for Ubuntu 18.04)
#ENV OMPI_ALLOW_RUN_AS_ROOT=1
#ENV OMPI_ALLOW_RUN_AS_ROOT_CONFIRM=1

# ParFlow environment variables
ENV HYPRE_DIR=/hypre
ENV PARFLOW_DIR=/parflow

# Install hypre
RUN wget -q https://github.com/hypre-space/hypre/archive/v2.17.0.tar.gz && \
    tar xf v2.17.0.tar.gz && \
    cd hypre-2.17.0/src && \
    ./configure --prefix=/hypre --with-MPI && \
    make install && \
    cd / && \
    rm -fr hypre-2.17.0 v2.17.0.tar.gz

# Intall parflow
RUN git clone -b master --single-branch https://github.com/parflow/parflow.git /parflow-tmp

ENV PARFLOW_MPIEXEC_EXTRA_FLAGS "--mca mpi_yield_when_idle 1 --oversubscribe --allow-run-as-root"

RUN mkdir -p /build && \
    cd /build && \
    cmake ../parflow-tmp \
       -DPARFLOW_AMPS_LAYER=mpi1 \
       -DPARFLOW_AMPS_SEQUENTIAL_IO=TRUE \
       -DHYPRE_ROOT=/hypre \
       -DPARFLOW_ENABLE_TIMING=TRUE \
       -DPARFLOW_HAVE_CLM=TRUE \
       -DCMAKE_INSTALL_PREFIX=/parflow && \
    make install && \
    cd / && \
    rm -fr /parflow-tmp /build
