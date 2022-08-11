# :lab_coat: :microscope: :robot: Paris Robotics Lab containers

This repository provides container configurations for the Paris Robotics Lab software


# :hammer_and_wrench: Install docker

A Docker Engine must be installed with a version higher than 19.03.
See [offical instructions](https://docs.docker.com/engine/install/ubuntu/) for updating your system. 

You might also want to install the nvidia runtime as [described here](https://docs.docker.com/config/containers/resource_constraints/#gpu).

If you are using the lab machine, this should already be correctly setup.


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

For details about the `PRL_COMMAND`, see these [instructions](https://github.com/inria-paris-robotic-lab/prl_ur5_robot).

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

# :houses: Add your project

You must keep in mind that Docker containers are not persistent. For example, if you start an interactive shell and install a new package, it will be lost when you close your shell.

Generally, you want to load your code and your data in a container. For that, you can mount volumes into your container. As the data are not stored solely on the Docker container, any modification will be persistent.

A default volume named `scratch` is already in the `docker-compose.yaml` file. You can connect it a specific location on your disk by setting up the variable `SCRATCH` in your `.env` file. Of course, you can setup other volumes as way, such as your code.

Once you have adapted the `.env` file or the `docker-compose.yaml` file to fit your need, you can start an interactive session with the following command:

```
docker exec -it my-project bash
```

In this session, you will find a Python version created with `conda` that has `rospy` installed. If you want to use your own Python environment (for example, you can add it to your scratch), just think about installing [`rospy`](https://anaconda.org/conda-forge/ros-rospy) yourself.


Moreover, if you want to use a more sophisticated setup, you can edit the project [Dockerfile](./docker/project.Dockerfile). Then, you need to rebuild your image using the following command:

```bash
$ docker compose --env-file /path/to/your/.env up -d --force-recreate --build project
```
