// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

contract StackClub {
    address[] public members;
    
    error Forbidden();

    constructor() {
        members.push(msg.sender);
    }

    function isMember(address a) public view returns (bool) {
        for (uint i = 0; i < members.length; i++) {
            if (a == members[i]) {
                return true;
            }
        }

        return false;
    }

    modifier inMembersGroup {
        if (!isMember(msg.sender)) {
            revert Forbidden();
        }
        _;
    }

    function addMember(address a) external inMembersGroup {
        members.push(a);
    }

    function removeLastMember() external inMembersGroup {
        members.pop();
    }
}