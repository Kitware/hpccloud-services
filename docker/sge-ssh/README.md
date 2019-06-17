# Build sge + ssh

``
docker build --pull -f docker/sge-ssh/Dockerfile .
docker images
docker tag [IMAGE ID] kitware/hpccloud:sge-ssh
docker push kitware/hpccloud:sge-ssh
``