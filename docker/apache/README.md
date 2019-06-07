# Build nginx

``
docker build --pull -f docker/apache/Dockerfile .
docker images
docker tag [IMAGE ID] olearypatrick/hpccloud:apache
docker push olearypatrick/hpccloud:apache
``