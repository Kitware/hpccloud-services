# Development workflow

### Nvidia runtime and Docker 19.03

The nvidia runtime is only supported on Linux, not Mac or Windows. If you start with Docker 19.03, nvidia gpus are supported by default, by doing `docker run --gpus all`. However, it doesn't support the older plugin syntax `docker run --runtime=nvidia`, and docker-compose doesn't support the `--gpus` arg yet. Here's the [steps to make it work](https://github.com/docker/compose/issues/6691#issuecomment-525245786)
* `sudo apt-get install nvidia-container-runtime`
* Add a daemon config file:
```
sudo tee /etc/docker/daemon.json <<EOF
{
    "runtimes": {
        "nvidia": {
            "path": "/usr/bin/nvidia-container-runtime",
            "runtimeArgs": []
        }
    }
}
EOF
sudo pkill -SIGHUP dockerd
```
* Defaults to using all gpus, but the [env var](https://github.com/NVIDIA/nvidia-container-runtime#environment-variables-oci-spec) `NVIDIA_VISIBLE_DEVICES` can change it.

### Complete PyFR walkthrough

Clone the repo and start the containers as in the [readme][Readme.md].
* If you've made changes to the dockerfiles, rebuild the containers:
  * `docker-compose up -d --build`
* Check the logs
  * `docker logs hpccloud-services_ansible_1` and `docker-compose logs ansible` are roughly equivalent
  * `docker logs -f hpccloud-services_ansible_1` will follow the log, showing output from an active container.

Start a simulation, and visualize
* Login as demo/letmein
* Start a project using the `+`
  * any name you like
  * Type: PyFR
  * Mesh: couette_flow_2d.msh (from `sample_data` folder)
  * Ini: couette_flow_2d.ini (from `sample_data` folder)
  * Click 'Create Project'
* Start a simulation using the `+`
  * any name you like
  * Ini: leave blank, it will using the one from the project
* Set simulation params
  * Click on the simulation summary line in the list
  * click `Input`, `Solver`,
    * Now default: change `Shock capturing` to `none`
    * Now default: change `Final time` to `1.0` or similar, for shorter runtime.
  * click `Simulation` on the left
    * Leave all defaults (unless intend to run on AWS, then `Server Type` becomes `EC2`)
    * click `run simulation`
* Monitor simulation
  * `Jobs` shows the running sim. Gear icon expands to show details and logs
  * expect `complete(6) running (2)` while the main sim is running, for a few minutes. Then output is uploaded.
  * Final will show `complete (12)` and `Output Files files(29)`
  * click `Visualize`
* ParaViewWeb Visualizer
  * leave default params, click `Start visualization`
  * Should show `Jobs complete(4) running(2)`, click `Visualize`
  * Visualizer shows a single slice with simulation data over time.
    * click `couette_flow_2d` and change from `solid color` to `(p2) Velocity`
    * on colormap, click gear then double arrow on left, and clock at the bottow, to get data range over all time steps.
    * in titlebar, click play icon to see animation of flow over time.
      * nvidia runtime should animate noticably faster.

### Useful commands
* `docker container ls` shows running containers
* `docker image ls` shows the images containers are launched from, including intermediates
* `docker volume ls` shows shared volumes
build images:
* `docker-compose up -d --build`
  * builds all images in the `docker-compose.xml`, using caching.
* `docker build --rm --no-cache --file docker/celery/Dockerfile -t kitware/hpccloud:celery .`
  * builds a single image, tags with the same tag as above command, no-cache forces a complete rebuild
  * celery is not in the top-level `docker-compose.xml`, so when it's dockerfile is changed, it needs to be built manually.
access containers:
* `docker run --rm --entrypoint bash -ti 84d3be2cfd70`
  * start the container, over-ride the entrypoint so you get a command prompt. On windows gitbash, add `winpty` in front if needed.
* `docker exec -ti hpccloud-services_command_1 bash`
  * get a command prompt for an already-running container.
clean start:
* `docker-compose down`
* `docker volume prune`, say `y`es
  * removes the persistent volumes not in use by containers, so if all containers are stopped, removes everything.
  * this resets the girder storage, so you have to re-create the project and simulation from scratch, as described above
  * I've needed this a few times when the ansible container says `FAILED The error was: 'dict object' has no attribute '_id'` on the `Wait for compute cluster` step.
  * Useful tool, [lazydocker](https://github.com/jesseduffield/lazydocker)

### Troubleshooting
Ansible
* after `docker-compose up`, checking `docker-compose logs ansible` is critical, to make sure ansible has completed the configuration of all containers.
  * use `docker volume prune` if the logs says `FAILED The error was: 'dict object' has no attribute '_id'` on the `Wait for compute cluster` step.
