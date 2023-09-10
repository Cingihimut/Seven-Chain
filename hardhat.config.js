require("@nomicfoundation/hardhat-toolbox");
require("@nomicfoundation/hardhat-ethers");
require("@nomicfoundation/hardhat-verify");

require("dotenv").config();
const private_key = process.env.PRIVATE_KEY;
const infura_api_key = process.env.INFURA_API_KEY;
const etherscan_api_key = process.env.ETHERSCAN_API_KEY;
const mnemonic = process.env.MNEMONIC;

// console.log("PRIVATE_KEY:", private_key);
// console.log("INFURA_API_KEY:", infura_api_key);
// console.log("ETHERSCAN_API_KEY:", etherscan_api_key);
// console.log("MNEMONIC:", mnemonic);

/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  networks: {
    hardhat: {
    },
    sepolia: {
      url: infura_api_key,
      accounts: [private_key],
      chainId: 11155111,
      mnemonic: mnemonic
    },
  },
  solidity: "0.8.19",
  etherscan: etherscan_api_key
};
