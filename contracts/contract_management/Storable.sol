pragma solidity 0.4.18;

contract Storable {
  address public _storage;

  function Storable(address storageAddress) {
    _storage = storageAddress;
  }
}
