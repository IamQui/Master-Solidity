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



    // Events allow clients to react to specific contract changes you declare
    event Sent(address from, address to, uint amount);

    // Constructor code is only run when the contract is created
    constructor() {
        minter = msg.sender;
    }

    // Sends an amount of newly created coins to an address
    // Can only be called by the contract creator
    function mint(address receiver, uint amount) public {
        require(msg.sender == minter);
        balances[receiver] += amount;
    }

    // Errors allow you to provide information about why an operation failed.
    // They are returned to the caller of the function.
    error InsufficientBalance(uint requested, uint available);

    // Sends an amount of existing coins from any caller to an address
    function send(address receiver, uint amount) public {
        require(amount <= balances[msg.sender], InsufficientBalance(amount, balances[msg.sender]));
        balances[msg.sender] -= amount;
        balances[receiver] += amount;
        emit Sent(msg.sender, receiver, amount);
    }
}
```