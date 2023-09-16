const {
  time,
  loadFixture,
} = require("@nomicfoundation/hardhat-toolbox/network-helpers");
const { anyValue } = require("@nomicfoundation/hardhat-chai-matchers/withArgs");
const { expect } = require("chai");

describe("Create2", function () {
  // We define a fixture to reuse the same setup in every test.
  // We use loadFixture to run this setup once, snapshot that state,
  // and reset Hardhat Network to that snapshot in every test.
  async function deployOneYearLockFixture() {
    // Contracts are deployed using the first signer/account by default
    const [owner, otherAccount] = await ethers.getSigners();
    const Create2 = await ethers.getContractFactory("Create2");
    const create2 = await Create2.deploy();
    const create2Address = await create2.getAddress();
    console.log("create2 address : " +create2Address)
    return { create2, owner, otherAccount };
  }

  describe("CreateDSalted", function () {
    it("test createDSalted", async function () {
      const { create2 } = await loadFixture(deployOneYearLockFixture);

      const pair = await create2.createDSalted("0x638Eff0F9B92FFb36c2c7245309e8Db74fb4fc8D",
      "0xA9d59a6B4c645CCed44CbBf3C2546de8D166ef5c");
      await pair.wait();
      const newContractAddress = pair.contractAddress;

      console.log("paid address : ")
      console.log(newContractAddress)
    });
  });
});
