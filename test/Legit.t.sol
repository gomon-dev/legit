// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {Legit} from "../src/Legit.sol";

contract LegitTest is Test {
    Legit public legit;

    function setUp() public {
        legit = new Legit();
        legit.setNumber(0);
    }

    function test_Increment() public {
        legit.increment();
        assertEq(legit.number(), 1);
    }

    function testFuzz_SetNumber(uint256 x) public {
        legit.setNumber(x);
        assertEq(legit.number(), x);
    }
}
