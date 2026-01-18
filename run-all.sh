#!/bin/bash
set -e

IMAGE_NAME="dao-compat-test"

echo "Step 1: Building Docker image..."
docker build -t $IMAGE_NAME .

echo "Step 2: Running container and executing compatibility check..."
docker run --rm -it \
  -v "$PWD":/workspace \
  $IMAGE_NAME \
  bash -c "chmod +x /workspace/test-compatibility.sh && /workspace/test-compatibility.sh"

echo "✅ Compatibility check completed."
