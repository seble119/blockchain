pragma solidity ^0.8.20;

contract Contract {
    mapping(address => bool) public m;

    function addMember(address a) external {
        m[a] = true;
    }

    function isMember(address a) external view returns (bool) {
        return m[a];
    }

    function removeMember(address a) external {
        m[a] = false;
    }
}