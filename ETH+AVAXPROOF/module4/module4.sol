// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IERC20 {
    // Returns the total supply of tokens
    function totalSupply() external view returns (uint256);

    // Returns the balance of a specified account
    function balanceOf(address account) external view returns (uint256);

    // Transfers tokens from the sender's account to the recipient's account
    function transfer(address recipient, uint256 amount) external returns (bool);

    // Creates and distributes new tokens to a specified recipient
    function mint(address to, uint256 amount) external;

    // Burns a specified amount of tokens from the sender's account
    function burn(uint256 amount) external;

    // Adds an item with its ID and name to the token contract
    function addItem(uint256 Item, string memory itemName) external;

    // Redeems an item based on its ID, deducting the required balance
    function redeemItem(uint256 Item) external payable;

    // Retrieves the name/details of an item based on its ID
    function ItemDetails(uint256 Item) external view returns (string memory);

    // Retrieves the address of the contract owner
    function owner() external view returns (address);
}

contract DegenToken is IERC20 {
    // Public variables for token name and symbol
    string public name;
    string public symbol;

    // Total supply of tokens
    uint256 private _totalSupply;

    // Mapping to track token balances of each account
    mapping(address => uint256) private _balances;

    // Mapping to store item details based on their ID
    mapping(uint256 => string) private _items;

    // Address of the contract owner
    address private _owner;

    // Event to be emitted when an item is redeemed
    event ItemRedeemed(address indexed player, uint256 Item);

    constructor() {
        // Initialize token name and symbol
        name = "Degen";
        symbol = "DGN";

        // Set total supply to 0 initially
        _totalSupply = 0;

        // Set the contract deployer as the owner
        _owner = msg.sender;
    }

    modifier onlyOwner() {
        // Restrict access to only the contract owner
        require(msg.sender == _owner, "Only the owner can call this function");
        _;
    }

    function totalSupply() external view override returns (uint256) {
        // Return the total supply of tokens
        return _totalSupply;
    }

    function balanceOf(address account) external view override returns (uint256) {
        // Return the token balance of a specified account
        return _balances[account];
    }

    function transfer(address recipient, uint256 amount) external override returns (bool) {
        // Ensure the transfer amount is greater than zero
        require(amount > 0, "Amount must be greater than zero.");

        // Ensure the sender has sufficient balance
        require(_balances[msg.sender] >= amount, "Insufficient balance.");

        // Deduct the tokens from the sender's balance
        _balances[msg.sender] -= amount;

        // Add the tokens to the recipient's balance
        _balances[recipient] += amount;

        // Transfer successful
        return true;
    }

    function mint(address to, uint256 amount) external override onlyOwner {
        // Ensure the mint amount is greater than zero
        require(amount > 0, "Amount must be greater than zero.");

        // Increase the total supply by the mint amount
        _totalSupply += amount;

        // Add the tokens to the recipient's balance
        _balances[to] += amount;
    }

    function burn(uint256 amount) external override {
        // Ensure the burn amount is greater than zero
        require(amount > 0, "Amount must be greater than zero.");

        // Ensure the sender has sufficient balance
        require(_balances[msg.sender] >= amount, "Insufficient balance.");

        // Decrease the total supply by the burn amount
        _totalSupply -= amount;

        // Deduct the tokens from the sender's balance
        _balances[msg.sender] -= amount;
    }

    function addItem(uint256 Item, string memory itemName) external override {
        // Ensure the item doesn't already exist
        require(bytes(_items[Item]).length == 0, "Item already exists");

        // Add the item with its ID and name
        _items[Item] = itemName;
    }

    function redeemItem(uint256 Item) external override payable {
        // Ensure the item exists
        require(bytes(_items[Item]).length > 0, "Item does not exist");

        // Ensure the sender has sufficient balance
        require(_balances[msg.sender] >= 100, "Insufficient balance");

        // Deduct the required balance from the sender's account
        _balances[msg.sender] -= 100;

        // Emit an event indicating the item has been redeemed
        emit ItemRedeemed(msg.sender, Item);
    }

    function ItemDetails(uint256 Item) external view override returns (string memory) {
        // Retrieve the name/details of an item
    }