# Build ParFlow master

``
docker build --pull -f docker/compute-parflow/Dockerfile .
docker images
docker tag [IMAGE ID] kitware/hpccloud:compute-parflow
docker push kitware/hpccloud:compute-parflow
``