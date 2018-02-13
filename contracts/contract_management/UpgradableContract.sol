pragma solidity ^0.4.18;

import './DelegateManagable.sol';
import './DelegateManagerInterface.sol';
import './Storable.sol';

contract UpgradableContract is Storable, DelegateManagable {

  function UpgradableContract(address storageAddress, DelegateManagerInterface delegateManager) public
    Storable(storageAddress)
    DelegateManagable(delegateManager)
  { }
}
