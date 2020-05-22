ARG BASE_IMAGE=kitware/hpccloud:bionic-python

#################
# slurm section #
#################
FROM ${BASE_IMAGE} as slurm
LABEL maintainer="patrick.avery@kitware.com" \
      version="1.0"

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
      slurm-wlm && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Make a directory for slurm spool
RUN mkdir /var/spool/slurm-llnl && chown -R slurm:slurm /var/spool/slurm-llnl

COPY docker/slurm-ssh/slurm/slurm.conf /etc/slurm-llnl/slurm.conf

COPY docker/slurm-ssh/slurm/entrypoint.sh /entrypoint.sh

ENTRYPOINT /entrypoint.sh

#########################################
# ssh section, with the demo user added #
#########################################
FROM slurm
LABEL maintainer="patrick.avery@kitware.com" \
      version="1.0"

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        openssh-client \
        openssh-server \
        curl && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

RUN mkdir /var/run/sshd && \
    chmod 0755 /var/run/sshd && \
    sed -ri 's/UsePAM yes/UsePAM no/g' /etc/ssh/sshd_config

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

COPY docker/slurm-ssh/supervisord.conf /etc/supervisord.conf

ENTRYPOINT  ["/entrypoint.sh"]
CMD ["/usr/local/bin/supervisord", "-c", "/etc/supervisord.conf"]
