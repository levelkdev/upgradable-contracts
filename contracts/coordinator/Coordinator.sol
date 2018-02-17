pragma solidity 0.4.18;

import '../delegated_storage/DelegatedStorage.sol';
import '../delegated_storage/KeyManagerInterface.sol';
import '../proxy/DelegateManagerInterface.sol';
import 'zeppelin-solidity/contracts/ownership/Ownable.sol';
import './CoordinatorStorageDelegate.sol';

contract Coordinator is KeyManagerInterface, DelegateManagerInterface, Ownable {

  CoordinatorStorageDelegate public _storage;
  CoordinatorStorageDelegate public delegate;

  function Coordinator(address coordinatorStorageDelegate) public {
    _storage = CoordinatorStorageDelegate(new DelegatedStorage(this, this));
    delegate = CoordinatorStorageDelegate(coordinatorStorageDelegate);
  }

  function setContract(string _key, address contract_) public onlyOwner {
    _storage.setRegisteredContract(keccak256(_key), contract_);
    _storage.setRegisteredContractKey(contract_, keccak256(_key));
  }

  function removeContract(string _key) public onlyOwner {
    _storage.deleteRegisteredContract(keccak256(_key));
  }

  function setStorageDelegate(string _key, address _delegate) public onlyOwner {
    _storage.setRegisteredStorageDelegate(keccak256(_key), _delegate);
  }

  function setDelegate(string _key, address _delegate) public onlyOwner {
    _storage.setRegisteredDelegate(keccak256(_key), _delegate);
  }

  // KeyManagerInterface
  function keyForContract(address contract_) public view returns (bytes32) {
    if (contract_ == address(this))
      return keccak256("Coordinator");
    return _storage.getRegisteredContractKey(contract_);
  }

  // DelegateManagerInterface
  function delegateForContract(address contract_) public view returns (address) {
    if (msg.sender == address(_storage)) {
      if (contract_ == address(this))
        return delegate;
      return _storage.getRegisteredStorageDelegate(keyForContract(contract_));
    } else {
      return _storage.getRegisteredDelegate(keyForContract(msg.sender));
    }
  }
}
