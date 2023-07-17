pragma solidity ^0.8.0;

contract Contest {
    uint public totalParticipants;
    mapping(address => bool) public hasParticipated;

    function participate() public {
        require(!hasParticipated[msg.sender], "Already Participated"); // Check if the address has already participated

        totalParticipants++;
        hasParticipated[msg.sender] = true;

        if (totalParticipants > 100) {
            revert("Participant limit exceeded"); // Revert the transaction if the participant limit is exceeded
        }

        assert(totalParticipants <= 100); // Ensure that the total number of participants does not exceed the limit
    }
}