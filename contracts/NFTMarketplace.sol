// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "@openzeppelin/contracts/token/ERC721/IERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/ReentrancyGuard.sol";

contract NFTMarketplace is IERC721, ERC721URIStorage, Ownable {
   
    uint256 private _tokenIds;

    struct NFTListing {
        address seller;
        uint256 price;
    }

    mapping(uint256 => NFTListing) public nftListings;
    mapping(address => bool) public approvedMinters;
    mapping(address => uint256) public sellerBalances;

    event ListingCreationSuccessful(uint256 indexed tokenId, address indexed seller, uint256 price);
    event PurchaseSuccessful(uint256 indexed tokenId, address indexed seller, address indexed buyer, uint256 price);

    constructor() ERC721("EDEN NFT", "EDEN") Ownable(msg.sender) {}

    modifier onlyApprovedMinter() {
        require(approvedMinters[msg.sender], "Unauthorized minter");
        _;
    }

    function approveMinter(address minter) external onlyOwner {
        approvedMinters[minter] = true;
    }

    function mint(address to, string memory tokenURI) external onlyApprovedMinter returns (uint256) {
        _tokenIds = _tokenIds + 1;

        _safeMint(to, _tokenIds);
        _setTokenURI(_tokenIds, tokenURI);
        return _tokenIds;
    }

    function listNFT(uint256 _tokenId, uint256 price) external {
        require(ownerOf(_tokenId) == msg.sender, "Not owner");
        require(getApproved(_tokenId) == address(this), "Not approved");
        
        nftListings[_tokenId] = NFTListing(msg.sender, price);

        emit ListingCreationSuccessful(_tokenId, msg.sender, price);
    }

    function buyNFT(uint256 _tokenId) external payable {
        NFTListing memory listing = nftListings[_tokenId];
        require(msg.value >= listing.price, "Incorrect amount");
        require(getApproved(_tokenId) == address(this), "Market not approved");

        address seller = listing.seller;
        uint256 salePrice = listing.price;

        delete nftListings[_tokenId];
        _transfer(seller, msg.sender, _tokenId);

        sellerBalances[seller] += salePrice;

        payable(msg.sender).transfer(msg.value - salePrice);

        emit PurchaseSuccessful(_tokenId, seller, msg.sender, salePrice);
    }
}