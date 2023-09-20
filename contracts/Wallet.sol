// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.19;

/// @title  多钱钱包
/// @author peibin
/// @notice notice
contract Wallet {

    struct Transfer {
        uint256 id;
        uint256 amount;
        address payable to;
        uint256 approvers;
        bool sent;
    }

    modifier onlyApprover() {
        bool isApprover  = false;
        for (uint8 i = 0; i < approvers.length; i++) {
            if(approvers[i] == msg.sender){
                isApprover = true;
                break;
            }
        } 
        _;
    }

    Transfer[] public transfers;
    address[] public approvers;
    uint8 public quorum;
    mapping (address => mapping (uint => bool) ) approvals;


    constructor(address[] memory _approvers, uint8 _quorum) {
        approvers = _approvers;
        quorum = _quorum;
    }

    function getApprovers() external view  returns (address[]  memory) {
        return approvers;
    }

    function createTransfer(uint256 amout , address payable to ) external onlyApprover{
        transfers.push(Transfer(
            transfers.length,
            amout,
            to,
            0,
            false
        ));
    }

    function getTransfers() external view returns(Transfer[] memory){
        return transfers;
    }

    function approveTransfer(uint id) external  onlyApprover{
        require(transfers[id].sent == false, "transfer has already been sent");
        require(approvals[msg.sender][id] == false, "cannot approve transfer twice");
        approvals[msg.sender][id] = true;
        transfers[id].approvers++;
        if(transfers[id].approvers >= quorum){
            transfers[id].sent = true;
            address payable to = transfers[id].to;
            uint amount = transfers[id].amount;
            to.transfer(amount);
        }

    }

    receive() external payable{}

}