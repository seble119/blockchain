// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

contract Contract {

    function sum(uint[] calldata v) external pure returns (uint) {
        uint result;
        for (uint i = 0; i < v.length; i++) {
            result += v[i];
        }

        return result;
    }
}