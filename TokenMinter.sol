pragma solidity ^0.8.0;

import "./IERC20.sol"; // Import the ERC20 interface

contract TokenMinter {
    address public admin;
    IERC20 public token; // Assuming you have a pre-deployed ERC20 token contract

    event w(address indexed to, uint256 amount);

    constructor(address _tokenAddress) {
        admin = msg.sender;
        token = IERC20(_tokenAddress);
    }

    modifier onlyAdmin() {
        require(msg.sender == admin, "Only admin can call this function");
        _;
    }

    // Function for the admin to mint tokens and assign them to a specific address
    function mintTokens(address _to, uint256 _amount) external onlyAdmin {
        require(_to != address(0), "Invalid address");
        require(_amount > 0, "Invalid amount");

        // Mint new tokens
        token.mint(_to, _amount);

        emit TokensMinted(_to, _amount);
    }
}