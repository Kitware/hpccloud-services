# Build slurm + ssh

``
docker build --pull -f docker/slurm-ssh/Dockerfile .
docker images
docker tag [IMAGE ID] kitware/hpccloud:slurm-ssh
docker push kitware/hpccloud:slurm-ssh
``
