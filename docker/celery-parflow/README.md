# Build ParFlow master

``
docker build --pull -f docker/celery-parflow/Dockerfile .
docker images
docker tag [IMAGE ID] olearypatrick/hpccloud:celery-parflow
docker push olearypatrick/hpccloud:celery-parflow
``

# Testing ParFlow installation

``
cd /parflow/test
make test
``