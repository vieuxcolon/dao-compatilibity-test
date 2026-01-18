#!/bin/bash

echo "Node version:"
node -v

echo "NPM version:"
npm -v

echo "Hardhat version:"
npx hardhat --version

echo "Ethers version:"
node -e "console.log(require('ethers').version)"

echo "React version:"
node -e "console.log(require('./frontend/node_modules/react/package.json').version)"

echo "Compatibility test completed"
