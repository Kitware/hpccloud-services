# Build sge + ssh

``
docker build --pull -f docker/sge-ssh/Dockerfile .
docker images
docker tag [IMAGE ID] olearypatrick/hpccloud:sge-ssh
docker push olearypatrick/hpccloud:sge-ssh
``