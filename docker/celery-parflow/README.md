# Build ParFlow master

``
docker build --pull -f docker/celery-parflow/Dockerfile .
docker images
docker tag [IMAGE ID] kitware/hpccloud:celery-parflow
docker push kitware/hpccloud:celery-parflow
``