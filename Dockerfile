# Use Node.js stable slim image
FROM node:22-slim

# Set working directory
WORKDIR /workspace

# Install dependencies needed for git/npm builds
RUN apt-get update && \
    apt-get install -y git curl && \
    rm -rf /var/lib/apt/lists/*

# Copy the compatibility test files
COPY compatible-fullstack-versions.txt ./
COPY test-compatibility.sh ./

# Make the test script executable
RUN chmod +x test-compatibility.sh

# Run the compatibility tests by default when container starts
CMD ["./test-compatibility.sh"]
