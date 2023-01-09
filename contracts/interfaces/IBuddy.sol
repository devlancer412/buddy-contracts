// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

interface IBuddy {
  /**
   * @dev enum of buddy attributes
   */
  enum Attributes {
    Level,
    SkillScore,
    Mints,
    XRCSGains,
    Luck,
    Recovery,
    UpperBodyStrength,
    LowerBodyStrength,
    CoreStrength
  }

  /**
   * @dev emit when buddy attributes updated
   */
  event UpdatedAttribute(uint256 indexed tokenId, Attributes attribute, uint256 value);
}
