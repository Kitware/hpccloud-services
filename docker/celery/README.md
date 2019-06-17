# Build cumulus and copy HPCCloud tasks

``
docker build --pull -f docker/celery/Dockerfile .
docker images
docker tag [IMAGE ID] kitware/hpccloud:celery
docker push kitware/hpccloud:celery
``