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

    function set(uint data) public {
        storedData = data;
    }

    function get() public view returns (uint) {
        return storedData;
    }
}
```

