// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {Script, console} from "forge-std/Script.sol";
import {Legit} from "../src/Legit.sol";

contract LegitScript is Script {
    Legit public legit;

    function setUp() public {}

    function run() public {
        vm.startBroadcast();

        legit = new Legit();

        vm.stopBroadcast();
    }
}
