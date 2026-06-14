#!/bin/bash

set -e

echo "Pulling latest images..."
docker compose pull

echo "Stopping and removing old containers..."
docker compose down --remove-orphans --volumes

echo "Cleaning dangling containers (safe cleanup)..."
docker container prune -f || true

echo "Starting fresh containers..."
docker compose up -d --force-recreate

echo "Deployment completed successfully"

docker ps