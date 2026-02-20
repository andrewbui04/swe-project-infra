#!/bin/bash

set -e

# Update system packages
apt-get update
apt-get upgrade -y

# Install Docker
apt-get install -y docker.io

# Start Docker service
systemctl start docker
systemctl enable docker

# Add ubuntu user to docker group
usermod -aG docker ubuntu



# Login to Docker Hub (if using private registry)
echo "${docker_password}" | docker login -u "${docker_username}" --password-stdin

docker pull ${docker_image}

docker run -d \
  -p ${container_port}:${container_port} \
  --restart always \
  ${docker_image}
  
# Verify container is running
docker ps