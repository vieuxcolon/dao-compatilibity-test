#!/bin/bash
echo "Checking installed versions..."

# Node & NPM
echo "Node version: $(node -v)"
echo "NPM version: $(npm -v)"

# Hardhat
echo "Hardhat version: $(npx hardhat --version)"

# Ethers
echo "Ethers version: $(npm list ethers | grep ethers)"

# React
echo "React version: $(npm list react | grep react)"

echo "Compatibility check finished."
