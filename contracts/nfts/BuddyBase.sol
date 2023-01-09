// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

import "../interfaces/IBuddy.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Strings.sol";
import "erc721a/contracts/ERC721A.sol";

contract BuddyBase is IBuddy, ERC721A, Ownable {
  using Strings for uint256;

  struct BuddyAttribute {
    uint256 level;
    uint256 skillScore;
    uint256 mints;
    // dna attribute
    uint256 xrcsGains;
    uint256 luck;
    uint256 recovery;
    // strength attribute
    uint256 upperBodyStrength;
    uint256 lowerBodyStrength;
    uint256 coreStrength;
  }

  bool public saleIsActive = true;
  string private _baseURIextended;

  uint256 public immutable MAX_SUPPLY;

  uint256 public currentPrice;

  bool public revealed = false;
  string public hiddenMetadataUri;
  string public uriSuffix = ".json";

  address public immutable usdc;

  // nft attributes
  mapping(uint256 => BuddyAttribute) private attributes;

  /**
   * @param _name NFT Name
   * @param _symbol NFT Symbol
   * @param _uri Token URI used for metadata
   * @param price Initial Price | precision:18
   * @param maxSupply Maximum # of NFTs
   * @param _usdc address of usdc
   */
  constructor(
    string memory _name,
    string memory _symbol,
    string memory _uri,
    uint256 price,
    uint256 maxSupply,
    address _usdc
  ) payable ERC721A(_name, _symbol) {
    currentPrice = price;
    MAX_SUPPLY = maxSupply;
    hiddenMetadataUri = _uri;

    usdc = _usdc;
  }

  /**
   * @dev An external method for users to purchase and mint NFTs. Requires that the sale
   * is active, that the minted NFTs will not exceed the `MAX_SUPPLY`, and that a
   * sufficient payable value is sent.
   * @param amount The number of NFTs to mint.
   */
  function mint(uint256 amount) external payable {
    uint256 ts = totalSupply();

    require(saleIsActive, "BuddyBase: Sale must be active to mint tokens");
    require(ts + amount <= MAX_SUPPLY, "BuddyBase: Purchase would exceed max tokens");
    require(currentPrice * amount == msg.value, "BuddyBase: Value sent is not correct");

    _safeMint(msg.sender, amount);
  }

  /**
   * @dev A way for the owner to reserve a specifc number of NFTs without having to
   * interact with the sale.
   * @param to The address to send reserved NFTs to.
   * @param amount The number of NFTs to reserve.
   */
  function reserve(address to, uint256 amount) external onlyOwner {
    uint256 ts = totalSupply();
    require(ts + amount <= MAX_SUPPLY, "BuddyBase: Purchase would exceed max tokens");
    _safeMint(to, amount);
  }

  /**
   * @dev A way for the owner to withdraw all proceeds from the sale.
   */
  function withdraw() external onlyOwner {
    payable(owner()).transfer(address(this).balance);
  }

  /**
   * @dev Sets whether or not the NFT sale is active.
   * @param isActive Whether or not the sale will be active.
   */
  function setSaleIsActive(bool isActive) external onlyOwner {
    saleIsActive = isActive;
  }

  /**
   * @dev Sets the price of each NFT during the initial sale.
   * @param price The price of each NFT during the initial sale | precision:18
   */
  function setCurrentPrice(uint256 price) external onlyOwner {
    currentPrice = price;
  }

  /**
   * @dev Updates the baseURI that will be used to retrieve NFT metadata.
   * @param baseURI_ The baseURI to be used.
   */
  function setBaseURI(string memory baseURI_) external onlyOwner {
    _baseURIextended = baseURI_;
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

    if (revealed == false) {
      return hiddenMetadataUri;
    }

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

  /**
   * @dev Sets the revealed setting.
   * @param _state if _state is true, shows reall nft, else shows hidden data
   */
  function setRevealed(bool _state) external onlyOwner {
    revealed = _state;
  }

  /**
   * @dev updates nft attribute
   * @param _tokenId if of nft
   * @param _attribute attribute to update
   * @param _value attribute value
   */
  function updateAttribute(
    uint256 _tokenId,
    Attributes _attribute,
    uint256 _value
  ) public onlyOwner {
    if (_attribute == Attributes.Level) {
      attributes[_tokenId].level = _value;
    } else if (_attribute == Attributes.SkillScore) {
      attributes[_tokenId].skillScore = _value;
    } else if (_attribute == Attributes.Mints) {
      attributes[_tokenId].mints = _value;
    } else if (_attribute == Attributes.XRCSGains) {
      attributes[_tokenId].xrcsGains = _value;
    } else if (_attribute == Attributes.Luck) {
      attributes[_tokenId].luck = _value;
    } else if (_attribute == Attributes.Recovery) {
      attributes[_tokenId].recovery = _value;
    } else if (_attribute == Attributes.UpperBodyStrength) {
      attributes[_tokenId].upperBodyStrength = _value;
    } else if (_attribute == Attributes.LowerBodyStrength) {
      attributes[_tokenId].lowerBodyStrength = _value;
    } else if (_attribute == Attributes.CoreStrength) {
      attributes[_tokenId].coreStrength = _value;
    } else {
      require(false, "BuddyBase: Invalid attribute");
    }

    emit UpdatedAttribute(_tokenId, _attribute, _value);
  }
}
