const { ethers } = require("hardhat");

async function main() {
  const InvestmentDAO = await ethers.getContractFactory("InvestmentDAO");
  const dao = await InvestmentDAO.deploy();
  await dao.deployed();
  console.log("InvestmentDAO deployed to:", dao.address);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
