// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

import {Script} from "forge-std/Script.sol";
import {Demo} from "../src/Demo.sol";

contract DeployDemo is Script{
    function run() external {
        vm.startBroadcast();
        new Demo();
        vm.stopBroadcast();
    }
}