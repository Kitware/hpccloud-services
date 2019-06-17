# Build Ubuntu 18.04 + Python 3.6 image

``
docker build --pull -f docker/bionic-python/Dockerfile .
docker images
docker tag [IMAGE ID] kitware/hpccloud:bionic-python
docker push kitware/hpccloud:bionic-python
``