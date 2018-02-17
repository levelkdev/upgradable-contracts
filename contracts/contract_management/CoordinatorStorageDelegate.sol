pragma solidity 0.4.18;

import './PersistentStorage.sol';
// TODO: add protections to functions
contract CoordinatorStorageDelegate is PersistentStorage {

  /**** Get Methods ***********/

  /// @param key The key for the record
  function getRegisteredContract(bytes32 key) public view returns (address) {
    return getAddress(keccak256("registeredContracts", key));
  }

  /// @param contract_ The address of the contract
  function getRegisteredContractKey(address contract_) public view returns (bytes32) {
    return getBytes32(keccak256("registeredContractKeys", contract_));
  }

  /// @param key The key for the record
  function getRegisteredStorageDelegate(bytes32 key) public view returns (address) {
    return getAddress(keccak256("registeredStorageDelegates", key));
  }

  /// @param key The key for the record
  function getRegisteredDelegate(bytes32 key) public view returns (address) {
    return getAddress(keccak256("registeredDelegates", key));
  }

  /**** Set Methods ***********/

  /// @param key The key for the record
  /// @param contract_ The address of the contract
  function setRegisteredContract(bytes32 key, address contract_) public {
    setAddress(keccak256("registeredContracts", key), contract_);
  }

  /// @param contract_ The address of the contract
  /// @param key The key for the record
  function setRegisteredContractKey(address contract_, bytes32 key) public {
    setBytes32(keccak256("registeredContractKeys", contract_), key);
  }

  /// @param key The key for the record
  /// @param delegate The delegate for the contract key
  function setRegisteredStorageDelegate(bytes32 key, address delegate) public {
    setAddress(keccak256("registeredStorageDelegates", key), delegate);
  }

  /// @param key The key for the record
  /// @param delegate The delegate for the contract key
  function setRegisteredDelegate(bytes32 key, address delegate) public {
    setAddress(keccak256("registeredDelegates", key), delegate);
  }

  /**** Delete Methods ***********/

  /// @param key The key for the record
  function deleteRegisteredContract(bytes32 key) public {
    deleteAddress(keccak256("registeredContracts", key));
  }

  /// @param contract_ The address of the contract
  function deleteRegisteredContractKey(address contract_) public {
    deleteBytes32(keccak256("registeredContractKeys", contract_));
  }

  /// @param key The key for the record
  function deleteRegisteredStorageDelegate(bytes32 key) public {
    deleteAddress(keccak256("registeredStorageDelegates", key));
  }

  /// @param key The key for the record
  function deleteRegisteredDelegate(bytes32 key) public {
    deleteAddress(keccak256("registeredDelegates", key));
  }
}
