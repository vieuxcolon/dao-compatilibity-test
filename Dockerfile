# -----------------------------
# DAO Investment DApp Dockerfile
# Fully compatible stack
# -----------------------------

FROM node:22.10.0

# Set working directory
WORKDIR /app

# Copy backend files
COPY package.json package-lock.json* ./
COPY hardhat.config.js ./
COPY .env ./
COPY contracts ./contracts
COPY scripts ./scripts

# Install backend dependencies with legacy-peer-deps
RUN npm install --legacy-peer-deps

# Copy frontend
COPY frontend ./frontend

# Install frontend dependencies
WORKDIR /app/frontend
RUN npm install --legacy-peer-deps

# Return to root
WORKDIR /app

# Expose ports
EXPOSE 3000 8545

# Default entrypoint
CMD ["bash"]
