// dao-compatibility-test/test-compatibility.js

try {
    const hardhat = require("hardhat");
    const ethers = require("ethers");
    const dotenv = require("dotenv");

    console.log("✅ All dependencies loaded successfully!");
    console.log("Hardhat version:", require("hardhat/package.json").version);
    console.log("Ethers version:", require("ethers/package.json").version);
    console.log("Dotenv version:", require("dotenv/package.json").version);
} catch (err) {
    console.error("❌ Dependency check failed:", err);
    process.exit(1);
}
