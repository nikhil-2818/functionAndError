# Error Handling in Solidity

## Overview

This program is a simple contract written in Solidity, a programming language used for developing smart contracts on the Ethereum blockchain. The `CharityFund` contract has three function that shows the functionality demonstrating the use of error handling mechanism in solidity. This contract includes examples of using `require`, `revert`, and `assert` Methods to enforce conditions and ensure the contract behaves as expected.
The three methods that consitutes error handling are descricbe below:
1. **require()**: Used to validate certain conditions before further execution of a function. It takes two parameters as an input.The first parameter is the condition that you want to validate and the second parameter is the message that will be passed back to the caller if the condition fails. If the condition is satisfied, then the execution of the function continues and the execution jumps to the next statement.
2. **revert()**: Can be used to flag an error and revert the current call. You can also provide a message containing details about the error, and the message will be passed back to the caller. Causes the EVM to revert all the changes made to the state, and things return to the initial state or the state before the function call was made. It also helps in saving gas.
3. **assert()**: takes only one parameter as input. You pass a condition to assert(), and if the condition is true, then the function execution continues and the execution jumps to the next statement in the function.

## Contract Details

### State Variables

- `totalDonations`: Tracks the total amount of Ether donated to the fund.
- `minimumDonation`: Defines the minimum donation amount allowed.
- `owner`: Address of the contract owner, who has the authority to withdraw funds.

### Event
- `Donation`: Event emitted when a donation is made. It includes the donor's address and the donated amount.
  
### Function 
-> `constructor`: Initializes the contract with a specified minimum donation amount.

-> `donate`: Allows users to donate Ether to the fund. Requires that the donation amount is greater than or equal to the minimum donation amount.

-> `withdraw`: Enables the owner to withdraw funds from the contract. Only the owner can call this function, and the withdrawal amount must not exceed the total donations.

## Usage
to uses this contract or exectue you can use Remix, an online Solidity IDE. To get started, go to the Remix website at https://remix.ethereum.org/.

Once you are on the Remix website, create a new file by clicking on the "+" icon in the left-hand sidebar. Save the file with a .sol extension (e.g., CharityFund.sol). Copy and paste the following code into the file:

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract CharityFund {
    uint public totalDonations;
    uint public minimumDonation;
    address public owner;

    // Donation event for tracking
    event Donation(address indexed donor, uint amount);

    // Constructor to set the minimum donation amount
    constructor(uint minDonation) {
        minimumDonation = minDonation;
        owner = msg.sender;
    }

    // Donate function to accept donations
    function donate() public payable {
        require(msg.value >= minimumDonation, "Donation amount must be at least minimumDonation");
        totalDonations += msg.value;

        // Emit a donation event
        emit Donation(msg.sender, msg.value);
    }

    // Withdraw function restricted to owner
    function withdraw(uint amount) public {
        require(msg.sender == owner, "Only the owner can withdraw funds");

        // Check for valid withdrawal amount using assert
        assert(amount <= totalDonations);

        // Simulate unexpected condition
        if (amount > totalDonations) {
            revert("Unexpected error: Withdrawal amount exceeds totalDonations");
        }

        // Update totalDonations and transfer funds
        totalDonations -= amount;
        payable(msg.sender).transfer(amount);
    }
}

```
To compile the code, click on the "Solidity Compiler" tab in the left-hand sidebar. Make sure the "Compiler" option is set to "0.8.25" (or another compatible version), and then click on the "Compile CharityFund.sol" button.

Once the code is compiled, you can deploy the contract by clicking on the "Deploy & Run Transactions" tab in the left-hand sidebar. Select the "CharityFund" contract from the dropdown menu, and then click on the "Deploy" button.

Once the contract is deployed, you can use the deployed contract interface to call the donate, withdraw functions.You can enter addresses and values to test the functionality. After entering data, click on "transact" button to execute the function and donate, withdraw the amount and do testing. 

## Contact
For any questions or suggestions, feel free to open an issue or contact the repository owner.

Mail - nikhil.mkbn@gmail.com
