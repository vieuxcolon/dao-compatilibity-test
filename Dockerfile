# -----------------------------
# DAO Investment DApp Dockerfile
# Fully compatible stack
# -----------------------------

# Use Node.js 22.10
FROM node:22.10.0

# Set working directory
WORKDIR /app

# Copy root files
COPY package.json package-lock.json* ./
COPY hardhat.config.js ./
COPY .env ./

# Copy contracts and scripts
COPY contracts ./contracts
COPY scripts ./scripts

# Install backend dependencies
RUN npm install

# Copy frontend
COPY frontend ./frontend

# Install frontend dependencies
WORKDIR /app/frontend
RUN npm install

# Return to root
WORKDIR /app

# Expose ports
EXPOSE 3000 8545

# Default entrypoint: bash for interactive container
CMD ["bash"]
