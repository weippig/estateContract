const hre = require("hardhat");

async function main() {
  const CadastralContract = await hre.ethers.getContractFactory("CadastralContract");
  const cadastralContract = await CadastralContract.deploy();

  await cadastralContract.deployed();

  console.log("CadastralContract deployed to:", cadastralContract.address);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
