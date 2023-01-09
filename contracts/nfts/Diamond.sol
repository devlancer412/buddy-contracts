// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

import "../interfaces/IDiamond.sol";
import "../interfaces/IBuddy.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Strings.sol";
import "erc721a/contracts/ERC721A.sol";

contract Diamond is IDiamond, ERC721A, Ownable {
  using Strings for uint256;

  struct DiamondAttribute {
    uint128 diamondType;
    uint128 level;
    address buddyAddress;
    uint256 tokenId;
  }

  // buddy contract addresses
  address public og;
  address public yg;

  uint256 public currentPrice;

  string private _baseURIextended;
  string public uriSuffix = ".json";

  /**
   * @param _uri Token URI used for metadata
   */
  constructor(string memory _uri) ERC721A("Diamond", "ICE") {
    _baseURIextended = _uri;
  }

  modifier afterInitalized() {
    require(og != address(0) || yg != address(0), "Diamond: Not initialized yet");
    _;
  }

  /**
   * @dev initailize buddy contracts
   * @param _og OG Buddy address
   * @param _yg YG Buddy address
   */
  function initalize(address _og, address _yg) external onlyOwner {
    require(og == address(0) && yg == address(0), "Diamond: already initialized");
    require(_og != address(0), "Diamond: Invalid buddy address");
    require(_yg != address(0), "Diamond: Invalid buddy address");

    og = _og;
    yg = _yg;

    emit Initailized(og, yg);
  }

  /**
   * @dev Sets the price of each NFT during the initial sale.
   * @param price The price of each NFT during the initial sale | precision:18
   */
  function setCurrentPrice(uint256 price) external onlyOwner {
    currentPrice = price;
  }

  function _baseURI() internal view virtual override returns (string memory) {
    return _baseURIextended;
  }

  /**
   * @dev Gets the uri of nft.
   * @param _tokenId id of nft
   */
  function tokenURI(uint256 _tokenId) public view virtual override returns (string memory) {
    require(_exists(_tokenId), "ERC721Metadata: URI query for nonexistent token");

    string memory currentBaseURI = _baseURI();
    return
      bytes(currentBaseURI).length > 0
        ? string(abi.encodePacked(currentBaseURI, _tokenId.toString(), uriSuffix))
        : "";
  }

  /**
   * @dev Gets the uri suffix of nft metadata | precision:.json.
   * @param _uriSuffix uri suffix of nft metadata
   */
  function setUriSuffix(string memory _uriSuffix) external onlyOwner {
    uriSuffix = _uriSuffix;
  }
}
