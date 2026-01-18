#!/bin/bash
set -e

FILE="compatible-fullstack-versions.txt"

echo "===== Running compatibility tests ====="

# Skip the header line and read each combination
tail -n +2 "$FILE" | while read HARDHAT ETHERS DOTENV REACT REACTDOM; do
    echo
    echo "===== Testing combination: Hardhat $HARDHAT, Ethers $ETHERS, Dotenv $DOTENV, React $REACT, ReactDOM $REACTDOM ====="

    # Create temporary package.json for this combination
    cat > temp-package.json <<EOL
{
  "name": "dao-compatibility-test",
  "version": "1.0.0",
  "private": true,
  "dependencies": {
    "hardhat": "$HARDHAT",
    "ethers": "$ETHERS",
    "dotenv": "$DOTENV",
    "react": "$REACT",
    "react-dom": "$REACTDOM"
  }
}
EOL

    # Remove node_modules if exists to ensure clean install
    rm -rf node_modules package-lock.json

    # Install dependencies
    npm install --legacy-peer-deps

    if [ $? -eq 0 ]; then
        echo "✅ Combination succeeded: Hardhat $HARDHAT, Ethers $ETHERS, Dotenv $DOTENV, React $REACT, ReactDOM $REACTDOM"
    else
        echo "❌ Combination FAILED"
    fi

    # Optional: cleanup after each iteration
    # rm -rf node_modules package-lock.json temp-package.json
done

echo "===== Compatibility test completed ====="
