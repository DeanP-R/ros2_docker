#!/bin/bash
set -e

# Source the ROS setup files
source /opt/ros/${DIST}/setup.bash

# Keep the container running
tail -f /dev/null
