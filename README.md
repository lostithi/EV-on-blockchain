# EV Charging Network on Blockchain

A **Solidity-based simulation** of a private EV charging network using blockchain and custom ERC20 tokens.
This was implemented as part of an EV projet 
## Overview

This project models interactions in a private EV charging ecosystem using smart contracts, including:

- An ERC20-compatible token used for payments.
- EV charging contracts for managing charging sessions and payments.
- Additional contracts for minting tokens and simulating off-chain actors (e.g. restaurants / partners). 

## Contract Files

| File                    | Description                               |  
|-------------------------|-------------------------------------------|  
| `ERC20.sol`            | Basic ERC20 token implementation used as the network currency. |  
| `EvChargingContract.sol` | Main EV charging smart contract for managing sessions and token payments. |  
| `TokenMinter.sol`      | Contract responsible for minting new tokens (e.g. for incentives or initial distribution). |  
| `Restuarant.sol`       | Example/auxiliary contract simulating another actor that can accept or interact with tokens. |  
 
## Project Structure

├─ .vscode/     # VS Code settings for Solidity/Flutter tooling    
├─ .gitattributes # Git LFS and text attributes  
├─ .gitignore # Ignored build/IDE files  
├─ ERC20.sol # ERC20 token contract  
├─ EvChargingContract.sol # EV charging logic contract  
├─ Restuarant.sol # Example auxiliary contract  
├─ TokenMinter.sol # Token minting contract  
└─ README.md # Project documentation  
 
## Getting Started

You can experiment with these contracts using Remix (easiest) or a local dev environment.

### Option 1: Use Remix IDE

1. Go to https://remix.ethereum.org.
2. Create new files and copy-paste the contents of the Solidity files from this repo (`ERC20.sol`, `EvChargingContract.sol`, etc.). 
3. Make sure the Solidity compiler version matches the pragma at the top of each file.
4. Compile each contract and deploy them in the desired order:
   - Deploy `ERC20` (or use an existing ERC20 implementation).
   - Deploy `TokenMinter` and configure it with the token address.
   - Deploy `EvChargingContract` and set the token address and any required parameters.
5. Use the Remix UI to:
   - Mint tokens using `TokenMinter`.
   - Start/stop charging sessions and pay with tokens via `EvChargingContract`.
   - Optionally interact with `Restuarant.sol` to simulate partner payments.
    
### Option 2: Local development (Hardhat/Foundry/etc.)

If you want a more advanced setup:

1. Initialize a new Solidity project (e.g. Hardhat).
2. Copy the `.sol` files into your `contracts/` folder.
3. Configure the compiler version in your toolchain.
4. Write deployment scripts and tests as needed. 

## Notes

- This repository focuses on **contract logic**, not on a full front-end or production deployment pipeline. 
 
