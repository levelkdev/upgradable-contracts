pragma solidity 0.4.18;

import '../contract_management/PersistentStorage.sol';

contract NumStorage is PersistentStorage {

  function setNum(uint num) public {
    setUint(keccak256("num"), num);
  }

  function num() public view returns (uint) {
    return getUint(keccak256("num"));
  }
}
