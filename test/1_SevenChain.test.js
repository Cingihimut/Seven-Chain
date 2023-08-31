const { expect } = require("chai");
const { ethers } = require("hardhat", "ethers");
const { BigNumber } = require("ethers");

describe("SevenChain", function () {
  let SevenChain;
  let sevenChain;
  let owner;
  let addr1;
  let addr2;

  beforeEach(async function () {
    [owner, addr1, addr2] = await ethers.getSigners();

    SevenChain = await ethers.getContractFactory("SevenChain");
    sevenChain = await SevenChain.deploy();
  });

  it("Should have the correct name and symbol", async function () {
    expect(await sevenChain.name()).to.equal("Seven Chain");
    expect(await sevenChain.symbol()).to.equal("Sc");
  });

  it("Should mint the initial supply to the owner", async function () {
    const ownerBalance = await sevenChain.balanceOf(owner.address);
    const maxSupply = sevenChain.to.equal("40000000000");

    expect(ownerBalance).to.equal(maxSupply);
  });
});
