// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./ERC20.sol";

contract RestaurantContract {
    address public owner;
    ERC20 public token; // ERC20 token contract address

    event TokensReceived(address indexed from, uint256 amount);
    event GoodsDelivered(address indexed to, uint256 amount);
    event TokensTransferred(address indexed user, uint amount);


    constructor(address _tokenAddress) {
        owner = msg.sender;
        token = ERC20(_tokenAddress);
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Owner only");
        _;
    }

    function checkUserTokenBalance(address _user) public view returns (uint256) {
        return token.balanceOf(_user);
    }

    function transferTokensFromUser(address _user, uint256 _amount) public onlyOwner {
        require(token.balanceOf(_user) >= _amount, "No enough tokens");
        require(token.transfer(owner, _amount), "Transfer failed");
        emit TokensTransferred(owner, _amount);
    }

    function withdrawTokens() public onlyOwner {
        uint256 amount = token.balanceOf(address(this));
        require(token.transfer(owner, amount), "Transfer failed");
    }
}
