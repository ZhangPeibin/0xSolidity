// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.19;

contract FallBack {
    
    mapping (address => uint256) public contributions;
    address payable public owner;

    constructor() {
        owner = payable(msg.sender);
        contributions[owner] = 1000 * (1 ether);
    }

    function getOwner() public view returns(address){
        return owner;
    }

    receive() external payable{
        require(msg.value>0 && contributions[msg.sender] >0 );
        owner = payable(msg.sender);
    }

    modifier  onlyOwner {
        require(msg.sender == owner,"caller is not the owner");
        _;
    }

    function  contribute()  public payable{
        require(msg.value < 0.001 ether,"max value is 0.001");
        contributions[msg.sender] += msg.value;
        if(contributions[msg.sender] > contributions[owner]){
            owner = payable(msg.sender);
        }    
    }

    function getContribution() public view returns(uint256){
        return contributions[msg.sender];
    }

    function withdraw() public onlyOwner{
        owner.transfer(address(this).balance);
    }

}