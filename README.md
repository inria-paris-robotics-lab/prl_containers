# :lab_coat: :microscope: :robot: Paris Robotics Lab containers

This repository provides container configurations for the Paris Robotics Lab software


# :hammer_and_wrench: Install docker

A Docker Engine must be installed with a version higher than 19.03.
See [offical instructions](https://docs.docker.com/engine/install/ubuntu/) for updating your system.

# :house: Start the robot using the docker images

Using the default images is as easy as:

1. Setup environment variables.

Copy the `.env` file into a private local file, such as `.env.local`:

```bash
$ cp .env .env.local
```

Edit it with your own values. For example, you can find your user and group identifiers with:

```bash
$ id -u
1000
$ id -g
1000
```

2. Compose Docker images

`docker compose` allows to split images into multiple services, easing maintenance and debug. Two services will be created here. The first one contains the ROS core, and the second one contains our lab-based packages. 

Simply run the following command:

```
$ docker compose --env-file /path/to/your/.env up -d
``` 

3. Look at logs!

For all logs, you can start:

```
$ docker compose --env-file /path/to/your/.env logs -f
``` 

But, you can get logs from a specific image as:

```
$ docker compose --env-file /path/to/your/.env logs -f prl
``` 

# :houses: Add your own image

Now, you might want to add your own Docker image running your project. For that, you will add a new Dockerfile and modify the file `docker-compose.yaml` to include it.

But, first, you should keep in mind that Docker containers are not persistent by default. If you start an interactive shell,  every modifications done locally will be lost.

If you modify your setup, then you should do it in your Dockerfile, and afterwards rebuild your image using the following command:

```bash
$ docker compose --env-file /path/to/your/.env up -d --force-recraete your-service-name
```

Or, if you can to store data, you can mount volumes. A default volume named `scratch` is already in the `docker-compose.yaml` file. You can connect it a specific location on your disk by setting up the variable `SCRATCH` in your `.env` file. Of course, you can setup other volumes as way, such as your code.
