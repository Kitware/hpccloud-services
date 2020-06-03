#!/bin/bash

# Uncomment the first two blocks to remove all hpccloud-services
# images and re-pull the latest versions.

# docker image rm kitware/hpccloud:bionic-python
# docker image rm kitware/hpccloud:nvidia-bionic-python
# docker image rm kitware/hpccloud:slurm-ssh
# docker image rm kitware/hpccloud:nvidia-slurm-ssh
# docker image rm kitware/hpccloud:visualize-osmesa
# docker image rm kitware/hpccloud:visualize-egl
# docker image rm kitware/hpccloud:compute-pyfr
# docker image rm kitware/hpccloud:nvidia-compute-pyfr
# docker image rm kitware/hpccloud:celery
# docker image rm kitware/hpccloud:celery-pyfr
# docker image rm kitware/hpccloud:ansible
# docker image rm kitware/hpccloud:girder
# docker image rm kitware/hpccloud:nginx

# docker pull kitware/hpccloud:bionic-python
# docker pull kitware/hpccloud:nvidia-bionic-python
# docker pull kitware/hpccloud:slurm-ssh
# docker pull kitware/hpccloud:nvidia-slurm-ssh
# docker pull kitware/hpccloud:visualize-osmesa
# docker pull kitware/hpccloud:visualize-egl
# docker pull kitware/hpccloud:compute-pyfr
# docker pull kitware/hpccloud:nvidia-compute-pyfr
# docker pull kitware/hpccloud:celery
# docker pull kitware/hpccloud:celery-pyfr
# docker pull kitware/hpccloud:ansible
# docker pull kitware/hpccloud:girder
# docker pull kitware/hpccloud:nginx

# Uncomment the last block to push all the hpccloud-services
# tagged images.

docker push kitware/hpccloud:bionic-python
docker push kitware/hpccloud:nvidia-bionic-python
docker push kitware/hpccloud:slurm-ssh
docker push kitware/hpccloud:nvidia-slurm-ssh
docker push kitware/hpccloud:visualize-osmesa
docker push kitware/hpccloud:visualize-egl
docker push kitware/hpccloud:compute-pyfr
docker push kitware/hpccloud:nvidia-compute-pyfr
docker push kitware/hpccloud:celery
docker push kitware/hpccloud:celery-pyfr
docker push kitware/hpccloud:ansible
docker push kitware/hpccloud:girder
docker push kitware/hpccloud:nginx
