// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

contract Contract {
    uint[] public evenNumbers;

    function filterEven(uint[] calldata v) external {
        for (uint i = 0; i < v.length; i++) {
            if (v[i] % 2 == 0) {
                evenNumbers.push(v[i]);
            }
        }
    }
}