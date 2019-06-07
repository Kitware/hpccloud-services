# Build ParaView 5.6.0

``
docker build --pull -f docker/visualize-osmesa/Dockerfile .
docker images
docker tag [IMAGE ID] olearypatrick/hpccloud:visualize-osmesa
docker push olearypatrick/hpccloud:visualize-osmesa
``