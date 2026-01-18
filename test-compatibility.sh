#!/bin/bash
set -e

# Candidate versions
HARDHAT_VERSIONS=("3.0.0" "3.1.0" "3.1.4")
ETHERS_VERSIONS=("6.10.0" "6.11.0")
DOTENV_VERSIONS=("16.1.0" "16.1.2")
REACT_VERSIONS=("18.2.0" "18.3.0")
REACT_DOM_VERSIONS=("18.2.0" "18.3.0")

# Output file
OUTPUT="compatible-fullstack-versions.txt"
echo "Compatible full-stack dependency sets:" > $OUTPUT

# Loop through all combinations
for HH in "${HARDHAT_VERSIONS[@]}"; do
  for ETH in "${ETHERS_VERSIONS[@]}"; do
    for ENV in "${DOTENV_VERSIONS[@]}"; do
      for REACT in "${REACT_VERSIONS[@]}"; do
        for REACT_DOM in "${REACT_DOM_VERSIONS[@]}"; do

          echo "Testing: Hardhat@$HH Ethers@$ETH Dotenv@$ENV React@$REACT ReactDOM@$REACT_DOM ..."
          
          # Create temp package.json
          cat > package.json <<EOL
{
  "name": "dao-fullstack-compat-test",
  "version": "1.0.0",
  "private": true,
  "dependencies": {
    "hardhat": "$HH",
    "ethers": "$ETH",
    "dotenv": "$ENV",
    "react": "$REACT",
    "react-dom": "$REACT_DOM"
  }
}
EOL

          # Remove node_modules and package-lock
          rm -rf node_modules package-lock.json

          # Try npm install
          if npm install --silent; then
            echo "✅ Success: Hardhat@$HH Ethers@$ETH Dotenv@$ENV React@$REACT ReactDOM@$REACT_DOM"
            echo "$HH $ETH $ENV $REACT $REACT_DOM" >> $OUTPUT
          else
            echo "❌ Failed: Hardhat@$HH Ethers@$ETH Dotenv@$ENV React@$REACT ReactDOM@$REACT_DOM"
          fi

        done
      done
    done
  done
done

echo "All tests finished. Compatible full-stack sets are in $OUTPUT"
