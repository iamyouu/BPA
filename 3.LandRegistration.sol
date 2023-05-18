//SPDX-License-Identifier: PLUTO
pragma solidity ^0.8.0;

contract LandRegistration {
    struct Land {
        uint256 cost;
        bool isRegistered;
        address registerer;
    }
    // Define the mapping of LandOwners to their details
    mapping(uint256 => Land) public lands;
    event landRegistered(address indexed from, address indexed to, uint256 Id);
    event amountDeposited(
        address indexed from,
        address indexed to,
        uint256 amount
    );

    receive() external payable {}

    function checkbal() public view returns (uint256) {
        return address(this).balance;
    }

    // Define the function to register land
    function addLand(uint256 landId, uint256 cost) public {
        require(!lands[landId].isRegistered, "Land already registered");
        lands[landId] = Land({
            cost: cost,
            isRegistered: true,
            registerer: msg.sender
        });
        emit landRegistered(msg.sender, address(this), landId);
    }

    //Update the Land Ownership
    function updateLand(uint256 landId, uint256 cost) public {
        require(cost == 2 * lands[landId].cost, "Insuffient amount given");
        lands[landId] = Land({
            cost: cost * 2,
            isRegistered: true,
            registerer: msg.sender
        });
        emit landRegistered(msg.sender, address(this), landId);
    }

    //Transfer land Ownership
    function transferLand(uint256 landId, address newOwner) public {
        require(
            lands[landId].registerer == msg.sender,
            "You are not the owner of this land"
        );

        lands[landId].registerer = newOwner;
        emit amountDeposited(msg.sender, newOwner, lands[landId].cost);
    }

    // Define the function to pay the amount
    function payAmt(uint256 landId) public payable {
        Land storage land = lands[landId];
        require(land.isRegistered, "land not registered");
        require(msg.value >= land.cost, "Insufficient amount paid");
        // Deposit the premium to the insurance company's account
        (bool success, ) = address(this).call{value: land.cost}("");
        require(
            success,
            "Failed to deposit premium to the insurance company's account"
        );
        // Emit the GST deposited event
        emit amountDeposited(msg.sender, address(this), land.cost);
    }
}
