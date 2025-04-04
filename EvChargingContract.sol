// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./oz_contracts/access/Ownable.sol";
import "./oz_contracts/token/ERC20/ERC20.sol";


contract EVChargingContract {
    address public owner;
    uint public chargingRate; // Cost per kWh 
    uint public rewardRate; // Reward per minute in wei
    mapping(address => uint) public chargingStartTimes;
    mapping(address => uint) public totalCharges;
    mapping(address => uint) public totalRewards;

    event ChargingStarted(address indexed user, uint startTime);
    event ChargingEnded(address indexed user, uint endTime, uint totalCharge);
    event TokensTransferred(address indexed user, uint amount);
    
    ERC20 public token;

    constructor(uint _chargingRate, uint _rewardRate, address _tokenAddress) {
        owner = msg.sender;
        chargingRate = _chargingRate;
        rewardRate = _rewardRate;
        token = ERC20(_tokenAddress);
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Only contract owner can call this function");
        _;
    }

    modifier onlyUser() {
        require(msg.sender != owner, "Only user can call this function");
        _;
    }
        
    // function mint(address _this, uint256 _amount) external onlyOwner {
    //     token.mintTokens(_this, _amount);
    // }
    
    function startCharging() public onlyUser {
        require(chargingStartTimes[msg.sender] == 0, "Charging session already started");
        chargingStartTimes[msg.sender] = block.timestamp;
        emit ChargingStarted(msg.sender, block.timestamp);
    }

    function endCharging() public onlyUser {
        require(chargingStartTimes[msg.sender] != 0, "Charging session started already");
        uint startTime = chargingStartTimes[msg.sender];
        uint endTime = block.timestamp;
        uint duration = endTime - startTime;
        uint charge = (duration * chargingRate);
        totalCharges[msg.sender] += charge;
        chargingStartTimes[msg.sender] = 0; // Reset 
        
        uint reward = (duration * rewardRate);
        require(token.transfer(msg.sender, reward), "Token transfer failed");    
        emit ChargingEnded(msg.sender, endTime, charge);
        emit TokensTransferred(msg.sender, reward);
    }

    function withdrawTokens() public onlyOwner {
        uint amount = token.balanceOf(address(this));
        require(token.transfer(owner, amount), "Token transfer failed");
    }
}

contract RestaurantContract {
    address public owner;
    ERC20 public token; 

    event TokensReceived(address indexed from, uint amount);
    event GoodsDelivered(address indexed to, uint amount);
    event TokensTransferred(address indexed user, uint amount);


    constructor(address _tokenAddress) {
        owner = msg.sender;
        token = ERC20(_tokenAddress);
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Owner only");
        _;
    }

    function checkUserTokenBalance(address _user) public view returns (uint) {
        return token.balanceOf(_user);
    }

    function transferTokensFromUser(address _user, uint _amount) public onlyOwner {
        require(token.balanceOf(_user) >= _amount, "No enough tokens");
        require(token.transfer(owner, _amount), "Transfer failed");
        emit TokensTransferred(owner, _amount);
    }

    function withdrawTokens() public onlyOwner {
        uint amount = token.balanceOf(address(this));
        require(token.transfer(owner, amount), "Transfer failed");
    }
}
