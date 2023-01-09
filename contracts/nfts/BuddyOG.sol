// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

import "./BuddyBase.sol";

/**
 * @title Buddy OG Collection
 */
contract BuddyOG is BuddyBase {
  constructor(
    address usdc
  )
    BuddyBase(
      "Buddy OG",
      "BOG",
      "https://ipfs.io/ipfs/Qmbr491nZuoEsLHQ1PXihiSfoy9oSJrjUBCYWnfRoyijoJ",
      100000000,
      5000,
      usdc
    )
  {}
}
