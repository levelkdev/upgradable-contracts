pragma solidity 0.4.18;

import './PersistentStorage.sol';
import './Proxy.sol';
import './DelegateManagerInterface.sol';
import './DelegateManagable.sol';

contract DelegatedStorage is PersistentStorage, DelegateManagable {

  KeyManagerInterface keyManager;

  function DelegatedStorage(KeyManagerInterface _keyManager, DelegateManagerInterface _delegateManager) public
    DelegateManagable(_delegateManager)
  {
    keyManager = _keyManager;
  }

  function scopedKey(bytes32 _key) internal view returns(bytes32) {
    return keccak256(keyManager.keyForContract(msg.sender), _key);
  }

  function getStorageDelegate() public view returns (address) {
    return delegateManager.delegateForContract(msg.sender);
  }
}
