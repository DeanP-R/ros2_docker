FROM osrf/ros:humble-desktop-full

ARG DIST=humble

ENV DIST=${DIST}

# Install necessary packages
RUN apt update \
 && apt install -y --no-install-recommends \
        nano \
        build-essential \
        cmake \
        cppcheck \
        curl \
        git \
        gnupg \
        libeigen3-dev \
        libgles2-mesa-dev \
        lsb-release \
        pkg-config \
        protobuf-compiler \
        python3-dbg \
        python3-pip \
        python3-venv \
        qtbase5-dev \
        ruby \
        software-properties-common \
        sudo \
        wget \
        tmux \
        libccd-dev \
        net-tools \
        iputils-ping \
	v4l-utils \
 && apt clean

RUN apt update \
 && apt install -y --no-install-recommends \
 && apt-get install -y ros-${DIST}-tf2-geometry-msgs \
 && apt-get install -y ros-${DIST}-std-msgs \
 && apt-get install -y ros-${DIST}-geometry-msgs \
 && apt-get install -y ros-${DIST}-nav-msgs \
 && apt-get install -y ros-${DIST}-visualization-msgs \
 && apt-get install -y ros-${DIST}-interactive-markers \
 && apt-get install -y ros-${DIST}-octomap \
 && apt-get install -y ros-${DIST}-octomap-msgs \
 && apt-get install -y ros-${DIST}-octomap-ros \
 && apt-get install -y ros-${DIST}-rqt-tf-tree \
 && apt-get install -y ros-${DIST}-image-transport-plugins \
 && apt-get update \
 && apt-get -y upgrade \
 && apt-get install -y python3-colcon-common-extensions \
 && apt-get install -y gedit \
 && apt clean

# Add source commands to bashrc
RUN echo "source /opt/ros/humble/setup.bash" >> ~/.bashrc \
  && echo "source /usr/share/colcon_argcomplete/hook/colcon-argcomplete.bash" >> ~/.bashrc \
  && echo "source /ros2_ws/install/setup.bash" >> ~/.bashrc

# Install and build the repository
WORKDIR /ros2_ws
RUN /bin/bash -c "source /opt/ros/${DIST}/setup.bash && colcon build"

# Copy visualising entrypoint script and make it executable
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
EXPOSE 8888
