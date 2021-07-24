// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.7.0 <0.9.0;
 
import "@openzeppelin/contracts/access/Ownable.sol";
 
 
contract redemcode is Ownable {
 
 
 
 
    struct data {
        address owner;
        uint256 value;
        bool used;
    }
 
 
    mapping(bytes32 => data) public code;
 
    function codeused(bytes32 _codeused) private {
        code[_codeused].used = true;
 
    }
 
 
    function mintcode(bytes32 _codehash, uint256 _desiredcodevalue) public payable {
        require(_desiredcodevalue == msg.value, "no enought money sent");
        data memory datatomint = data(msg.sender, msg.value, false);
        code[_codehash] = datatomint;
    }
 
    function usecode(string memory _codetouse) public payable {
        bytes32  codehashtouse = keccak256(abi.encodePacked(_codetouse));
        uint256 valueofcode = code[codehashtouse].value;
        bool validityofcode = code[codehashtouse].used;
        require(valueofcode != 0);
        require(validityofcode == false);
        codeused(codehashtouse);
        bool sent = payable(msg.sender).send(valueofcode);
        require(sent, "Failed to send Ether");
 
    }
}
 
