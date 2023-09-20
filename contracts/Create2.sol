// SPDX-License-Identifier: MIT
pragma solidity  ^0.8.9;

contract  D {
    uint public x;

    constructor(){
        x = 10;
    }
}

contract Create2{
    function createDSalted(address token0, address token1) public returns(address pair){
        bytes memory bytecode = type(D).creationCode;
        bytes32 salt = keccak256(abi.encodePacked(token0, token1));
        assembly {
            pair := create2(0, add(bytecode, 32), mload(bytecode), salt)
        }
    }
}