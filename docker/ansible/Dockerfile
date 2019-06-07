FROM python:3.6-slim

RUN apt-get update && apt-get -y install \
  git \
  sshpass


RUN pip install ansible && \
  pip install girder_client

WORKDIR /ansible

COPY ./docker/ansible/entrypoint.sh /entrypoint.sh
COPY ./docker/ansible/wait-for-it.sh /wait-for-it.sh


ENTRYPOINT ["/wait-for-it.sh", "-t", "30", "girder:8080",  "--", "/entrypoint.sh"]

RUN apt-get clean && rm -rf /var/lib/apt/lists/*