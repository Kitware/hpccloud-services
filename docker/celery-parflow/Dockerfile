# Docker file for ParFlow master

FROM kitware/hpccloud:celery
LABEL maintainer="patrick.oleary@kitware.com" \
      version="1.0" \
      parflow.version="master"

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
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
        cmake && \
    update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-6 60 \
                        --slave /usr/bin/g++ g++ /usr/bin/g++-6 \
                        --slave /usr/bin/gfortran gfortran /usr/bin/gfortran-6 && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Allow root to mpiexec (not in current openmpi version for Ubuntu 18.04)
#ENV OMPI_ALLOW_RUN_AS_ROOT=1
#ENV OMPI_ALLOW_RUN_AS_ROOT_CONFIRM=1

# ParFlow environment variables
ENV SILO_DIR=/silo
ENV HYPRE_DIR=/hypre
ENV PARFLOW_DIR=/parflow

# Install silo
RUN curl "https://wci.llnl.gov/content/assets/docs/simulation/computer-codes/silo/silo-4.10.2/silo-4.10.2.tar.gz" -o "silo-4.10.2.tar.gz" && \
    tar -xvf silo-4.10.2.tar.gz && \
    cd /silo-4.10.2 && \
    ./configure --prefix=/silo \
                --disable-silex \
                --disable-hzip \
                --disable-fpzip && \
    make install && \
    cd / && \
    rm -rf silo-4.10.2*

# Install hypre
RUN git clone https://github.com/LLNL/hypre.git hypre-tmp && \
    cd /hypre-tmp/src && \
    ./configure --prefix=/hypre \
                --with-MPI && \
    make install && \
    cd / && \
    rm -rf hypre-tmp

# Intall parflow
RUN git clone https://gitlab.kitware.com/parflow/parflow.git parflow && \
    cd /parflow/pfsimulator && \
    ./configure --prefix=/parflow \
                --with-clm \
                --enable-timing \
                --with-silo=/silo \
                --with-hypre=/hypre \
                --with-amps=mpi1 \
                --with-mpi && \
    make install && \
    cd /parflow/pftools && \
    ./configure --prefix=/parflow \
                --with-silo=/silo \
                --with-amps=mpi1 && \
    make install && \
    cd /

# Allow root to run mpiexec (kludge)
COPY ./docker/celery-parflow/run /parflow/bin/run
