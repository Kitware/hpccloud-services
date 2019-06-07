# Build nginx

``
docker build --pull -f docker/nginx/Dockerfile .
docker images
docker tag [IMAGE ID] olearypatrick/hpccloud:nginx
docker push olearypatrick/hpccloud:nginx
``