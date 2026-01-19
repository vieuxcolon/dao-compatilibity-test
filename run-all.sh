#!/bin/bash
set -e

CONTAINER_NAME="dao-test"

echo "🛑 Cleaning up old container if exists..."
docker rm -f $CONTAINER_NAME >/dev/null 2>&1 || true

echo "🐳 Building Docker image..."
docker compose build

echo "🐳 Starting container..."
docker compose up -d

echo "⌛ Waiting a few seconds for container to be ready..."
sleep 3

echo "🔧 Running backend (Hardhat) compile and deploy inside container..."
docker exec -it $CONTAINER_NAME bash -c "
  cd /app && \
  npx hardhat compile && \
  npx hardhat run scripts/deploy.js
"

echo "🚀 Starting frontend..."
docker exec -it $CONTAINER_NAME bash -c "
  cd /app/frontend && \
  npm start
"

echo "✅ All set! Frontend running on http://localhost:3000 and Hardhat RPC on http://localhost:8545"
