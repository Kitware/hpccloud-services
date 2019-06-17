FROM girder/girder:2.x-maintenance-py3
LABEL maintainer="patrick.oleary@kitware.com" \
      version="1.0"

# Install cumulus
RUN git clone https://github.com/Kitware/cumulus.git /cumulus && \
  cd /cumulus && \
  git checkout 0.9-maintenance && \
  cd / && \
  pip install --no-cache-dir -r /cumulus/requirements.txt && \
  pip install --no-cache-dir -e /cumulus && \
  girder-install plugin /cumulus/girder/cumulus && \
  girder-install plugin /cumulus/girder/sftp && \
  girder-install plugin /cumulus/girder/taskflow

# Set the broker URL
RUN sed -i s/localhost/rabbitmq/g /cumulus/cumulus/celery/commonconfig.py

COPY ./docker/girder/config.json /cumulus/cumulus/conf/config.json

# Enable proxy support
COPY ./docker/girder/girder.local.conf /girder/girder/conf/girder.local.cfg

RUN git clone https://github.com/Kitware/HPCCloud.git /hpccloud

# Install hpccloud - girder server
RUN pip  install --no-cache-dir -r /hpccloud/requirements.txt && \
  girder-install plugin /hpccloud/server/hpccloud && \
  girder-install plugin /hpccloud/server/pvwproxy

# Install clean up
RUN apt-get clean && rm -rf /var/lib/apt/lists/*
