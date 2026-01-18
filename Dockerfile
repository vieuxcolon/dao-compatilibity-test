# dao-compatibility-test/Dockerfile
FROM node:20.6.0-slim

WORKDIR /workspace

# Install system dependencies
RUN apt-get update && \
    apt-get install -y git curl && \
    rm -rf /var/lib/apt/lists/*

# Copy test script
COPY test-compatibility.sh ./

# Give execute permissions
RUN chmod +x test-compatibility.sh

CMD ["./test-compatibility.sh"]
