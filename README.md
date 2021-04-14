# prl_containers
This package provides container configurations for the Paris Robotics Lab software

## Containers list

### - docker/noetic-dev

Docker container with dev version of [prl_ur5_robot](https://github.com/inria-paris-robotic-lab/prl_ur5_robot) ROS stack.

It is based on [osrf/ros:noetic-desktop-full](https://hub.docker.com/r/osrf/ros) image with pebuilded [catkin workspace](http://wiki.ros.org/catkin/workspaces) that hosts the prl_ur5_robot stack and all the required dependencies.

To build:

```
cd ./docker
docker build -t my/ros:prl_ur5_robot -f Dockerfile.noetic-dev .
```

To run:

*On Ubuntu with Intel graphics:*

```
xhost +
docker run \
    --network host \
    --volume='/tmp/.X11-unix:/tmp/.X11-unix:rw' \
    --device=/dev/dri:/dev/dri \
    --env="DISPLAY=$DISPLAY" \
    --rm \
    -it my/ros:prl_ur5_robot
```

