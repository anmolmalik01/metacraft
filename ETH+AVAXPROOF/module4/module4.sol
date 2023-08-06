// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

interface IERC20 {
    function balanceOf(address account) external view returns (uint256);
    function transfer(address recipient, uint256 amount) external returns (bool);
}

contract DegenToken{
    string public name;
    string public symbol;
    uint256 private _totalSupply;
    mapping(address => uint256) private _balances;
    address private _owner;
    event TokenPurchased(address indexed buyer, uint256 itemId);
    
    uint public itemCount = 0;

    struct itemInfo {
        uint itemId;
        string name;
        uint256 price;
    }
    
    mapping(uint256 => itemInfo) private _items;

    constructor() {
        name = "Degen";
        symbol = "DGN";
        _totalSupply = 1000000;
        _owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == _owner, "Only the owner can call this function");
        _;
    }

    function balanceOf(address account) external view returns (uint256) {
        return _balances[account];
    }

    function transfer(address recipient, uint256 amount) external returns (bool) {
        require(amount > 0, "Amount must be greater than zero.");
        require(_balances[msg.sender] >= amount, "The balance is insufficient.");
        _balances[msg.sender] -= amount;
        _balances[recipient] += amount;
        return true;
    }

    function addItem(string memory itemName, uint256 price) public onlyOwner {
        itemCount++;
        _items[itemCount] = itemInfo(itemCount, itemName, price);
    }

    function buyItem(uint256 itemId) external payable {
        require(itemId <= itemCount, "Item does not exist");
        require(_balances[msg.sender] >= _items[itemId].price, "Insufficient balance");
        _balances[msg.sender] -= _items[itemId].price;
        emit TokenPurchased(msg.sender, itemId);
    }

    function getItemDetails(uint256 itemId) external view returns (string memory, uint256) {
        require(itemId <= itemCount, "Item does not exist");
        return (_items[itemId].name, _items[itemId].price);
    }

    function ItemList() external view returns (itemInfo[] memory) {
        itemInfo[] memory allItems = new itemInfo[](itemCount);
        for (uint i = 1; i <= itemCount; i++) {
            allItems[i - 1] = _items[i];
        }
        return allItems;
    }

    function owner() external view returns (address) {
        return _owner;
    }

    // For testing purposes only. This function should not be used in production.
    function mint(address to, uint256 amount) external onlyOwner {
        require(amount > 0, "Amount must be greater than zero.");
        _totalSupply += amount;
        _balances[to] += amount;
    }
}
