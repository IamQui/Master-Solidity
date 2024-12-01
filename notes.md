Foundry manages your dependencies, compiles your project, runs tests, deploys, and lets you interact with the chain from the command-line and via Solidity scripts.

[Foundry Book](https://book.getfoundry.sh/)

* Is foundry installed? forge --version

* Is anvil installed? anvil --version

* make folder for your project

* by default forge init expects an empty folder. If your folder is not empty you must run forge init --force
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

* forge create Demo --interactive 
// Defaults to anvil's RPC URL

* more explicit way to deploy
* forge create Demo --rpc-url http://127.0.0.1:8545 --private-key 0x2a871d0798f97d79848a013d4936a73bf4cc922c825d33c1cf7073dff6d409c6 

* forge script script/DeployDemo.s.sol --rpc-url http://127.0.0.1:8545 --private-key 0x2a871d0798f97d79848a013d4936a73bf4cc922c825d33c1cf7073dff6d409c6 --broadcast

// add --broadcast --private-key 0x2a871d0798f97d79848a013d4936a73bf4cc922c825d33c1cf7073dff6d409c6 at the end to deploy


// script - first function run() external

// cast --to-base 0x714e1 dec

## New Private Key secure

// For now, let's pretend our private key is this:

0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80

// cast wallet import nameOfAccountGoesHere --interactive

// don't do this in your VS Code

// forge script script/DeployDemo.s.sol --rpc-url http://127.0.0.1:8545 --broadcast --account nameOfAccountGoesHere --sender 0xf39fd6e51aad88f6f4ce6ab8827279cfffb92266

// To see all the configured wallets you can call the following: cast wallet list
