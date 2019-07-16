# HPCCloud Services

### Goal

Streamline a test deployment environment.

## Running it

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

[Developent workflow][dev_workflow.md] has more complete instructions on troubleshooting and manual testing.
