# Build celery + pyfr 1.8.0

``
docker build --pull -f docker/celery-pyfr/Dockerfile .
docker images
docker tag [IMAGE ID] kitware/hpccloud:celery-pyfr
docker push kitware/hpccloud:celery-pyfr
``

# Testing PyFR installation

``
mkdir inc_cylinder_2d
cp PyFR-1.8.0/examples//inc_cylinder_2d/inc_cylinder_2d.ini inc_cylinder_2d/
cp PyFR-1.8.0/examples/inc_cylinder_2d/inc_cylinder_2d.msh.gz inc_cylinder_2d/
cd inc_cylinder_2d/
zcat inc_cylinder_2d.msh.gz | pyfr import -tgmsh - inc_cylinder_2d.pyfrm
pyfr run -b openmp -p inc_cylinder_2d.pyfrm inc_cylinder_2d.ini
pyfr export inc_cylinder_2d.pyfrm ./cylinder_2d_75.00.pyfrs cylinder_2d-75.00.vtu -d 4
``