pragma solidity ^0.4.18;

import './NumStorage.sol';
import '../contract_management/Proxy.sol';

contract NumTracker is Proxy {

  NumStorage _storage;

  function NumTracker(NumStorage numStorage) public {
    _storage = numStorage;
  }

  // Overrides delegateAddress() in Proxy.sol
  function delegateAddress() internal view returns (address) {
    return _storage.getDelegate();
  }
}
