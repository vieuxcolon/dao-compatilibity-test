#!/bin/bash
set -e

CONTAINER_NAME="dao-test"
IMAGE_NAME="dao-test"

echo " Cleaning up old container if exists..."
docker rm -f $CONTAINER_NAME >/dev/null 2>&1 || true

echo " Building Docker image (no cache)..."
docker build --no-cache -t $IMAGE_NAME .

echo " Starting container..."
docker run -d \
  --name $CONTAINER_NAME \
  -p 3000:3000 \
  -p 8545:8545 \
  $IMAGE_NAME \
  tail -f /dev/null

echo " Waiting for container..."
sleep 3

echo " Compiling Hardhat contracts..."
docker exec $CONTAINER_NAME npx hardhat compile

echo " Deploying contracts..."
docker exec $CONTAINER_NAME npx hardhat run scripts/deploy.js --network localhost

echo
echo " DAO Investment DApp backend ready"
echo "You can enter the container with:"
echo "docker exec -it $CONTAINER_NAME bash"
