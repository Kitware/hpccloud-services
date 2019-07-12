FROM node:10 AS build

RUN echo 'test1' > testx && rm testx && \
  git clone https://github.com/Kitware/HPCCloud.git /hpccloud && \
  cd /hpccloud && \
  git checkout master && \
  npm install && \
  npm run build:release

FROM nginx

COPY --from=build /hpccloud/dist /usr/share/nginx/html
RUN rm /etc/nginx/conf.d/default.conf
COPY docker/nginx/nginx.girder.conf /etc/nginx/conf.d/girder.conf
