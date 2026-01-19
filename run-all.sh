#!/bin/bash
set -e

IMAGE_NAME="dao-compatibility-test-dao"
CONTAINER_NAME="dao-test"

echo "🛑 Cleaning up old container if exists..."
docker rm -f $CONTAINER_NAME >/dev/null 2>&1 || true

echo "🐳 Building Docker image..."
docker build -t $IMAGE_NAME .

echo "🐳 Starting container..."
docker run -d \
    --name $CONTAINER_NAME \
    -p 3000:3000 \
    -p 8545:8545 \
    -v "$PWD":/app \
    -w /app \
    $IMAGE_NAME \
    tail -f /dev/null

echo "⌛ Waiting a few seconds for container to be ready..."
sleep 5

echo "🔧 Running backend (Hardhat) compile and deploy inside container..."
docker exec -w /app $CONTAINER_NAME bash -c "
  npm install
  npx hardhat compile
  node scripts/deploy.js
"

echo "✅ Contracts compiled and deployed."
echo "You can now enter the container interactively with:"
echo "docker exec -it $CONTAINER_NAME bash"
