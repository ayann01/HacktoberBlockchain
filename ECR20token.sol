// SPDX-License-Identifier: MIT
pragma solidity 0.8.0
interface Check {
function minter() external returns (address); 
function mint(address receiver, uint amount) external; 
function send(address receiver, uint amount) external; 
event Sent(address from, address to, uint amount); 
error InsufficientBalance(uint requested, uint available);
}

contract Token is Check {
mapping(address => uint) private balances; 
address private_minter;

constructor() {
_minter = msg.sender;
}

function minter() external view override returns (address) { 
return_minter;
}

function mint(address receiver, uint amount) external override { 
require(msg.sender == _minter, "Only the minter can mint tokens.");
balances[receiver] += amount;
}

function send(address receiver, uint amount) external override {
require(amount <= balances[msg.sender], "Insufficient balance."); 
balances[msg.sender] -= amount; 
balances[receiver] += amount;
emit Sent(msg.sender, receiver, amount);
}

function balanceOf(address account) external view returns (uint) { 
return balances[account];
}
}
