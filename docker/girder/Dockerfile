FROM girder/girder:latest-py3
LABEL maintainer="patrick.oleary@kitware.com" \
      version="1.0"

# Install cumulus
RUN git clone https://github.com/Kitware/cumulus.git /cumulus && \
  cd /cumulus && \
  git checkout master && \
  cd / && \
  pip install --no-cache-dir -r /cumulus/requirements.txt && \
  pip install --no-cache-dir -e /cumulus && \
  pip install --no-cache-dir -e /cumulus/girder/cumulus && \
  pip install --no-cache-dir -e /cumulus/girder/sftp && \
  pip install --no-cache-dir -e /cumulus/girder/taskflow

# Set the broker URL
RUN sed -i s/localhost/rabbitmq/g /cumulus/cumulus/celery/commonconfig.py

COPY ./docker/girder/config.json /cumulus/cumulus/conf/config.json

# Enable proxy support
COPY ./docker/girder/girder.local.conf /etc/girder.cfg

# temp cache- buster when repo is changed.
RUN echo 'test1' > testx && rm testx && \
  git clone https://github.com/Kitware/HPCCloud.git /hpccloud && \
  cd /hpccloud && \
  git checkout master

# Install hpccloud - girder server
RUN pip install --no-cache-dir -r /hpccloud/requirements.txt && \
  pip install --no-cache-dir -e /hpccloud/server/hpccloud && \
  pip install --no-cache-dir -e /hpccloud/server/pvwproxy

# Install clean up
RUN apt-get clean && rm -rf /var/lib/apt/lists/*
