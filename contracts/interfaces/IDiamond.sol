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
   * @dev emit when buddy initialized
   */
  event Initailized(address og, address yg);
}
