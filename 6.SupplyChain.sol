// SPDX-License-Identifier: PLUTO
pragma solidity ^0.8.0;

contract SupplyChain {
    struct Product {
        string name;
        uint256 quantity;
        bool verified;
    }
    mapping(address => Product) public products;
    address payable public logisticsProvider;
    uint256 public totalPayment;

    constructor(address payable _logisticsProvider, uint256 _totalPayment) {
        logisticsProvider = _logisticsProvider;
        totalPayment = _totalPayment;
    }

    function addProduct(string memory _name, uint256 _quantity) public {
        products[msg.sender] = Product(_name, _quantity, false);
    }

    function verifyProduct(address _supplier) public {
        require(
            products[_supplier].quantity > 0,
            "No product found for the supplier"
        );
        products[_supplier].verified = true;
        logisticsProvider.transfer(totalPayment);
    }
}
