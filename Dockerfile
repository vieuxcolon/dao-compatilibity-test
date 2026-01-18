# Dockerfile
FROM node:18-slim

# Install Python and build tools
RUN apt-get update && \
    apt-get install -y python3 python3-pip git curl build-essential && \
    rm -rf /var/lib/apt/lists/*

# Upgrade pip, setuptools, wheel
RUN python3 -m pip install --upgrade pip setuptools wheel

# Set working directory
WORKDIR /workspace

# Copy test script
COPY test-compatibility.sh /workspace/test-compatibility.sh
RUN chmod +x /workspace/test-compatibility.sh

# Install Node dependencies (Hardhat + ethers + React)
RUN npm init -y
RUN npm install hardhat@3.3.0 ethers@6.10.0 react@18.3.0 react-dom@18.3.0 dotenv@16.1.1

# Default entrypoint
CMD [ "/workspace/test-compatibility.sh" ]
