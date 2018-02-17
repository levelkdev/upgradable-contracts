pragma solidity ^0.4.18;

import '../proxy/DelegateManagable.sol';
import '../proxy/DelegateManagerInterface.sol';
import '../storage/BasicStorage.sol';

contract UpgradableContract is BasicStorage, DelegateManagable {

  function UpgradableContract(address storageAddress, DelegateManagerInterface delegateManager) public
    BasicStorage(storageAddress)
    DelegateManagable(delegateManager)
  { }
}
