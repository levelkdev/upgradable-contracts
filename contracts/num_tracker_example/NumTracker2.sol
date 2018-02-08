pragma solidity ^0.4.18;

import './NumTracker.sol';
import './NumStorage.sol';

contract NumTracker2 is NumTracker {

  function NumTracker2(NumStorage numStorage) NumTracker(numStorage) public {}

  function addOne() public {
    _storage.setNum(_storage.num() + 1);
  }

}
