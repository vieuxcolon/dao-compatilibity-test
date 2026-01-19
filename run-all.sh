#!/bin/bash
set -e

CONTAINER_NAME="dao-test"
IMAGE_NAME="dao-compatibility-test-dao"

echo "🛑 Cleaning up old container if exists..."
docker rm -f $CONTAINER_NAME >/dev/null 2>&1 || true

echo "🐳 Building Docker image (no cache)..."
docker build --no-cache -t $IMAGE_NAME .

echo "🐳 Starting container..."
docker run -d \
  --name $CONTAINER_NAME \
  -p 3000:3000 \
  -p 8545:8545 \
  -v $(pwd):/app \
  -w /app \
  $IMAGE_NAME \
  tail -f /dev/null

echo "⌛ Waiting a few seconds for container to be ready..."
sleep 3

echo "⚡ Compiling Hardhat contracts..."
docker exec $CONTAINER_NAME bash -c "npx hardhat compile"

echo "🚀 Deploying contracts..."
docker exec $CONTAINER_NAME bash -c "npx hardhat run scripts/deploy.js --network localhost"

echo
echo "✅ DAO Investment DApp is ready!"
echo "Frontend: http://localhost:3000"
echo "Hardhat node: http://localhost:8545"
echo
echo "You can enter the container with: docker exec -it $CONTAINER_NAME bash"
