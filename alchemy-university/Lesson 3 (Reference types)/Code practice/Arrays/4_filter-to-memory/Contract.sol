// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

import "forge-std/console.sol";
contract Contract {

    function filterEven(uint[] calldata v) external pure returns (uint[] memory) {
        uint size;
        for (uint i = 0; i < v.length; i++) {
            if (v[i] % 2 == 0) {
                size++;
            }
        }

        uint[] memory evenNumbers = new uint[](size);
        uint index;
        for (uint i = 0; i < v.length; i++) {
            if (v[i] % 2 == 0) {
                evenNumbers[index++] = v[i];
            }
        }

        return evenNumbers;
    }
}