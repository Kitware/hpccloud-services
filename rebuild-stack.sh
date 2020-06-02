#!/bin/bash

PROJECT_DIRECTORY="$(dirname $0)"

# Exit as soon as any of these builds fail
set -e

# Rebuilding docker images.  First change to the root of the project:

cd "${PROJECT_DIRECTORY}"

#----------------------------------------------------------------------------
#                               bionic-python
#----------------------------------------------------------------------------

echo -e "\n\n\nBuilding kitware/hpccloud:bionic-python \n\n\n"
docker build --pull --rm --no-cache --file docker/bionic-python/Dockerfile -t kitware/hpccloud:bionic-python .

echo -e "\n\n\nBuilding kitware/hpccloud:nvidia-bionic-python \n\n\n"
docker build --pull --rm --no-cache --file docker/bionic-python/Dockerfile --build-arg BASE_IMAGE=nvidia/opengl:1.0-glvnd-devel-ubuntu18.04 -t kitware/hpccloud:nvidia-bionic-python .

#----------------------------------------------------------------------------
#                                  slurm-ssh
#----------------------------------------------------------------------------

echo -e "\n\n\nBuilding kitware/hpccloud:slurm-ssh \n\n\n"
docker build --rm --no-cache --file docker/slurm-ssh/Dockerfile -t kitware/hpccloud:slurm-ssh .

echo -e "\n\n\nBuilding kitware/hpccloud:nvidia-slurm-ssh \n\n\n"
docker build --rm --no-cache --file docker/slurm-ssh/Dockerfile --build-arg BASE_IMAGE=kitware/hpccloud:nvidia-bionic-python -t kitware/hpccloud:nvidia-slurm-ssh .

#----------------------------------------------------------------------------
#                              visualize-osmesa
#----------------------------------------------------------------------------

echo -e "\n\n\nBuilding kitware/hpccloud:visualize-osmesa \n\n\n"
docker build --rm --no-cache --file docker/visualize-osmesa/Dockerfile -t kitware/hpccloud:visualize-osmesa .

#----------------------------------------------------------------------------
#                              visualize-egl
#----------------------------------------------------------------------------

echo -e "\n\n\nBuilding kitware/hpccloud:visualize-egl \n\n\n"
docker build --rm --no-cache --file docker/visualize-egl/Dockerfile --build-arg PARAVIEW_TAG=v5.6.1 --build-arg SUPERBUILD_TAG=v5.6.1 -t kitware/hpccloud:visualize-egl .

#----------------------------------------------------------------------------
#                                compute-pyfr
#----------------------------------------------------------------------------

echo -e "\n\n\nBuilding kitware/hpccloud:compute-pyfr \n\n\n"
docker build --rm --no-cache --file docker/compute-pyfr/Dockerfile -t kitware/hpccloud:compute-pyfr .

echo -e "\n\n\nBuilding kitware/hpccloud:nvidia-compute-pyfr \n\n\n"
docker build --rm --no-cache --file docker/compute-pyfr/Dockerfile --build-arg BASE_IMAGE=kitware/hpccloud:nvidia-slurm-ssh -t kitware/hpccloud:nvidia-compute-pyfr .

#----------------------------------------------------------------------------
#                                compute-parflow
#----------------------------------------------------------------------------

# echo -e "\n\n\nBuilding kitware/hpccloud:compute-parflow \n\n\n"
# docker build --rm --no-cache --file docker/compute-parflow/Dockerfile -t kitware/hpccloud:compute-parflow .

# echo -e "\n\n\nBuilding kitware/hpccloud:nvidia-compute-parflow \n\n\n"
# docker build --rm --no-cache --file docker/compute-parflow/Dockerfile --build-arg BASE_IMAGE=kitware/hpccloud:nvidia-slurm-ssh -t kitware/hpccloud:nvidia-compute-parflow .

#----------------------------------------------------------------------------
#                                  celery
#----------------------------------------------------------------------------

echo -e "\n\n\nBuilding kitware/hpccloud:celery \n\n\n"
docker build --rm --no-cache --file docker/celery/Dockerfile -t kitware/hpccloud:celery .

#----------------------------------------------------------------------------
#                                celery-pyfr
#----------------------------------------------------------------------------

echo -e "\n\n\nBuilding kitware/hpccloud:celery-pyfr \n\n\n"
docker build --rm --no-cache --file docker/celery-pyfr/Dockerfile -t kitware/hpccloud:celery-pyfr .

#----------------------------------------------------------------------------
#                                celery-parflow
#----------------------------------------------------------------------------

# echo -e "\n\n\nBuilding kitware/hpccloud:celery-parflow \n\n\n"
# docker build --rm --no-cache --file docker/celery-parflow/Dockerfile -t kitware/hpccloud:celery-parflow .

#----------------------------------------------------------------------------
#                                  ansible
#----------------------------------------------------------------------------

echo -e "\n\n\nBuilding kitware/hpccloud:ansible \n\n\n"
docker build --pull --rm --no-cache --file docker/ansible/Dockerfile -t kitware/hpccloud:ansible .

#----------------------------------------------------------------------------
#                                  girder
#----------------------------------------------------------------------------

echo -e "\n\n\nBuilding kitware/hpccloud:girder \n\n\n"
docker build --pull --rm --no-cache --file docker/girder/Dockerfile -t kitware/hpccloud:girder .

#----------------------------------------------------------------------------
#                                  nginx
#----------------------------------------------------------------------------

echo -e "\n\n\nBuilding kitware/hpccloud:nginx \n\n\n"
docker build --pull --rm --no-cache --file docker/nginx/Dockerfile -t kitware/hpccloud:nginx .
