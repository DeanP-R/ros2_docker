# ROS2 Docker Environment Setup

This guide will help you set up and run a ROS2 environment using Docker.
## 📋 Prerequisites

Before you begin, ensure you have docker installed :)

## 📂 Project Structure

The files provided are:

- Dockerfile: Defines the Docker image for ROS2.
- build.bash: A script to build the Docker image.
- run.bash: A script to run the Docker container.
- entrypoint.sh: An entry script to initialize the container.

Your directory should look like this:
```
project-directory/
│-- build.bash
│-- run.bash
│-- Dockerfile
│-- entrypoint.sh
│-- shared/     # Folder to share files with host machine
│-- ros2_ws/    # ROS2 workspace folder
```
## 🚀 Usage Instructions
### 1. Build the Docker Image

Run the following command to build the image:

    ./build.bash

This script will:

- Load environment variables from the .env file.
- Build a Docker image named ros2_docker_image:latest.
- Provide a success message once built.

### 3. Run the Docker Container

After building the image, execute:

    ./run.bash

This script will:

- Enable Docker access to your X11 display for GUI support.
- Mount necessary host directories into the container:
  - shared/ → /shared (file sharing)
  - ros2_ws/ → /ros2_ws (ROS2 workspace)
- Add device access for:
  - Video devices (/dev/video0, /dev/video1).
  - Input devices (/dev/input).
    - GPU rendering (/dev/dri).
  - Set the display variable for GUI applications.
### 4. Interacting with the Running Docker Container

Once the container is running, you can interact with it to execute ROS2 commands or other tasks:
To open a shell in the running container, use:

    docker exec -it ros2_docker_image bash

This allows you to interact with the container as if you were inside a terminal.

## 🛠️ Troubleshooting

### Permission Errors: 
Ensure the scripts are executable:

    chmod +x build.bash run.bash

### X11 Display Issues:

Allow Docker to connect to your X server:

    xhost +local:docker

## 🎯 Summary of Commands

- Build the image:

      ./build.bash

- Run the container:

      ./run.bash

- Open a shell in the running container, use:

      docker exec -it ros2_docker_image bash

## 📘 Additional Notes

- Persistent Storage: Use the shared/ directory to share data between your host and container.
- ROS2 Workspace: The ros2_ws/ folder can be mounted to persist ROS2 workspace data.
- Cleanup: The container will auto-remove itself when stopped due to --rm in run.bash.

