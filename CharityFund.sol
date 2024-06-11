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
