const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("CadastralContract", function () {
  it("Should return the new greeting once it's changed", async function () {
    const CadastralContract = await hre.ethers.getContractFactory("CadastralContract");
    const cadastralContract = await CadastralContract.deploy();
    await cadastralContract.deployed();
  });
});
