pragma solidity 0.4.18;

import './ContractManagementStorage.sol';
import './KeyValueStorage.sol';
import './Proxy.sol';

contract PersistentStorageDelegate is ContractManagementStorage, KeyValueStorage, Proxy {

  /// @dev Only allow registered contracts
  modifier onlyRegisteredContract() {
    require(registeredContracts[registeredContractKeys[msg.sender]] != address(0));
    _;
  }

  /// @dev Only allow contractManager
  modifier onlyContractManager() {
    require(msg.sender == contractManager);
    _;
  }

  /**** Contract Management ***********/

  function setContract(string key, address _contract) public onlyContractManager {
    delete registeredContractKeys[registeredContracts[key]];
    registeredContracts[key] = _contract;
    registeredContractKeys[_contract] = key;
  }

  function removeContract(string key) public onlyContractManager {
    delete registeredContractKeys[registeredContracts[key]];
    delete registeredContracts[key];
  }

  function setProxy(string key, address proxy) public onlyContractManager {
    registeredProxies[key] = proxy;
  }

  function setContractManager(address _contractManager) public onlyContractManager {
    contractManager = _contractManager;
  }

  /**** Get Methods ***********/

  /// @param _key The key for the record
  function getAddress(bytes32 _key) public view returns (address) {
    return addressStorage[contractKey(_key)];
  }

  /// @param _key The key for the record
  function getUint(bytes32 _key) public view returns (uint) {
    return uIntStorage[contractKey(_key)];
  }

  /// @param _key The key for the record
  function getString(bytes32 _key) public view returns (string) {
    return stringStorage[contractKey(_key)];
  }

  /// @param _key The key for the record
  function getBytes(bytes32 _key) public view returns (bytes) {
    return bytesStorage[contractKey(_key)];
  }

  /// @param _key The key for the record
  function getBool(bytes32 _key) public view returns (bool) {
    return boolStorage[contractKey(_key)];
  }

  /// @param _key The key for the record
  function getInt(bytes32 _key) public view returns (int) {
    return intStorage[contractKey(_key)];
  }

  /**** Set Methods ***********/

  /// @param _key The key for the record
  function setAddress(bytes32 _key, address _value) onlyRegisteredContract public {
    addressStorage[contractKey(_key)] = _value;
  }

  /// @param _key The key for the record
  function setUint(bytes32 _key, uint _value) onlyRegisteredContract public {
    uIntStorage[contractKey(_key)] = _value;
  }

  /// @param _key The key for the record
  function setString(bytes32 _key, string _value) onlyRegisteredContract public {
    stringStorage[contractKey(_key)] = _value;
  }

  /// @param _key The key for the record
  function setBytes(bytes32 _key, bytes _value) onlyRegisteredContract public {
    bytesStorage[contractKey(_key)] = _value;
  }

  /// @param _key The key for the record
  function setBool(bytes32 _key, bool _value) onlyRegisteredContract public {
    boolStorage[contractKey(_key)] = _value;
  }

  /// @param _key The key for the record
  function setInt(bytes32 _key, int _value) onlyRegisteredContract public {
    intStorage[contractKey(_key)] = _value;
  }

  /**** Delete Methods ***********/

  /// @param _key The key for the record
  function deleteAddress(bytes32 _key) onlyRegisteredContract public {
    delete addressStorage[contractKey(_key)];
  }

  /// @param _key The key for the record
  function deleteUint(bytes32 _key) onlyRegisteredContract public {
    delete uIntStorage[contractKey(_key)];
  }

  /// @param _key The key for the record
  function deleteString(bytes32 _key) onlyRegisteredContract public {
    delete stringStorage[contractKey(_key)];
  }

  /// @param _key The key for the record
  function deleteBytes(bytes32 _key) onlyRegisteredContract public {
    delete bytesStorage[contractKey(_key)];
  }

  /// @param _key The key for the record
  function deleteBool(bytes32 _key) onlyRegisteredContract public {
    delete boolStorage[contractKey(_key)];
  }

  /// @param _key The key for the record
  function deleteInt(bytes32 _key) onlyRegisteredContract public {
    delete intStorage[contractKey(_key)];
  }

  /// @param _key The key for the record
  function contractKey(bytes32 _key) internal view returns(bytes32) {
    return keccak256(registeredContractKeys[msg.sender], _key);
  }

  // Overrides delegateAddress() in Proxy.sol
  function delegateAddress() internal view returns (address) {
    return registeredProxies[registeredContractKeys[msg.sender]];
  }
}
