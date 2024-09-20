Here's a simple README for the provided smart contract:

---

# NFT Marketplace Smart Contract

## Overview

This is an NFT Marketplace smart contract that allows users to mint, list, and buy NFTs. The contract implements the ERC-721 standard for NFTs and introduces functionality for minting, listing NFTs for sale, and purchasing them. Only approved minters are allowed to mint new NFTs, and the contract owner has control over which addresses are approved for minting.

### Features:

- **Minting NFTs**: Only approved minters can create new NFTs.
- **Listing NFTs**: Owners of NFTs can list them for sale at a fixed price.
- **Buying NFTs**: Users can purchase listed NFTs by sending the correct payment in Ether.
- **Access Control**: Only the contract owner can approve addresses for minting.

## Getting Started

### Prerequisites

To deploy or interact with the contract, ensure you have the following:

- **Solidity Version**: `^0.8.24`
- **OpenZeppelin Contracts**: The contract relies on several OpenZeppelin libraries:
  - `IERC721` and `ERC721URIStorage` for NFT functionality.
  - `Ownable` for access control.

### Deployment

1. Clone the repository.
2. Compile the contract using a Solidity compiler or Hardhat.
3. Deploy the contract to your preferred Ethereum network.
4. Set the contract owner as the deployer address.

### Key Functions

#### `approveMinter(address minter)`

- **Description**: Allows the contract owner to approve an address for minting NFTs.
- **Parameters**:
  - `minter`: The address to be approved.
- **Access**: Only callable by the contract owner.

#### `mint(address to, string memory tokenURI)`

- **Description**: Allows approved minters to mint a new NFT with a given token URI.
- **Parameters**:
  - `to`: The address to receive the newly minted NFT.
  - `tokenURI`: The URI pointing to the NFT metadata.
- **Returns**: The newly minted token ID.
- **Access**: Only callable by approved minters.

#### `listNFT(uint256 tokenId, uint256 price)`

- **Description**: Allows the owner of an NFT to list it for sale at a specified price.
- **Parameters**:
  - `tokenId`: The ID of the NFT being listed.
  - `price`: The sale price of the NFT (in Wei).
- **Requirements**:
  - Caller must own the NFT.
  - NFT must be approved for sale by the marketplace.

#### `buyNFT(uint256 tokenId)`

- **Description**: Allows users to purchase a listed NFT by sending the correct amount of Ether.
- **Parameters**:
  - `tokenId`: The ID of the NFT to be purchased.
- **Requirements**:
  - The NFT must be listed for sale.
  - The buyer must send sufficient Ether to cover the sale price.

## Events

- **`ListingCreationSuccessful(uint256 indexed tokenId, address indexed seller, uint256 price)`**: Emitted when an NFT is successfully listed for sale.
- **`PurchaseSuccessful(uint256 indexed tokenId, address indexed seller, address indexed buyer, uint256 price)`**: Emitted when an NFT is successfully purchased.

## Example Usage

1. **Minting**: Once approved by the owner, a minter can mint new NFTs by calling `mint(address to, string memory tokenURI)`.
2. **Listing**: The owner of an NFT can list it for sale by calling `listNFT(uint256 tokenId, uint256 price)` and ensuring that the marketplace contract is approved for the NFT.

3. **Buying**: Any user can purchase a listed NFT by calling `buyNFT(uint256 tokenId)` and sending the required Ether.

## License

This project is licensed under the MIT License.

```shell
npx hardhat help
npx hardhat test
REPORT_GAS=true npx hardhat test
npx hardhat node
npx hardhat ignition deploy ./ignition/modules/Lock.ts
```
