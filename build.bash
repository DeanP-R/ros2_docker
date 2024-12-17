#!/usr/bin/env bash

# Load environment variables from .env file
if [ -f .env ]; then
  export $(cat .env | grep -v '#' | awk '/=/ {print $1}')
else
  echo ".env file not found!"
  exit 1
fi

# Set image name and tag
image_name=ros2_docker_image
image_plus_tag=$image_name:latest

# Build the Docker image
docker build --build-arg -t $image_plus_tag -f Dockerfile .

# Instructions
echo "Built $image_plus_tag and tagged as $image_name:latest"
echo "To run the ROS docker:"
echo "./run.bash"
