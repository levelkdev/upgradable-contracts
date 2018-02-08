pragma solidity 0.4.18;

import '../contract_management/PersistentStorage.sol';

contract NumStorage is PersistentStorageDelegate {

  function setNum(uint num) public {
    setUint("num", num);
  }

  function num() public view returns (uint) {
    return getUint("num");
  }
}
