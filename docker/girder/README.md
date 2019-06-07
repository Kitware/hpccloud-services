# Build HPCCloud girder server

``
docker build --pull -f docker/girder/Dockerfile .
docker images
docker tag [IMAGE ID] olearypatrick/hpccloud:girder
docker push olearypatrick/hpccloud:girder
``