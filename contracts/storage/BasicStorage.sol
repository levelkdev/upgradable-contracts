pragma solidity 0.4.18;

contract BasicStorage {
  address public _storage;

  function BasicStorage(address storageAddress) {
    _storage = storageAddress;
  }
}
