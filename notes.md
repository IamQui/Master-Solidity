* Is foundry installed? forge --version

* Is anvil installed? anvil --version

* folder for your project

* forge init --force (if it needs --force)
// creates basic folder structure, including src/ for contracts and test/ for tests

* create a .sol file in src/
// Demo.sol

* forge compile (or) build
// generates the ABI & bytecode in the out/ folder

* create deployment script in script/ folder
// DeployDemo.s.sol
// import {Script} from "forge-std/Script.sol";
// import {Demo} from "../src/Demo.sol";

* start anvil (anvil)

* run deployment script
// forge script script/DeployDemo.s.sol --rpc-url http://127.0.0.1:8545 --broadcast

* write test cases in test/ folder and run using 
// forge test

* forgescript script/DeployDemo.s.sol --rpc-url http://127.0.0.1:8545 --private-key 0x2a871d0798f97d79848a013d4936a73bf4cc922c825d33c1cf7073dff6d409c6 --broadcast

