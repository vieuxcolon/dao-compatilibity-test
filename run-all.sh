#!/bin/bash
set -e

# Build Docker image
echo "===== Building Docker container ====="
docker build -t dao-compat-test .

# Run container to test compatibility
echo "===== Running compatibility test ====="
docker run --rm dao-compat-test
