# Build nginx

``
docker build --pull -f docker/nginx/Dockerfile .
docker images
docker tag [IMAGE ID] kitware/hpccloud:nginx
docker push kitware/hpccloud:nginx
``