#!/bin/bash
set -e

CONTAINER_NAME="dao-test"
IMAGE_NAME="dao-compatibility-test-dao"

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
