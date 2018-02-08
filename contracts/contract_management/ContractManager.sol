pragma solidity 0.4.18;

import './PersistentStorage.sol';
import './PersistentStorageDelegate.sol';
import 'zeppelin-solidity/contracts/ownership/Ownable.sol';

contract ContractManager is Ownable {

  PersistentStorageDelegate public _storage;

  function ContractManager(address persistentStorageDelegate) public {
    _storage = PersistentStorageDelegate(new PersistentStorage(persistentStorageDelegate));
  }

  function setContract(string key, address _contract) public onlyOwner {
    _storage.setContract(key, _contract);
  }

  function removeContract(string key) public onlyOwner {
    _storage.removeContract(key);
  }

  function setStorageDelegate(string key, address delegate) public onlyOwner {
    _storage.setStorageDelegate(key, delegate);
  }

  function setDelegate(string key, address delegate) public onlyOwner {
    _storage.setDelegate(key, delegate);
  }

  function setContractManager(address _contractManager) public onlyOwner {
    _storage.setContractManager(_contractManager);
  }

}
