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

  struct Sig {
    bytes32 r;
    bytes32 s;
    uint8 v;
  }

  /**
   * @dev emit when buddy attributes updated
   */
  event UpdatedAttribute(uint256 indexed tokenId, Attributes attribute, uint256 value);

  /**
   * @dev fire when diamond injected to buddy
   */
  event DiamondInject(uint256 slotId, uint256 diamondId, uint256 buddyId);

  /**
   * @dev fire when diamond rejected from buddy
   */
  event DiamondReject(uint256 slotId, uint256 diamondId, uint256 buddyId);

  /**
   * @dev inject diamond to buddy
   * @param _diamondId id of diamond
   * @param _buddyId id of budddy
   * @param _slotId id of slot
   * @param _sig signature of owner
   */
  function injectDiamond(
    uint256 _diamondId,
    uint256 _buddyId,
    uint256 _slotId,
    Sig calldata _sig
  ) external returns (bool);

  /**
   * @dev reject diamond to buddy
   * @param _diamondId id of diamond
   * @param _buddyId id of budddy
   * @param _slotId id of slot
   * @param _sig signature of owner
   */
  function rejectDiamond(
    uint256 _diamondId,
    uint256 _buddyId,
    uint256 _slotId,
    Sig calldata _sig
  ) external returns (bool);
}
