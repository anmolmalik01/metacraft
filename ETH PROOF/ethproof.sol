pragma solidity 0.8.18;

contract MyToken {
    string public tokenName = "EffortPoint";
    string public tokenAbbvr = "EP";
    uint public totalSupply = 0;

    mapping(address=>uint) public balances;

    function mint(address _address, uint _value) public{
        totalSupply+=_value;
        balances[_address] += _value;
    }

    function burn(address _address, uint _value) public{
        require(balances[_address] > _value, "Cannot burn more than balance tokens");
        totalSupply-=_value;
        balances[_address] -= _value;
    }
}