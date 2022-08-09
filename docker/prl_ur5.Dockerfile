FROM ubuntu:focal

# Install generic packages
RUN apt-get update && \
    apt-get install -y -q --no-install-recommends  \
    	curl \
	git \
	build-essential \
	gnupg2 && \
    rm -rf /var/lib/apt/lists/*

# Install minimal ROS packages
ENV DEBIAN_FRONTEND noninteractive
RUN echo "deb http://packages.ros.org/ros/ubuntu focal main" > /etc/apt/sources.list.d/ros1-latest.list && \
    apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys C1CF6E31E6BADE8868B172B4F42ED6FBAB17C654 && \
    apt-get update && \
    apt-get install -y -qq --no-install-recommends  \
        python3-catkin-tools \
	python3-wstool \
	python3-rosdep && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /catkin_ws
ENV ROS_DISTRO noetic

# Clone repo and install them   		
RUN git clone -b master https://github.com/inria-paris-robotic-lab/prl_ur5_robot src/prl_ur5_robot
RUN git clone -b master https://github.com/inria-paris-robotic-lab/prl_ur5_robot_configuration src/prl_ur5_robot_configuration
RUN git clone -b master https://github.com/inria-paris-robotic-lab/prl_utils.git src/prl_utils
RUN wstool init src ./src/prl_ur5_robot/prl_ur5_robot.rosinstall
RUN rosdep init && rosdep update
RUN apt-get update && \
    rosdep install --ignore-src --from-paths src --skip-keys=python-pymodbus -y -q && \
    rm -rf /var/lib/apt/lists/*

# init and build the workspace
RUN catkin config --init --extend /opt/ros/noetic/ && \
    catkin config --skiplist robotiq_3f_gripper_articulated_gazebo_plugins && \
    catkin build && \
    echo "source /catkin_ws/devel/setup.bash" >> ~/.bashrc

RUN chmod -R g+w /catkin_ws

# setup entrypoint
COPY ./ros_entrypoint.sh /
ENTRYPOINT ["/ros_entrypoint.sh"]

CMD ["bash"]
