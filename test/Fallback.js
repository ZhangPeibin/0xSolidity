const {  loadFixture,
} = require("@nomicfoundation/hardhat-toolbox/network-helpers");
const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("FallBack", function () {

  async function deployOneYearLockFixture() {
    // Contracts are deployed using the first signer/account by default
    const [owner, otherAccount] = await ethers.getSigners();
    const Fallback = await ethers.getContractFactory("FallBack");
    const fallback = await Fallback.deploy();
    const fallbackAddress = await fallback.getAddress();
    console.log("fallback address : " +fallbackAddress)
    return { fallback, owner, otherAccount };
  }

  describe("fallback check", function(){
     it("test owner not changed", async function(){
       const { fallback } = await loadFixture(deployOneYearLockFixture);
       const [owner, a1,a2] = await ethers.getSigners();
       expect(await fallback.getOwner()).to.equal(await owner.getAddress());

       await fallback.connect(a1).contribute({value:1});
       expect(await fallback.connect(a1).getContribution()).to.equal(1);
       await a1.sendTransaction({
        to: fallback.getAddress(),
        value: ethers.parseEther('0.000000000000001'), // 1 Wei 的 Wei 表示
      });
      const newOwner = await fallback.connect(a1).getOwner();
      expect(await fallback.getOwner()).to.equal(await a1.getAddress());

      await fallback.connect(a1).withdraw();
      expect(await ethers.provider.getBalance(fallback.target)).to.equal(0);
     })
  })

});
