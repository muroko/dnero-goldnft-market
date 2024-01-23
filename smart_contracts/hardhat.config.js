require("dotenv").config();
require("hardhat-contract-sizer");
require("@nomiclabs/hardhat-etherscan");
require("@nomicfoundation/hardhat-chai-matchers");
require("hardhat-gas-reporter");
require("solidity-coverage");

const POLYGONSCAN_API_KEY = process.env.POLYGONSCAN_API_KEY;
const POLYGON_RPC_URL = process.env.POLYGON_RPC_URL;
const MUMBAI_RPC_URL = process.env.MUMBAI_RPC_URL;
const MAINNET_FORK_RPC_URL = process.env.MAINNET_FORK_ALCHEMY_URL;

module.exports = {
  solidity: {
    compilers: [
      {
        version: "0.8.19",
        settings: {
          optimizer: {
            enabled: true,
            runs: 200,
          },
        },
      },
    ],
  },
  networks: {
      hardhat: {},
      truffledashboard: {
        url: `http://localhost:24012/rpc`//,
        //accounts: [`0x${process.env.METAMASK_PRIVATE_KEY}`]
    },
    dneromainnet: {
      url: 'https://eth-rpc-api.dnerochain.xyz/rpc',
       chainId: 5647,
    },
    // mumbai: {
    //   url: MUMBAI_RPC_URL,
    //   accounts: [process.env.PRIVATE_KEY],
    //   chainId: 80001,
    // },
    // polygon: {
    //   url: POLYGON_RPC_URL,
    //   accounts: [process.env.PRIVATE_KEY],
    //   chainId: 137,
    // }
  },
  paths: {
    sources: './contracts',
    artifacts: "./artifacts",
  },
  gasReporter: {
    enabled: true,
  },
  etherscan: {
    apiKey: POLYGONSCAN_API_KEY,
  },
  mocha: {
    timeout: 60000,
  },
};
