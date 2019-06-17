# Build HPCCloud girder server

``
docker build --pull -f docker/girder/Dockerfile .
docker images
docker tag [IMAGE ID] kitware/hpccloud:girder
docker push kitware/hpccloud:girder
``