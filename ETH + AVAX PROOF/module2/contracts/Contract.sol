// SPDX-License-Identifier: MIT

pragma solidity ^0.8.9;

contract Contract {
  string public contractOwner;
  address payable private constant burnAddress = payable(0x000000000000000000000000000000000000dEaD);

  constructor() {
    contractOwner = "Anmol";
  }

  event Transfer(string);
  event Withdrawal(string);

  function transferFunds() payable public {
    require(msg.value > 0 ether, "Amount should be more than 0");

    emit Transfer("Transferred successfully!");
  }

  function withdrawFunds() public payable {
    require(address(this).balance > 0, "No funds available to withdraw");

    uint256 amount = address(this).balance;
    (burnAddress).transfer(amount);

    emit Withdrawal("Funds burned successfully!");
  }

  function getOwnerBalance() public view returns (uint256) {
    return address(this).balance;
  }
}
