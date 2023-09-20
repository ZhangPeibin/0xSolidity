// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.19;

contract Delegate {
    address public owner;

    constructor(address _owner){
        owner = _owner;
    }

    function pwn() public{
        owner = msg.sender;
    }
    
}

contract Delegation{
    address public owner;
    Delegate delegate;

    constructor(address _delegateAddress){
        delegate = Delegate(_delegateAddress);
        owner = msg.sender;
    }

    /**
     * delegatecall 是以太坊智能合约中的一种低级函数调用方式，
     * 允许一个合约在当前合约的上下文中调用另一个合约的函数。
     * 与常规的 call 和 send 不同，delegatecall 在调用合约内部的函数时，
     * 使用调用者（caller）的上下文（包括存储和合约状态），而不是被调用合约的上下文。
     * 这使得 delegatecall 在某些情况下非常有用，但也需要谨慎使用，因为它具有潜在的安全风险。
     * 
     * 所以当我 发送交易到Delegation的时候并携带msg.value =  web3.utils.sha3('pwn()')
     * 的时候看起来是调用了 delegate的pwn方法
     * 但实际上 delegatecall会使用调用者的上下文环境，也就是 Delegation的存储状态等
     * 所以owner会使用 Delegation的owner 而不是   delegate的owner 
     * 
     */
    fallback() external {
        (bool result , ) = address(delegate).delegatecall(msg.data);
        if(result){
            this;
        }
    }

}