pragma solidity 0.4.18;

import './PersistentStorageDelegate.sol';
import './ContractManagementStorage.sol';
import './KeyValueStorage.sol';
import './Proxy.sol';

contract PersistentStorage is ContractManagementStorage, KeyValueStorage, Proxy {

  address persistentStorageDelegate;

  function PersistentStorage(address _persistentStorageDelegate) public {
    // Set the main owner upon deployment
    contractManager = msg.sender;
    persistentStorageDelegate = _persistentStorageDelegate;
  }

  // Overrides delegateAddress() in Proxy.sols
  function delegateAddress() internal view returns (address) {
    return persistentStorageDelegate;
  }
}
