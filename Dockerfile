FROM node:22.10.0

# Set working directory
WORKDIR /app

# Copy root files
COPY package.json ./
COPY hardhat.config.js ./
COPY .env ./

# Copy backend
COPY contracts ./contracts
COPY scripts ./scripts

# Install backend deps
RUN npm install

# Copy frontend
COPY frontend ./frontend

# Install frontend deps
WORKDIR /app/frontend
RUN npm install

# Back to root
WORKDIR /app

# Expose frontend port
EXPOSE 3000

CMD ["bash"]

