// SPDX-License-Identifier: MIT
pragma solidity 0.8.18;

interface IERC20 {
    function totalSupply() external view returns (uint);
    function balanceOf(address account) external view returns (uint);
    function transferTokens(address recipient, uint amount) external returns (bool);
    event Transfer(address indexed from, address indexed to, uint amount);
}

contract ERC20 is IERC20 {
    address public owner;
    uint private _totalSupply;
    mapping (address => uint) public balanceOf;


    constructor() {
        owner = msg.sender;
        _totalSupply = 0;
    }


    modifier onlyOwner {
        require(msg.sender == owner, "Only the contract owner can execute this function");
        _;
    }

    string public constant name = "Ultron";
    string public constant symbol = "UT";
    uint8 public constant decimals = 18;

    
    
    function transferTokens(address recipient, uint amount) external returns (bool) {
        require(balanceOf[msg.sender] >= amount, "The balance is insufficient");

        balanceOf[msg.sender] -= amount;
        balanceOf[recipient] += amount;

        emit Transfer(msg.sender, recipient, amount);
        return true;
    }

    
    
    function mintTokens(uint amount) external onlyOwner {
        balanceOf[msg.sender] += amount;
        _totalSupply += amount;
        emit Transfer(address(0), msg.sender, amount);
    }

    
   
    function burnTokens(uint amount) external onlyOwner {
        require(amount > 0, "Amount should not be zero");
        require(balanceOf[msg.sender] >= amount, "The balance is insufficient");
        balanceOf[msg.sender] -= amount;
        _totalSupply -= amount;

        emit Transfer(msg.sender, address(0), amount);
    }

    function totalSupply() external view override returns (uint) {
        return _totalSupply;
    }

}
