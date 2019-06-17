# Build nginx

``
docker build --pull -f docker/apache/Dockerfile .
docker images
docker tag [IMAGE ID] kitware/hpccloud:apache
docker push kitware/hpccloud:apache
``