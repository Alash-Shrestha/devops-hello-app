#!/bin/bash

echo "Stopping all running containers..."
docker stop $(docker ps -q) 2>/dev/null

echo "Removing stopped containers..."
docker rm $(docker ps -aq) 2>/dev/null

echo "Removing unused images..."
docker image prune -f

echo "Done! Current disk usage:"
docker system df
