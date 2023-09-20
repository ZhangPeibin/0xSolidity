const { loadFixture,
} = require("@nomicfoundation/hardhat-toolbox/network-helpers");
const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("Vault", function () {
    async function deplyVault() {
        // Contracts are deployed using the first signer/account by default
        const [owner, otherAccount] = await ethers.getSigners();
        const Vault = await ethers.getContractFactory("Vault");
        const vault = await Vault.deploy(ethers.encodeBytes32String("Hello World!"));
        const vaultAddress = await vault.getAddress();
        console.log("fallback address : " + vaultAddress)
        return { vault, owner, otherAccount };
    }

    describe("Get storage at ", function(){
        it("get password ", async function(){
            const {vault} = await loadFixture(deplyVault)
            const v1 = await ethers.provider.getStorage(vault.target,1);
            console.log(v1);
            console.log(ethers.decodeBytes32String(v1))

            const v2 = await ethers.provider.getStorage(vault.target,0);
            console.log(v2)
        });
    })
});