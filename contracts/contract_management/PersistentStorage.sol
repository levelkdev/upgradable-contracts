pragma solidity 0.4.18;

import './KeyManagerInterface.sol';

contract PersistentStorage {

  mapping(bytes32 => uint256) internal uIntStorage;
  mapping(bytes32 => string) internal stringStorage;
  mapping(bytes32 => address) internal addressStorage;
  mapping(bytes32 => bytes) internal bytesStorage;
  mapping(bytes32 => bytes32) internal bytes32Storage;
  mapping(bytes32 => bool) internal boolStorage;
  mapping(bytes32 => int256) internal intStorage;

  /**** Get Methods ***********/

  /// @param _key The key for the record
  function getAddress(bytes32 _key) public view returns (address) {
    return addressStorage[scopedKey(_key)];
  }

  /// @param _key The key for the record
  function getUint(bytes32 _key) public view returns (uint) {
    return uIntStorage[scopedKey(_key)];
  }

  /// @param _key The key for the record
  function getString(bytes32 _key) public view returns (string) {
    return stringStorage[scopedKey(_key)];
  }

  /// @param _key The key for the record
  function getBytes(bytes32 _key) public view returns (bytes) {
    return bytesStorage[scopedKey(_key)];
  }

  /// @param _key The key for the record
  function getBytes32(bytes32 _key) public view returns (bytes32) {
    return bytes32Storage[scopedKey(_key)];
  }

  /// @param _key The key for the record
  function getBool(bytes32 _key) public view returns (bool) {
    return boolStorage[scopedKey(_key)];
  }

  /// @param _key The key for the record
  function getInt(bytes32 _key) public view returns (int) {
    return intStorage[scopedKey(_key)];
  }

  /**** Set Methods ***********/

  /// @param _key The key for the record
  function setAddress(bytes32 _key, address _value) public {
    addressStorage[scopedKey(_key)] = _value;
  }

  /// @param _key The key for the record
  function setUint(bytes32 _key, uint _value) public {
    uIntStorage[scopedKey(_key)] = _value;
  }

  /// @param _key The key for the record
  function setString(bytes32 _key, string _value) public {
    stringStorage[scopedKey(_key)] = _value;
  }

  /// @param _key The key for the record
  function setBytes(bytes32 _key, bytes _value) public {
    bytesStorage[scopedKey(_key)] = _value;
  }

  /// @param _key The key for the record
  function setBytes32(bytes32 _key, bytes32 _value) public {
    bytes32Storage[scopedKey(_key)] = _value;
  }

  /// @param _key The key for the record
  function setBool(bytes32 _key, bool _value) public {
    boolStorage[scopedKey(_key)] = _value;
  }

  /// @param _key The key for the record
  function setInt(bytes32 _key, int _value) public {
    intStorage[scopedKey(_key)] = _value;
  }

  /**** Delete Methods ***********/

  /// @param _key The key for the record
  function deleteAddress(bytes32 _key) public {
    delete addressStorage[scopedKey(_key)];
  }

  /// @param _key The key for the record
  function deleteUint(bytes32 _key) public {
    delete uIntStorage[scopedKey(_key)];
  }

  /// @param _key The key for the record
  function deleteString(bytes32 _key) public {
    delete stringStorage[scopedKey(_key)];
  }

  /// @param _key The key for the record
  function deleteBytes(bytes32 _key) public {
    delete bytesStorage[scopedKey(_key)];
  }

  /// @param _key The key for the record
  function deleteBytes32(bytes32 _key) public {
    delete bytes32Storage[scopedKey(_key)];
  }

  /// @param _key The key for the record
  function deleteBool(bytes32 _key) public {
    delete boolStorage[scopedKey(_key)];
  }

  /// @param _key The key for the record
  function deleteInt(bytes32 _key) public {
    delete intStorage[scopedKey(_key)];
  }

  /// @param _key The key for the record
  function scopedKey(bytes32 _key) internal view returns(bytes32) {
    return _key;
  }
}
