# dao-compatibility-test/Dockerfile
FROM node:20.6.0-slim

# Set working directory
WORKDIR /workspace

# Install system dependencies
RUN apt-get update && \
    apt-get install -y git curl && \
    rm -rf /var/lib/apt/lists/*

# Copy package.json to container
COPY package.json ./

# Install Node.js dependencies
RUN npm install

# Default command to keep the container alive for testing
CMD ["bash"]
