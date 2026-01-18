#!/bin/bash
# dao-compatibility-test/test-compatibility.sh

set -e

IMAGE_NAME="dao-compat-test"

# Build the Docker image
docker build -t $IMAGE_NAME .

# Run the container and execute the compatibility test
docker run --rm $IMAGE_NAME npm run test-compat
