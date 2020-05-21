# Docker file for sge + ssh
#
# To base resulting image off a different base image, use the "BASE_IMAGE"
# build argument:
#
#   docker build --build-arg BASE_IMAGE=kitware/hpccloud:nvidia-bionic-python -t kitware/hpccloud:nvidia-sge-ssh .
#

ARG BASE_IMAGE=kitware/hpccloud:bionic-python

FROM ${BASE_IMAGE}
LABEL maintainer="patrick.oleary@kitware.com" \
      version="1.0"

ENV SGEMASTER=sge-master

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        openssh-client \
        openssh-server \
        curl && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

RUN mkdir /var/run/sshd && \
    chmod 0755 /var/run/sshd && \
    sed -ri 's/UsePAM yes/UsePAM no/g' /etc/ssh/sshd_config

COPY ./docker/sge-ssh/sge-config /sge-config
COPY ./docker/sge-ssh/patch/* /tmp/

RUN echo "$(grep "$HOSTNAME" /etc/hosts | awk '{print $1;}') $SGEMASTER" >> /etc/hosts && \
    echo "domain $SGEMASTER" >> /etc/resolv.conf && \
    echo "gridengine-master shared/gridenginemaster string  $SGEMASTER" | debconf-set-selections && \
    echo "gridengine-master shared/gridenginecell   string  default"    | debconf-set-selections && \
    echo "gridengine-master shared/gridengineconfig boolean false"      | debconf-set-selections && \
    echo "gridengine-common shared/gridenginemaster string  $SGEMASTER" | debconf-set-selections && \
    echo "gridengine-common shared/gridenginecell   string  default"    | debconf-set-selections && \
    echo "gridengine-client shared/gridenginemaster string  $SGEMASTER" | debconf-set-selections && \
    echo "gridengine-client shared/gridenginecell   string  default"    | debconf-set-selections && \
    echo "gridengine-client shared/gridengineconfig boolean false"      | debconf-set-selections && \
    apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y gridengine-master gridengine-exec gridengine-client && \
    apt-get clean && rm -rf /var/lib/apt/lists/* && \
    # The next 5 lines patch broken Ubuntu gridengine packages, ala:
    #   https://bugs.launchpad.net/ubuntu/+source/gridengine/+bug/1633251
    # and:
    #   https://bugs.launchpad.net/ubuntu/+source/gridengine/+bug/1774302
    cp /tmp/spooldefaults.bin /usr/lib/gridengine/ && \
    cp /tmp/libspoolb.so /usr/lib/gridengine/ && \
    cp /tmp/libspoolc.so /usr/lib/gridengine/ && \
    cd /usr/lib/x86_64-linux-gnu && \
    ln -s libjemalloc.so.1 libjemalloc.so.2 && \
    su -c "/usr/share/gridengine/scripts/init_cluster /var/lib/gridengine default /var/spool/gridengine/spooldb sgeadmin" -s /bin/bash sgeadmin && \
    echo $SGEMASTER | tee /var/lib/gridengine/default/common/act_qmaster && \
    chown -R sgeadmin:sgeadmin /var/lib/gridengine/default/common/act_qmaster && \
    service gridengine-master restart && \
    sleep 1 && \
    qconf -as $SGEMASTER && \
    qconf -Msconf /sge-config/config-scheduler && \
    qconf -Ahgrp /sge-config/config-hostlist && \
    qconf -Aq /sge-config/config-queue && \
    /sge-config/addworker.sh compute.q $SGEMASTER 1 && \
    update-rc.d gridengine-master enable && \
    service gridengine-exec restart && \
    update-rc.d gridengine-exec enable

EXPOSE 22
EXPOSE 6444
EXPOSE 6445
EXPOSE 6446

# Download the docker client and set it up
ENV DOCKERVERSION=18.03.1-ce
RUN curl -fsSLO https://download.docker.com/linux/static/stable/x86_64/docker-${DOCKERVERSION}.tgz \
  && tar xzvf docker-${DOCKERVERSION}.tgz --strip 1 \
                 -C /usr/local/bin docker/docker \
  && rm docker-${DOCKERVERSION}.tgz \
  && groupadd docker

RUN useradd -p $(openssl passwd -1 letmein) --create-home --shell /bin/bash --groups sudo demo
USER demo
RUN mkdir /home/demo/.ssh && \
    chmod 700 /home/demo/.ssh/ && \
    touch /home/demo/.ssh/authorized_keys && \
    chmod 600 /home/demo/.ssh/authorized_keys
USER root

RUN echo 'root:please' | chpasswd

RUN mkdir /scratch && \
    chmod 777 /scratch

COPY ./docker/sge-ssh/entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]

COPY ./docker/sge-ssh/supervisord.conf /etc/supervisord.conf

CMD ["/usr/local/bin/supervisord", "-c", "/etc/supervisord.conf"]

# RUN apt-get clean && rm -rf /var/lib/apt/lists/*
