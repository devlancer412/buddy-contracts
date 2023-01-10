// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

interface IDiamond {
  /**
   * @dev enum of buddy
   */
  enum BuddyType {
    OG,
    YG
  }

  /**
   * @dev enum of diamond type
   */
  enum DiamondType {
    BMUpperBody,
    BMCore,
    BMLowerBody,
    REUpperBody,
    RECore,
    RELowerBody,
    BoosterCardio,
    BoosterStrength,
    XRCSgains,
    Luck,
    Recovery
  }

  /**
   * @dev fire when buddy initialized
   */
  event Initailized(address og, address yg);

  /**
   * @dev fire when buddy injected to buddy
   */
  event BuddyInject(uint256 diamondId, uint256 buddyId);

  /**
   * @dev fire when buddy rejected from buddy
   */
  event BuddyReject(uint256 diamondId, uint256 buddyId);

  /**
   * @dev inject buddy to diamond
   * @param _buddyId id of budddy
   * @param _diamondId id of diamond
   */
  function injectBuddy(uint256 _buddyId, uint256 _diamondId) external returns (bool);

  /**
   * @dev reject buddy to diamond
   * @param _buddyId id of budddy
   * @param _diamondId id of diamond
   */
  function rejectBuddy(uint256 _buddyId, uint256 _diamondId) external returns (bool);
}
