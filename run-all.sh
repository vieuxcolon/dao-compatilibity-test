#!/bin/bash
set -e

echo "===== Building Docker container ====="
docker build -t dao-compat-test .

echo "===== Running all compatibility tests ====="
docker run --rm dao-compat-test
