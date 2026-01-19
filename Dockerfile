# Use official Node 22 LTS
FROM node:22.10.0

# Set working directory for backend
WORKDIR /app

# Copy backend files
COPY package.json package-lock.json* ./
COPY hardhat.config.js ./
COPY .env ./
COPY contracts ./contracts
COPY scripts ./scripts

# Install backend dependencies
RUN npm install --legacy-peer-deps

# Copy frontend
COPY frontend ./frontend

# Install frontend dependencies
WORKDIR /app/frontend
RUN npm install --legacy-peer-deps

# Back to root
WORKDIR /app

# Expose frontend and Hardhat RPC ports
EXPOSE 3000 8545

# Default entrypoint
CMD ["bash"]
