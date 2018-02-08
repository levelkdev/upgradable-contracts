pragma solidity ^0.4.18;

import './NumStorage.sol';

contract NumTracker {

  NumStorage _storage;

  function NumTracker(NumStorage numStorage) public {
    _storage = numStorage;
  }

  function setNum(uint num) public {
    _storage.setNum(num);
  }

  function num() public view returns (uint) {
    return _storage.num();
  }
}
