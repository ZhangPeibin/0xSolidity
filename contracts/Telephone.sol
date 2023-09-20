// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.9;

contract Telephone{
    address public owner;

    constructor(){
        owner = msg.sender;
    }

    function  changeOwner(address _owner)  public {
        //tx是此次交易的发起者
        // msg.sender是该合约最终的调用者
        // a  调用合约A->该合约
        // 那么tx.origin 是a
        // 但是msg.sender 是 合约A
        
        if( tx.origin != msg.sender ){
            owner = _owner;
        }
    }
}