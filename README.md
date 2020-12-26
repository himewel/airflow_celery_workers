# Airflow Celery Workers

This repo contains a setup to config Airflow 2.0 with Celery workers. To do it, two databases (Postgres and Redis) are setup: Postgres as the scheduler and webserver auxiliar; and Redis as the broker database and connection between the scheduler and workers. Besides the two databases and workers containers, the scheduler and other two UIs are setup in containers: Airflow Webserver UI (at port 8080) and Airflow Flower UI (at port 5555).

## How to use

Locally, just build up the docker containers and set the desired number of workers. The following code example set 4 celery workers:

```bash
docker-compose up -d --scale worker=4
```

To build up only one worker, you can run the following command:

```bash
docker-compose up -d
```

By default, you can access the Airflow Webserver UI in `http://localhost:8080` and the Airflow Flower UI in `http://localhost:5555/flower/`. In GCP virtual machines, you will need setup a proxy like nginx to redirect the addresses to the ports 80 or 443 and then get access to the UI by the external IP. By running `server_config.bash` script, the dependencies like Docker, Nginx, StackDriver Agent and proxy configs are setted with the external IP of the machine:

```bash
sudo bash server_config.bash
sudo docker-compose up -d --scale worker=4
```

So, if your VM has an external IP like `123.456.789.101` you will get access to the UIs in `http://123.456.789.101` and `http://123.456.789.101/flower/`. Don't forget to enable the http access in the machine settings. By default, the UIs can be accessed with login `admin` and password `admin`. You can can set better credentials in the `docker-compose.yaml` file in `x-default-user` section.

![](img/airflow.png)

![](img/flower.png)

![](img/flower_monitor.png)
