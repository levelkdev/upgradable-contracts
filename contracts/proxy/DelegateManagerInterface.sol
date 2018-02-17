pragma solidity 0.4.18;

contract DelegateManagerInterface {
  function delegateForContract(address contract_) public view returns (address delegate);
}
