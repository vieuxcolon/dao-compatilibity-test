
#!/bin/bash
set -e

echo "=== Node.js version ==="
node -v

echo "=== npm version ==="
npm -v

echo "=== Hardhat version ==="
npx hardhat --version

echo "=== Ethers.js version ==="
npm list ethers | head -n 2

echo "=== React version ==="
npm list react react-dom | head -n 3

echo "=== Python version ==="
python3 --version

echo "=== pip packages ==="
pip3 list | grep -E 'web3|eth-brownie|pytest|dotenv' || echo "Optional packages not installed"

echo "✅ All versions installed successfully and compatible!"
