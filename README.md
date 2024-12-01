# Master-Solidity

Master Solidity

https://www.youtube.com/watch?v=rpa6XWSYvtg


### What is solidity?

* Solidity is an object-oriented, high-level programming language for implementing immutable smart contracts for the ethereum blockchain.

* Solidity is case sensitive, statically typed, support inheritance, libraries, and complex user-defined types, among other features.

* Solidity can create contracts for voting, crowdfunding, bling auctions, and multi-signature wallets.

NOTE - follow established development best-practices when writing your smart contracts.

### Simple Storage Example

```solidity
// SPDX-License-Identifier: GPL-3.0

/* This line tells you the source code is licensed under the GPL version 3.0 */

pragma solidity >=0.4.16 <0.9.0;

/* This line specifies the source code is written for Solidity version 0.4.16, or a newer version up to, but not including, version 0.9.0. This is to ensure that the contract is not compilable with a new compiler version, where it could behave differently. 

The pragma keyword is used to enable certain compiler features or checks. A pragma directive is always local to a source file so you have to add the pragma to all your files if you want to enable it in your whole project. 

Pragmas are common instructions for compilers about how to treat the source code.

If you import another file, the pragma from that file DOES NOT automatically apply to the importing file. 

Source files can and should be annotated with a version pragma to reject compilation with future compiler versions that might introduce incompatible changes. 

It is possible to specify more complex rules for the compiler version, these follow the same syntax used by npm.

Using the version pragma DOES NOT change the version of the compiler. It also DOES NOT enable or disable features of the compiler. It just instructs the compiler to check whether its version matches the one required by the pragma. If it does not match, the compiler issues an error. */



contract SimpleStorage {

    uint storedData; //a state variable called storedData of type uint (an unsigned integer of 256 bits)

    function set(uint data) public { //sets inputted data as storedData
        storedData = data;
    }

    function get() public view returns (uint) { //returns inputted data 
        return storedData;
    }
}
```

### Subcurrency Example

```solidity
// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.26;

// This will only compile via IR(IR = in remix? Not sure)
contract Coin {
    // address declares a state variable of type address
    // address type is a 160-bit value that DOES NOT allow any arithmetic operations. It is suitable for storing addresses of contracts, or a hash of the public half of a keypair belonging to external accounts.

    // The keyword "public" makes variables accessible from other contracts
    // The keyword "public" automatically generates a default basic "getter" functions that allows you to access the current value of the state variable from outside the contract. Without this keyword, other contracts have no way to access the variable. 

    address public minter; 
    mapping(address => uint) public balances; // creates public state variable
    // mapping type maps addresses to unsigned integers
    // mappings can be seen as hash tables
    // the getter function created by the public keyword is slightly more complex in the case of a mapping

    // Events allow clients to react to specific contract changes you declare
    event Sent(address from, address to, uint amount);
    // this declares an event - Ethereum clients can listen for these events without much cost. As soon as it is emitted, the listener receives the arguments (from, to, amount) which makes it possible to track transactions

    // Constructor is a special function that is only executed when the contract is created and CANNOT be called afterwards. In this case, it permanently stores the address of the person creating the contract
    constructor() {
        minter = msg.sender; // msg is a special global variable that contains propertes which allow access to the blockchain. msg.sender is always the address where the current function call came from
    }

    // Sends an amount of newly created coins to another address
    function mint(address receiver, uint amount) public {
        require(msg.sender == minter); // require function defines conditions that read - in this case - the contract can only be called by the contract creator else contract reverts
        balances[receiver] += amount;
    }

    // Errors allow you to provide information to the caller about why a condition or an operation failed. Errors are used together with the revert statement.

    // The revert statement unconditionally aborts andreverts all changes (similiar to the require function) But allow you to provide the name of an error and additional data which will be supplied to the caller (and eventually to the front-end application or block explorer) so that a failure can more easily be debugged or reacted upon.
    error InsufficientBalance(uint requested, uint available);

    // The send function can be used by anyone (who already has some of these coins) to send coins to anyone else. If the sender does NOT have enough coins to send, the if condition evaluates to true and as a result, the revert will cause the operation to fail while providing the sender with error details using the InsufficientBalance error.
    function send(address receiver, uint amount) public {
        require(amount <= balances[msg.sender], InsufficientBalance(amount, balances[msg.sender]));
        balances[msg.sender] -= amount;
        balances[receiver] += amount;
        emit Sent(msg.sender, receiver, amount);
    }
}
```

### Blockchain Basics

## Transactions 

* A blockchain is a globally shared, transactional database. 

* This means everyone can read entries in the database just by participating in the network. 

* If you want to change something in the database, you have to create a "transaction" which has to be accepted by all others. If, for whatever reason, the transaction is not possible, then no account is modified. 

* Furthermore, every transaction is always cryptographically signed by the sender (creator). This makes guarding access to specific modifications of the database straightforward.

## Blocks

* As part of the "order selection mechanism", which is called attestation, it may happen that blocks are reverted from time to time, but only at the tip of the chain. 

* The more blocks added on top of a particular block, the less likely this block will be reverted.

* So, your transactions might be reverted and even removed from the blockchain, but the longer you wait, the less likely it will be.

### The Ethereum Virtual Machine (The EVM)

## Overview

* The EVM is the runtime environment for smart contracts in Ethereum. It is not only sandboxed but actually completely isolated, which means that code running inside the EVM has NO access to network, filesystem, or other precesses. Smart contracts even have limited access to other smart contracts.

## Accounts

* There are two kinds of accounts in Ethereum which share the same address space: 
** External Account or Externally Owned Account (EOA): which are controlled by public-private key pair
** Contract Accounts: which are controlled by the code stored together with the account

* The address of the EOA is determined from the public key 
* The contract address is determined by the sender's address and nonce. When a contract is created, its address is computed by taking the Keccak-25 hash of the RLP-encoded list of the creator's address and nonce, and then taking the rightmost 20 bytes of this hash.

* Both contract types are treated equally by the EVM

* Every account has a persistent key-value store called storage.

* Every account has a balance in Ether (in "Wei" to be exact)

## Transactions

* A transaction is a message sent from one account to another (which might be the same account, or an empty account). The message can include binary data (which is called "payload") and/or Ether.

* If the target account contains code, that code is executed and the payload is provided as input data.

* If the target account is not set (meaning the transaction does not have a recipient or the recipient is set to null)  the transaction creates a new contract.

## Gas

* Each transaction is charged with a certain amount of gas that has to be paid for the by the originator of the transaction (tx.origin).

* If gas is used up at any point, an out-of-gas exception is triggered which ends execution and reverts all modifications made to the state in the current call frame.

* Gas incentivizes economical use of the EVM execution time & also compensates EVM executors (i.e.: miners / stakers). Since each block has a maximum amount of gas, it also limits the amount of work needed to validate a block.

* The gas price is a value set by the originator of the transaction, who has to pay (gas_price * gas) up front to the EVM executor. If some gas is left after execution, it is refunded to the transaction originator. In case of an exception that reverts changes, already used up gas is not refunded.