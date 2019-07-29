ARG BASE_IMAGE=kitware/hpccloud:bionic-python
FROM ${BASE_IMAGE}

LABEL maintainer="patrick.oleary@kitware.com" \
      version="1.0"

RUN adduser --system celery

# Install cumulus
RUN git clone https://github.com/Kitware/cumulus.git /cumulus && \
  cd /cumulus && \
  # git checkout v1.0.0 && \
  cd /

# TEMP cumulus fix - requirements.txt needs to be updated for AWS, in progress.
# COPY ./cumulus/cumulus/girderclient.py /cumulus/cumulus/girderclient.py
COPY ./cumulus/cumulus/ansible/tasks/cluster.py /cumulus/cumulus/ansible/tasks/cluster.py
COPY ./cumulus/cumulus/ansible/tasks/playbooks/library/girder.py /cumulus/cumulus/ansible/tasks/playbooks/library/girder.py
COPY ./cumulus/cumulus/ansible/tasks/playbooks/roles/ec2-pod/defaults/main.yml /cumulus/cumulus/ansible/tasks/playbooks/roles/ec2-pod/defaults/main.yml
COPY ./cumulus/cumulus/ansible/tasks/playbooks/roles/ec2-pod/tasks/launch.yml /cumulus/cumulus/ansible/tasks/playbooks/roles/ec2-pod/tasks/launch.yml
COPY ./cumulus/requirements.txt /cumulus/requirements.txt
RUN  cd / && pip install --no-cache-dir -r /cumulus/requirements.txt && \
  pip install --no-cache-dir -e /cumulus && \
  pip install --no-cache-dir girder

# Set the broker URL
RUN sed -i s/localhost/rabbitmq/g /cumulus/cumulus/celery/commonconfig.py

RUN mkdir /keys && chown -R celery  /keys

COPY ./docker/celery/config.json /cumulus/cumulus/conf/config.json

RUN chown -R celery  /cumulus

RUN git clone https://github.com/Kitware/HPCCloud.git /hpccloud && \
  cd /hpccloud && \
  git checkout master

# Change ownership
RUN chown -R celery  /hpccloud
