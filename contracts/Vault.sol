// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.16;

contract Vault {
    bool public locked =true;
    bytes16 public a = "Hello";
    bytes32 private password;

    constructor(bytes32 _password) {
        password = _password;
    }

    function unlock(bytes32 _password) public {
        if (password == _password) {
            locked = false;
        }
    }
}
