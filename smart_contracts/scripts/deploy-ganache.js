const hre = require("hardhat");
const fs = require("fs");
const fse = require("fs-extra");
const { getAmountInWei, deployContract } = require("../utils/helpers");

async function main() {
  const deployNetwork = hre.network.name;
  const mintCost = getAmountInWei(10); // 10 dtoken

  // Deploy DAI ERC20 mock
  const mockDAI = await deployContract("ERC20Mock", [18]);

  // Deploy DGNM Collectors contract
  const collectorsContract = await deployContract("DGNMCollectors", []);

  // Deploy DGNM NFT Collection contract
  const nftContract = await deployContract("DGNMCollection", [
    collectorsContract.target,
    mintCost,
  ]);

  // unpause NFT contract
  await nftContract.pause(2);

  // Deploy DGNM market contract
  const marketContract = await deployContract("DGNMMarket", [
    nftContract.target,
  ]);

  // add mock DAI to market supported tokens
  await marketContract.addSupportedToken(mockDAI.target);

  console.log("DGNM Collectors contract deployed at:\n", collectorsContract.target);
  console.log("DGNM NFT contract deployed at:\n", nftContract.target);
  console.log("DGNM market ontract deployed at:\n", marketContract.target);
  console.log("Network deployed to :\n", deployNetwork);

  /* transfer contracts addresses & ABIs to the front-end */
  if (fs.existsSync("../front-end/src")) {
    fs.rmSync("../src/artifacts", { recursive: true, force: true });
    fse.copySync("./artifacts/contracts", "../front-end/src/artifacts");
    fs.writeFileSync(
      "../front-end/src/utils/contracts-config.js",
      `
      export const marketContractAddress = "${marketContract.target}"
      export const nftContractAddress = "${nftContract.target}"
      export const collectorsContractAddress = "${collectorsContract.target}"
      export const networkDeployedTo = "${hre.network.config.chainId}"
      export const mockDAIAddress = "${mockDAI.target}"`
    );
  }
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
