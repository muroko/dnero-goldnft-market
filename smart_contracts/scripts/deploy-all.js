const hre = require("hardhat");
const fs = require("fs");
const fse = require("fs-extra");
const { verify } = require("../utils/verify");
const {
  getAmountInWei,
  developmentChains,
  deployContract,
} = require("../utils/helpers");

async function main() {
  const deployNetwork = hre.network.name;
  const mintCost = getAmountInWei(10); // 10 matic

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

  console.log("DGNM Collectors contract deployed at: ", collectorsContract.target);
  console.log("DGNM NFT contract deployed at: ", nftContract.target);
  console.log("DGNM market contract deployed at: ", marketContract.target);
  console.log("Network deployed to : ", deployNetwork);

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
      export const networkDeployedTo = "${hre.network.config.chainId}"`
    );
  }

  // contract verification on polygonscan
/**  if (
    !developmentChains.includes(deployNetwork) &&
    hre.config.etherscan.apiKey[deployNetwork]
  ) {
    console.log("waiting for 6 blocks verification ...");
    await marketContract.deployTransaction.wait(6);

    // args represent contract constructor arguments
    const args = [nftContract.target];
    await verify(marketContract.target, args);
  }*/
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
