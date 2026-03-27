#!/bin/bash

# Colours for output
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m' # No colour

echo -e "${GREEN}Stopping any existing container...${NC}"
docker stop my-app 2>/dev/null && docker rm my-app 2>/dev/null

echo -e "${GREEN}Building Docker image...${NC}"
docker build -t devops-hello-app .

if [ $? -ne 0 ]; then
  echo -e "${RED}Build failed. Exiting.${NC}"
  exit 1
fi

echo -e "${GREEN}Starting container...${NC}"
docker run -d -p 5000:5000 --name my-app devops-hello-app

echo -e "${GREEN}Running health check...${NC}"
sleep 2
curl --fail http://localhost:5000/health

if [ $? -eq 0 ]; then
  echo -e "\n${GREEN}App is up at http://localhost:5000${NC}"
else
  echo -e "${RED}Health check failed!${NC}"
  docker logs my-app
  exit 1
fi
