# HPCCloud Services

## Goal

Streamline a test deployment environment.

### Running it

```
git clone https://github.com/Kitware/hpccloud-services.git
cd hpccloud-services
docker-compose up -d
```

Once done, make sure ansible is done configuring the various bits by looking at the following log

```
docker logs -f hpccloud-services_ansible_1
```

At that point you should be able to connect to http://localhost:8888 and login as demo/letmein

If you want to stop the services you can run the command

```
docker-compose down
```

### Running w/ GPU accleration

In order to run compute and visualize containers which can utilize the GPU on your system:

```
docker-compose -f docker-compose.yml -f docker-compose-nvidia.yml up -d
```

This will apply the service overrides found in `docker-compose-nvidia.yml`, which make use of the `nvidia` container runtime.

Note: Docker 19.03 requires [additional setup](https://github.com/docker/compose/issues/6691#issuecomment-525245786) to enable the "runtime" keyword in docker-compose. The nvidia runtime is only available on Linux. [Details][dev_workflow.md].

### Development workflow

[Developent workflow][dev_workflow.md] has more complete instructions on troubleshooting and manual testing.
