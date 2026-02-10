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
echo "${DOCKER_PASSWORD}" | docker login -u "${DOCKER_USERNAME}" --password-stdin

# Pull the latest image from private registry
docker pull ${DOCKER_IMAGE}

# Run Docker container
docker run -d \
  --name app-container \
  --restart always \
  -p ${CONTAINER_PORT}:${CONTAINER_PORT} \
  ${DOCKER_IMAGE}

# Verify container is running
docker ps