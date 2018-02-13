pragma solidity 0.4.18;

import './DelegatedStorage.sol';
import './KeyManagerInterface.sol';
import './DelegateManagerInterface.sol';
import 'zeppelin-solidity/contracts/ownership/Ownable.sol';
import './ContractManagementStorageDelegate.sol';

contract ContractManager is KeyManagerInterface, DelegateManagerInterface, Ownable {

  ContractManagementStorageDelegate public _storage;
  ContractManagementStorageDelegate public delegate;

  function ContractManager(address contractManagementStorageDelegate) public {
    _storage = ContractManagementStorageDelegate(new DelegatedStorage(this, this));
    delegate = ContractManagementStorageDelegate(contractManagementStorageDelegate);
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
      return keccak256("ContractManager");
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
