# Use official Node 20 LTS
FROM node:20.6.0

# Set working directory
WORKDIR /workspace

# Install git (needed for Hardhat and Ethers packages sometimes)
RUN apt-get update && apt-get install -y git curl && rm -rf /var/lib/apt/lists/*

# Copy package.json to install dependencies
COPY package.json ./

# Install pinned dependencies
RUN npm install

# Expose default Hardhat port for local node (optional)
EXPOSE 8545

# Default command: bash
CMD ["/bin/bash"]
