// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Strauss2 {
    address public owner;
    uint public contractBalance;
    
    event Deposit(address indexed depositor, uint amount);
    event Withdrawal(address indexed recipient, uint amount);
    
    modifier onlyOwner() {
        require(msg.sender == owner, "Only the contract owner can call this function");
        _;
    }
    
    constructor() {
        owner = msg.sender;
    }
    
    function deposit() public payable {
        require(msg.value > 0, "Amount must be greater than zero");
        
        contractBalance += msg.value;
        emit Deposit(msg.sender, msg.value);
    }
    
    function withdraw(uint amount) public onlyOwner {
        require(amount > 0, "Amount must be greater than zero");
        require(amount <= contractBalance, "Insufficient contract balance");
        
        contractBalance -= amount;
        payable(msg.sender).transfer(amount);
        emit Withdrawal(msg.sender, amount);
    }
    
    function getContractBalance() public view returns(uint) {
        return contractBalance;
    }
}
