# Docker file for visualize OSMesa ParaView 5.6.0

FROM kitware/hpccloud:slurm-ssh
LABEL maintainer="patrick.oleary@kitware.com" \
      version="1.0" \
      ParaView.version="5.6.0"

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        curl \
        mpich \
        wget && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Install ParaView 5.6.0
RUN wget -q -O ParaView-5.6.1.tar.xz https://www.paraview.org/files/v5.6/ParaView-5.6.1-osmesa-MPI-Linux-64bit.tar.xz && \
    tar xf ParaView-5.6.1.tar.xz && \
    mv ParaView-5.6.1-osmesa-MPI-Linux-64bit ParaView

EXPOSE 9090
