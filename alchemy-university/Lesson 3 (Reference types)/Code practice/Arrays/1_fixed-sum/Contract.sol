// SPDX-License-Identifier: MIT

pragma solidity 0.8.20;

contract Contract {

    function sum(uint[5] calldata v) external pure returns(uint) {
        uint res;
        for (uint i = 0; i < v.length; i++) {
            res += v[i];
        }

        return res;
    }
}