require("@nomicfoundation/hardhat-toolbox");
require("@nomicfoundation/hardhat-ethers");
require("@nomicfoundation/hardhat-verify");

require("dotenv").config();
const private_key = process.env.PRIVATE_KEY;
const infura_api_key = process.env.INFURA_API_KEY;

/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  defaultNetwork: "sepolia",
  networks: {
    hardhat: {
    },
    sepolia: {
      url: `https://sepolia.infura.io/v3/${infura_api_key}`,
      accounts: [private_key],
      chainId: 11155111,
    },
  },
  solidity: "0.8.19"
};
