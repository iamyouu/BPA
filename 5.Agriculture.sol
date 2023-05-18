// SPDX-License-Identifier: PLUTO
pragma solidity ^0.8.0;

contract AgricultureContract {
    struct Product {
        uint256 productId;
        string productName;
        address producer;
        uint256 timestamp;
    }

    mapping(uint256 => Product) public products;
    uint256 public productCount;

    event ProductAdded(
        uint256 indexed productId,
        string productName,
        address indexed producer,
        uint256 timestamp
    );

    function addProduct(uint256 _productId, string memory _productName) public {
        require(
            products[_productId].productId != _productId,
            "Product with the same ID already exists"
        );

        products[_productId] = Product(
            _productId,
            _productName,
            msg.sender,
            block.timestamp
        );
        productCount++;

        emit ProductAdded(
            _productId,
            _productName,
            msg.sender,
            block.timestamp
        );
    }

    function getProduct(uint256 _productId)
        public
        view
        returns (
            uint256,
            string memory,
            address,
            uint256
        )
    {
        require(
            products[_productId].productId == _productId,
            "Product does not exist"
        );

        Product memory product = products[_productId];
        return (
            product.productId,
            product.productName,
            product.producer,
            product.timestamp
        );
    }
}
