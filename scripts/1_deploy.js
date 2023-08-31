const hre = require("hardhat");
const { ethers } = hre

async function main() {
  const SevenChain = await ethers.getContractFactory("SevenChain");
  const sevenChain = await SevenChain.deploy();

  await sevenChain.waitForDeployment();

  console.log(
    `Seven chain deploy to: ${sevenChain.target}`);
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
