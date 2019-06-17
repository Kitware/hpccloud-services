# Build ansible

``
docker build --pull -f docker/ansible/Dockerfile .
docker images
docker tag [IMAGE ID] kitware/hpccloud:ansible
docker push kitware/hpccloud:ansible
``