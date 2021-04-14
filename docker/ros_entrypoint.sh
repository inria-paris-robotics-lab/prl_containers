#!/bin/bash
set -e

# setup ros environment
source /catkin_ws/devel/setup.bash

export ROS_HOSTNAME=localhost
export ROS_MASTER_URI=http://localhost:11311

exec "$@"