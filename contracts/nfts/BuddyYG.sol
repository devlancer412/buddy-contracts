// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

import "./BuddyBase.sol";

/**
 * @title Buddy YG Collection
 */
contract BuddyOG is BuddyBase {
  constructor(
    address usdc
  )
    BuddyBase(
      "Buddy YG",
      "BYG",
      "https://ipfs.io/ipfs/Qmbr491nZuoEsLHQ1PXihiSfoy9oSJrjUBCYWnfRoyijoJ",
      0,
      50000,
      usdc
    )
  {}
}
