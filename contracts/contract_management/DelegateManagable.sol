pragma solidity 0.4.18;

import './Proxy.sol';
import './DelegateManagerInterface.sol';

contract DelegateManagable is Proxy {
  DelegateManagerInterface delegateManager;

  function DelegateManagable(DelegateManagerInterface _delegateManager) public {
    delegateManager = _delegateManager;
  }

  // Overrides delegateAddress() in Proxy.sol
  function delegateAddress() internal view returns (address) {
    return delegateManager.delegateForContract(msg.sender);
  }
}
