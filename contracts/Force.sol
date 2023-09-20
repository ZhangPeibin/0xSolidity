// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.19;


/**
 * 
 * 怎么让这个合约的余额不为0
 * @title 
 * @author 
 * @notice 
 */
contract Force {
    constructor() {
        
    }
}

//我们使用自毁合约，自毁合约会将合约的余额强制发送到另外一个地址,如果这个地址是合约
//也不会调用该合约的 fallback函数
contract ForceTest{

    function exploit(address _target) public{
        selfdestruct(payable(_target));
        //似乎selfdestruct函数以及被弃用了
        //推荐使用address.transfer()来代替 
    }
}