#!/bin/bash
set -e

echo "===== Starting full compatibility test ====="

# Path to the file with version sets
VERSION_FILE="compatible-fullstack-versions.txt"

# Header for summary output
echo "Compatible version sets found:"
echo "--------------------------------"

# Iterate over each line in the file
while read -r line; do
    # Split line into variables
    HARDHAT_VER=$(echo "$line" | awk '{print $1}')
    ETHERS_VER=$(echo "$line" | awk '{print $2}')
    DOTENV_VER=$(echo "$line" | awk '{print $3}')
    REACT_VER=$(echo "$line" | awk '{print $4}')
    REACTDOM_VER=$(echo "$line" | awk '{print $5}')

    echo "Testing combination: Hardhat $HARDHAT_VER | Ethers $ETHERS_VER | Dotenv $DOTENV_VER | React $REACT_VER | ReactDOM $REACTDOM_VER"

    # Create temporary package.json for this test
    cat > temp-package.json <<EOF
{
  "name": "dao-compatibility-test",
  "version": "1.0.0",
  "dependencies": {
    "hardhat": "$HARDHAT_VER",
    "ethers": "$ETHERS_VER",
    "dotenv": "$DOTENV_VER",
    "react": "$REACT_VER",
    "react-dom": "$REACTDOM_VER"
  }
}
EOF

    # Install dependencies in a clean node_modules
    rm -rf node_modules package-lock.json
    if npm install --ignore-scripts --silent; then
        echo "✅ Success: $line"
        echo "$line" >> compatible-found.txt
    else
        echo "❌ Failed: $line"
    fi

    # Clean up temp package.json
    rm temp-package.json
done < "$VERSION_FILE"

echo "===== Compatibility test complete ====="
echo "✅ Compatible combinations saved in compatible-found.txt"
