#!/bin/bash
set -e

echo "===== Verifying Hardhat + Ethers + React stack ====="

# Print installed versions
echo "Hardhat version:"
npx hardhat --version

echo "Ethers version:"
npm list ethers | grep ethers

echo "Dotenv version:"
npm list dotenv | grep dotenv

echo "React version:"
npm list react | grep react

echo "ReactDOM version:"
npm list react-dom | grep react-dom

echo "✅ All dependencies installed successfully!"
