# Build cumulus and copy HPCCloud tasks

``
docker build --pull -f docker/celery/Dockerfile .
docker images
docker tag [IMAGE ID] olearypatrick/hpccloud:celery
docker push olearypatrick/hpccloud:celery
``