pragma solidity 0.4.18;

import '../storage/PersistentStorage.sol';
import '../proxy/Proxy.sol';
import '../proxy/DelegateManagerInterface.sol';
import '../proxy/DelegateManagable.sol';
import './KeyManagerInterface.sol';

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
}
