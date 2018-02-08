pragma solidity 0.4.18;

contract Proxy {

  function delegateAddress() internal view returns (address) {
    // override to return address of delegate
    return address(0);
  }

  function () payable public {
    address target = delegateAddress();
    require(target != address(0));
    bytes memory data = msg.data;

    assembly {
      let result := delegatecall(gas, target, add(data, 0x20), mload(data), 0, 0)
      let size := returndatasize
      let ptr := mload(0x40)
      returndatacopy(ptr, 0, size)
      switch result
      case 0 { revert(ptr, size) }
      default { return(ptr, size) }
    }
  }
}
