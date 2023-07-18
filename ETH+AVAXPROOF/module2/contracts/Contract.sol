// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

contract CustomContract {
    string public contractOwnerName;
    address payable private constant burnAddress = payable(0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266);

    event TokensTransferred(string);
    event TokensWithdrawn(string);

    function transferTokens() external payable {
        require(msg.value > 0 ether, "Amount should be more than 0");
        emit TokensTransferred("Tokens transferred successfully!");
    }

    function withdrawTokens() external {
        require(address(this).balance > 0, "No tokens available to withdraw");
        uint256 amount = address(this).balance;
        burnAddress.transfer(amount);
        emit TokensWithdrawn("Tokens burned successfully!");
    }

    function getBalance() external view returns (uint256) {
        return address(this).balance;
    }

    function getContractOwnerName() external view returns (string memory) {
        return contractOwnerName;
    }
}
