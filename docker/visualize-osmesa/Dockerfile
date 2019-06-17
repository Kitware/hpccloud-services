# Docker file for visualize OSMesa ParaView 5.6.0

FROM kitware/hpccloud:sge-ssh
LABEL maintainer="patrick.oleary@kitware.com" \
      version="1.0" \
      ParaView.version="5.6.0"

RUN apt-get update && \
    apt-get install -y build-essential \
                       gcc-6 \
                       g++-6 \
                       g++-6-multilib \
                       gfortran-6 \
                       openmpi-bin \
                       libopenmpi-dev \
                       strace \
                       wget \
                       --no-install-recommends && \
    update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-6 60 \
                        --slave /usr/bin/g++ g++ /usr/bin/g++-6 \
                        --slave /usr/bin/gfortran gfortran /usr/bin/gfortran-6

# Install ParaView 5.6.0
RUN wget -q -O ParaView-5.6.0.tar.xz https://www.paraview.org/files/v5.6/ParaView-5.6.0-osmesa-MPI-Linux-64bit.tar.xz && \
    tar xf ParaView-5.6.0.tar.xz && \
    mv ParaView-5.6.0-osmesa-MPI-Linux-64bit ParaView

EXPOSE 9090

RUN apt-get clean && rm -rf /var/lib/apt/lists/*