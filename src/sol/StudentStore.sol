
// SPDX-License-Identifier: GPL-3.0-only
pragma solidity 0.8.20;

contract HorseStore {
    uint256 numberOfStudents; // storage  variable 

    function updateStudentNumber(uint256 newNumberOfStudents) external {
        numberOfStudents = newNumberOfStudents;
    }

    function readNumberOfStudents() external view returns (uint256) {
        return numberOfStudents;
    }
} 

