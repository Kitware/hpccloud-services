# Build ParaView 5.6.0

``
docker build --pull -f docker/visualize-osmesa/Dockerfile .
docker images
docker tag [IMAGE ID] kitware/hpccloud:visualize-osmesa
docker push kitware/hpccloud:visualize-osmesa
``