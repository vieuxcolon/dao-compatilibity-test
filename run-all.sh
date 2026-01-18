#!/bin/bash
set -e

echo "Starting Hardhat node..."
npx hardhat node &
sleep 5

echo "Compiling contracts..."
npx hardhat compile

echo "Deploying InvestmentDAO..."
DEPLOY_OUTPUT=$(npx hardhat run scripts/deploy.js --network localhost)
echo "$DEPLOY_OUTPUT"

DAO_ADDRESS=$(echo "$DEPLOY_OUTPUT" | grep -oE "0x[a-fA-F0-9]{40}")

echo "Updating frontend config..."
sed -i "s/PUT_DEPLOYED_CONTRACT_ADDRESS_HERE/$DAO_ADDRESS/g" frontend/src/daoConfig.js

echo "Copying ABI to frontend..."
mkdir -p frontend/src/abi
cp artifacts/contracts/InvestmentDAO.sol/InvestmentDAO.json frontend/src/abi/

echo "Starting frontend..."
cd frontend
npm start
