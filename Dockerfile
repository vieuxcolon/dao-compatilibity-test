# Use Node.js LTS slim image
FROM node:20.6.0-slim

# Set working directory
WORKDIR /workspace

# Install git and curl
RUN apt-get update && \
    apt-get install -y git curl && \
    rm -rf /var/lib/apt/lists/*

# Copy package.json
COPY package.json ./

# Install dependencies
RUN npm install

# Copy the test script
COPY test-compatibility.sh ./

# Make test script executable
RUN chmod +x test-compatibility.sh

# Default command
CMD ["./test-compatibility.sh"]
