#!/usr/bin/env bash

xhost +local:docker

docker run -it --rm --net=host \
-v "$(pwd)/shared:/shared" \
-v "$(pwd)/ros2_ws:/ros2_ws" \
--device /dev/video0:/dev/video0 \
--device /dev/video1:/dev/video1 \
-v /tmp/.X11-unix:/tmp/.X11-unix \
-v /dev/input:/dev/input \
-e DISPLAY=unix${DISPLAY} \
--device /dev/dri:/dev/dri \
--name ros2_docker_image ros2_docker_image 

